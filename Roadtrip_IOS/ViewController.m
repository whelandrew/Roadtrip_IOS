//
//  ViewController.m
//  Roadtrip_IOS
//
//  Created by Krom on 8/14/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import "ViewController.h"
@implementation ViewController
{
    NSDictionary *routesDic;
    Reachability *internetRechableFoo;
    float startZoom;
    
    GMSMarker* marker;
    GMSPath *polyPath;
    GMSPolyline *polyline;
    GMSCameraPosition *camera;
}

@synthesize delegate;

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewDidLoad
{
    [self testInternetConnection];
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    self.delegate=self;
    
    if(routesDic==nil)
    {
        routesDic=[MapFunctions getMapSync:routesDic];
        [self SetGMSDefaults];
    }
}

-(void)SetGMSDefaults;
{
    startZoom=14;
    
    GMSMapView *newView=[[GMSMapView init]alloc];
    
    CLLocationCoordinate2D origin=[MapFunctions GetOriginLocation:routesDic];
    
    camera=[MapFunctions focusOnPoint:origin.latitude longitude:origin.longitude zoom:startZoom];
    newView=[GMSMapView mapWithFrame:self.gmsMapViewUI.bounds camera:camera];

    marker=[MapFunctions placeMarker:origin.latitude longitude:origin.longitude];
    marker.map=newView;
    
    
    /*
    self.gmsMapViewUI.multipleTouchEnabled=YES;
    self.gmsMapViewUI.mapType=kGMSTypeNormal;
    
    polyPath=[MapFunctions getRouteOverview:routesDic];
    polyline=[MapFunctions GetPolylinePath:polyPath];
    
    polyline = [GMSPolyline polylineWithPath:polyPath];
    polyline.map=self.gmsMapViewUI;
    

    
    self.gmsMapViewUI.delegate=self.delegate;//self.delegate;
    //self.gmsMapViewUI=vc.gmsMapViewUI;
    //self.view=self.gmsMapViewUI;
     */
}

-(void)newMapDelegate:(ViewController*)vc
{
    //[self LoadMainMap:vc];
}

-(void)getMapDataDelegate
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
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:googleMapUrl queue: queue completionHandler:
     ^(NSURLResponse *response,
       NSData *data,
       NSError *error)
     {
         if([data length]>0 && error==nil)
         {
             routesDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
             [self SetGMSDefaults];
             [delegate newMapDelegate:self];
         }
         else if ([data length]==0&&error==nil)
         {
             NSLog(@"NO MAP DATA");
         }
         else if(error!=nil)
         {
             NSLog(@"Error = %@",error);
         }
     }
    ];
}

-(void)LoadMainMap:(ViewController*)vc
{
    CLLocationCoordinate2D tempCoords=[MapFunctions GetOriginLocation:routesDic];
    NSLog(@"%f %f",tempCoords.latitude,tempCoords.longitude);

    //marker.position=tempCoords;
    
    //[vc.gmsMapViewUI animateToLocation:tempCoords];
    //[vc.gmsMapViewUI animateToZoom:startZoom];
    
    //polyline.map=self.gmsMapViewUI;
}

-(BOOL)LoadPOI
{
    /*
    NSMutableArray *POIArray=[MapFunctions getPOIArray];
    [SystemFunctions SavePOIData:POIArray];
    c->POIjSon=[SystemFunctions LoadPOIData];
    
    if(c->POIjSon!=nil)
    {
        NSDictionary *POIDict = [c->POIjSon objectAtIndex:0];
        
        UIImageView *iv=[MapFunctions GetPOIIcon:POIDict];
        c->_imageview_PlaceIcon.image=iv.image;
        
        c->_label_PlaceName.text=[MapFunctions GetPOIName:POIDict];
        
        UIImageView *photo=[MapFunctions GetPOIPhoto:POIDict];
        [c->_POI_UIButton setBackgroundImage:photo.image forState:UIControlStateNormal];
        return true;
    }
     */
    return false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoadMap:(id)sender
{
    
}

- (IBAction)DisplayPOI:(id)sender
{
}

- (IBAction)LoadOptions:(id)sender
{
}

- (IBAction)PlotNewRoute:(id)sender
{
    //UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    //UIViewController *vc=[mainStoryBoard instantiateViewControllerWithIdentifier:@"routeView"];
    //[self presentViewController:vc animated:TRUE completion:nil];
}

-(void)testInternetConnection
{
    internetRechableFoo=[Reachability reachabilityWithHostName:@"www.google.com"];
    
    //Internet is reachable
    internetRechableFoo.reachableBlock=^(Reachability *reach)
    {
        //update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{NSLog(@"INTERNET CONNECTION FOUND!");});
    };
    
    //Internet is unreachable
    internetRechableFoo.unreachableBlock=^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{NSLog(@"INTERNET CONNECTION NOT FOUND!");});
    };
}

@end
