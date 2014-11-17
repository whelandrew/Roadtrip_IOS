//
//  MapFunctions.h
//  RoadtripIOS
//
//  Created by Krom on 8/15/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#include "UserData.h"
#include "SystemFunctions.h"


@class MapFunctions;

@interface MapFunctions : GMSMapView<GMSMapViewDelegate>

+(GMSMapView*)setupMap;

+(GMSCameraPosition*)focusOnPoint:(float)latitude longitude:(float)longitude zoom:(int)zoom;
-(GMSCameraPosition*)focusOnOrigin:(int)zoom mapjSon:(NSDictionary*)mapjSon;
-(GMSCameraPosition*)focusOnDestination:(int)zoom mapjSon:(NSDictionary*)mapjSon;

+(GMSMarker*)placeMarker:(float)latitude longitude:(float)longitude;

-(void)getMapDataDelegate:(NSString *)org des:(NSString*)des;// newMap:(NSDictionary*)newMap;
-(NSDictionary*)getNewRouteData:(NSString *)org des:(NSString*)des newRoute:(NSDictionary*)newRoute;
-(BOOL)getPOIData:(NSString *)lat lon:(NSString*)lon;

+(GMSPolyline*)getRoutes:(NSDictionary*)mapjSon;
+(NSDictionary*)getRoutesString:(NSDictionary*)mapjSon;

+(GMSPath*)getRouteOverview:(NSDictionary*)mapjSon;

-(NSDictionary*)getRoutesArray;
-(NSMutableArray*)getPOIArray;
-(UIImageView*)GetPOIPhoto:(NSDictionary*)POIDict;

+(CLLocationCoordinate2D)GetOriginLocation:(NSDictionary*)mapjSon;

-(UIImageView*)GetPOIIcon:(NSDictionary*)imageDic;
-(NSString*)GetPOIName:(NSDictionary*)imageDic;

+(GMSPolyline*)GetPolylinePath:(GMSPath*)polyPath;

-(NSDictionary*)FillmapjSonFromFile:(NSDictionary*)loadedFile;
-(NSDictionary*)LoadSavedData;

-(void)mapLoadError;

+(NSString*)GetOriginName:(NSDictionary*)mapjSon;
+(NSString*)GetDestinationName:(NSDictionary*)mapjSon;

+(NSDictionary*)getMapSync:(NSDictionary*)routesDic;

@end