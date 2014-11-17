//
//  ConfirmRouteViewController.m
//  RoadtripIOS
//
//  Created by Krom on 8/15/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import "ConfirmRouteViewController.h"

@interface ConfirmRouteViewController () <GMSMapViewDelegate>

@end

@implementation ConfirmRouteViewController

GMSPolyline *poly;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:(BOOL)animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    NSDictionary *newRoute=[MapFunctions getNewRouteData:[RouteViewController GetFromAddress] des:[RouteViewController GetToAddress]];
    
    if(newRoute!=nil)
    {
        NSLog(@"NEW MAP DATA RECEIVED");
        [self.confirmMapView clear];
        NSMutableArray *routeArray=newRoute[@"routes"][0];
        
        GMSPath *path = [MapFunctions getRouteOverview:routeArray];
        GMSPolyline *newPolyline=[MapFunctions GetPolylinePath:path];
        poly=newPolyline;
        poly.map=self.confirmMapView;
        
        self.confirmMapView.camera=[MapFunctions focusOnOrigin:routeArray zoom:6];
        
        self.confirmMapView=[MapFunctions setupMap];
        self.confirmMapView.delegate=self;
    }
    else
        return;
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)confirmRoute:(id)sender
{
    //[SystemFunctions SaveData:[MapFunctions getRoutesArray]];
}

@end
