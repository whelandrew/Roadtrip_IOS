//
//  MapFunctions.m
//  RoadtripIOS
//
//  Created by Krom on 8/15/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import "MapFunctions.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation MapFunctions

static NSDictionary *POIjSon;
static NSMutableArray *POIArray;

-(void)mapLoadError
{
    NSLog(@"Map Failed To Load");
}

+(NSDictionary*)getMapSync:(NSDictionary*)routesDic
{
    NSString* _origin=@"San+Francisco+CA";//[org stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* _destination=@"Las+Angeles+CA";//[des stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    if(routesDic!=nil)
    {
        _origin=[[MapFunctions GetOriginName:routesDic] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        _destination=[[MapFunctions GetDestinationName:routesDic] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    }
    NSString *googleMapUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=false&mode=driving&region=es",[SystemFunctions kMDDirectionsURL],_origin,_destination];//,apiKey];
    
    NSURLRequest *googleMapUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:googleMapUrlString]];
    NSError *error = nil;
    NSURLResponse * response;
    
    NSData * data = [NSURLConnection sendSynchronousRequest:googleMapUrl returningResponse:&response error:&error];
    if (error == nil)
    {
        return [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    }
    return nil;
}

-(void)getMapDataDelegate:(NSString *)org des:(NSString*)des// newMap:(NSDictionary*)newMap
{
    NSString* _origin=[org stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString* _destination=[des stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    NSString *googleMapUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=false&mode=driving&region=es",[SystemFunctions kMDDirectionsURL],_origin,_destination];//,apiKey];
    
    NSURLRequest *googleMapUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:googleMapUrlString]];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:googleMapUrl queue: queue completionHandler:
     ^(NSURLResponse *response,
       NSData *data,
       NSError *error)
        {
            if([data length]>0 && error==nil)
            {
               // mapData = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
//                NSLog(@"RECEIVED NEW MAP");
  ///              [delegate newMap:self];
                
            }
            else if ([data length]==0&&error==nil)
            {
                NSLog(@"NO MAP DATA");
            }
            else if(error!=nil)
            {
                NSLog(@"Error = %@",error);
                [self mapLoadError];
            }
        }
     ];
}

-(NSDictionary*)getNewRouteData:(NSString *)org des:(NSString*)des newRoute:(NSDictionary*)newRoute
{
    NSString* _origin=[org stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString* _destination=[des stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *googleMapUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=false&mode=driving&region=es",[SystemFunctions kMDDirectionsURL],_origin,_destination];
    
    NSURLRequest *googleMapUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:googleMapUrlString]];
    
    NSData *gmjSon=[NSURLConnection sendSynchronousRequest:googleMapUrl returningResponse:nil error:nil];
    
    NSError *jsonParsingError = nil;
    
    newRoute = [NSJSONSerialization JSONObjectWithData:gmjSon options: NSJSONReadingMutableContainers error: &jsonParsingError];
#ifdef DEBUG
    NSLog(@"error_message : %@",[newRoute objectForKey:@"error_message"]);
#endif
    if(jsonParsingError!=nil)
    {
        NSLog(@"%@",[jsonParsingError localizedDescription]);
#ifdef DEBUG
        NSLog(@"%@",[jsonParsingError userInfo]);
#endif
        return nil;
    }
    else
        NSLog(@"NEW MAP DATA FOUND!");
    return newRoute;
}

-(BOOL)getPOIData:(NSString *)lat lon:(NSString*)lon
{
    NSString *googleMapUrlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&rankby=distance&types=bar&key=%@",lat,lon,[SystemFunctions apiKey]];
   
    NSURLRequest *googleMapUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:googleMapUrlString]];
    NSData *gmjSon=[NSURLConnection sendSynchronousRequest:googleMapUrl returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    
    POIjSon = [NSJSONSerialization JSONObjectWithData:gmjSon options: NSJSONReadingMutableContainers error: &jsonParsingError];
#ifdef DEBUG
    NSLog(@"error_message : %@",[POIjSon objectForKey:@"error_message"]);
#endif
    if(jsonParsingError!=nil)
    {
        NSLog(@"%@",[jsonParsingError localizedDescription]);
#ifdef DEBUG
        NSLog(@"%@",[jsonParsingError userInfo]);
#endif
        return false;
    }
    else
        NSLog(@"POINTS OF INTEREST FOUND!");
    return true;
}


+(GMSMapView*)setupMap
{
    GMSMapView *newMap = [[GMSMapView alloc]init];
    newMap.multipleTouchEnabled=YES;
    newMap.mapType=kGMSTypeNormal;
    
    return newMap;
}

+(GMSMarker*)placeMarker:(float)latitude longitude:(float)longitude;
{
    GMSMarker *marker=[[GMSMarker alloc]init];
    
    marker.position=CLLocationCoordinate2DMake(latitude,longitude);
    marker.appearAnimation=kGMSMarkerAnimationPop;
    marker.title=@"Mah House";
    marker.snippet=@"Oh yeah!";
    marker.flat=true;
    marker.groundAnchor=CGPointMake(.5, .5);
    
    return marker;
}

+(GMSCameraPosition*)focusOnPoint:(float)latitude longitude:(float)longitude zoom:(int)zoom
{
    GMSCameraPosition *camera=[GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:zoom];
    return camera;
}

-(GMSCameraPosition*)focusOnOrigin:(int)zoom mapjSon:(NSDictionary*)mapjSon
{
    GMSCameraPosition *camera=[[GMSCameraPosition alloc]init];
    
    NSString *_lat=mapjSon[@"routes"][0][@"legs"][0][@"start_location"][@"lat"];
    NSString *_lng=mapjSon[@"routes"][0][@"legs"][0][@"start_location"][@"lng"];
    
    float _latFloat=[_lat floatValue];
    float _lngFloat=[_lng floatValue];
    
    camera=[GMSCameraPosition cameraWithLatitude:_latFloat longitude:_lngFloat zoom:zoom];
    return camera;
}

+(NSString*)GetOriginName:(NSDictionary*)mapjSon
{
    return mapjSon[@"routes"][0][@"legs"][0][@"start_address"];
}

+(NSString*)GetDestinationName:(NSDictionary*)mapjSon
{
    return mapjSon[@"routes"][0][@"legs"][0][@"end_address"];
}

+(CLLocationCoordinate2D)GetOriginLocation:(NSDictionary*)mapjSon
{
    NSString *_lat=mapjSon[@"routes"][0][@"legs"][0][@"start_location"][@"lat"];
    NSString *_lng=mapjSon[@"routes"][0][@"legs"][0][@"start_location"][@"lng"];
    
    CLLocationCoordinate2D locations;
    locations.latitude=[_lat floatValue];
    locations.longitude=[_lng floatValue];
    return locations;
}

-(GMSCameraPosition*)focusOnDestination:(int)zoom mapjSon:(NSDictionary*)mapjSon
{
    GMSCameraPosition *camera=[[GMSCameraPosition alloc]init];
    
    NSString *_lat=mapjSon[@"legs"][0][@"end_location"][@"lat"];
    NSString *_lng=mapjSon[@"legs"][0][@"end_location"][@"lat"];
    
    float _latFloat=[_lat floatValue];
    float _lngFloat=[_lng floatValue];
    
    camera=[GMSCameraPosition cameraWithLatitude:_latFloat longitude:_lngFloat zoom:zoom];
    return camera;
}

+(GMSPolyline*)getRoutes:(NSDictionary*)mapjSon
{
    if ([mapjSon count] > 0)
    {
        NSString *points=mapjSon[@"polyline"][@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:points];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];//[self GetPolylinePath:path];//[GMSPolyline polylineWithPath:path];
        return polyline;
    }
    else
        NSLog(@"COULD NOT FIND ANY ROUTE ARRAYS");

    return nil;
}

+(GMSPath*)getRouteOverview:(NSDictionary*)mapjSon
{
    GMSPath *path=[[GMSPath alloc]init];
    if ([mapjSon count] > 0)
    {
        NSString *polyString=mapjSon[@"routes"][0][@"overview_polyline"][@"points"];
        path = [GMSPath pathFromEncodedPath:polyString];
        return path;
    }
    else
        NSLog(@"COULD NOT FIND ANY ROUTE ARRAYS IN roadtrip.dat ");
    
    return nil;
}

+(NSMutableString*)getRoutesString:(NSDictionary*)mapjSon
{
    //NSMutableArray *routes=mapjSon[@"routes"];
    if ([mapjSon count] > 0)
    {
        NSMutableArray *routePolyline=mapjSon[@"legs"][0][@"steps"];
        NSMutableString *polyString=[[NSMutableString alloc]init];
        
        for(int i=0;i<routePolyline.count;i++)
        {
            NSString *newString=routePolyline[i][@"polyline"][@"points"];
            [polyString appendString:newString];
        }
        return polyString;
    }
    else
        NSLog(@"COULD NOT FIND ANY ROUTE ARRAYS IN roadtrip.dat ");

    return nil;
}

-(NSDictionary*)getRoutesArray
{
    //return mapjSon;
    return nil;
}

-(NSMutableArray*)getPOIArray
{
    return [POIjSon objectForKey:@"results"];
}

-(UIImageView*)GetPOIPhoto:(NSDictionary*)POIDict
{
    NSArray *photoReference=[POIDict objectForKey:@"photos"];
    NSString *imageReference=photoReference[0][@"photo_reference"];
    NSString *maxWidth=photoReference[0][@"width"];
    NSString *maxHeight=photoReference[0][@"height"];
    
    NSString *requestURL=[NSString stringWithFormat:@"%@maxwidth=%@&maxheight=%@&photoreference=%@&key=%@",[SystemFunctions photoRequestURL],maxWidth,maxHeight,imageReference,[SystemFunctions apiKey]];
    NSURLRequest *googlePhotoUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    NSData *imageData=[NSURLConnection sendSynchronousRequest:googlePhotoUrl returningResponse:nil error:nil];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageWithData:imageData];
    return imageView;
}

-(UIImageView*)GetPOIIcon:(NSDictionary*)imageDic
{
    NSString *iconURL=[imageDic objectForKey:@"icon"];
    NSURLRequest *googleIconUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:iconURL]];
    NSData *imageData=[NSURLConnection sendSynchronousRequest:googleIconUrl returningResponse:nil error:nil];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageWithData:imageData];
    return imageView;
}

-(NSString*)GetPOIName:(NSDictionary*)imageDic
{
    NSString *name=[imageDic objectForKey:@"name"];
    return name;
}

+(GMSPolyline*)GetPolylinePath:(GMSPath*)polyPath
{
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:polyPath];
    polyline.geodesic=true;
    polyline.strokeWidth=3;
    polyline.strokeColor=[UIColor yellowColor];
    return polyline;
}

-(NSDictionary*)FillmapjSonFromFile:(NSDictionary*)loadedFile
{
    if(loadedFile==nil)
        return nil;
    if((loadedFile[@"routes"][0])==nil)
        return nil;
    return loadedFile;
}

-(NSDictionary*)LoadSavedData
{
    NSDictionary *newDataArray=[SystemFunctions LoadRoutePointsData];
    if(newDataArray!=nil)
    {
        [self FillmapjSonFromFile:newDataArray];
        return newDataArray;
    }
    NSLog(@"COULD NOT FIND SAVED DATA");
    return nil;
}
@end
