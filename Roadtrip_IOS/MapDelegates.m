//
//  MapDelegates.m
//  RoadtripIOS
//
//  Created by Krom on 9/26/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import "MapDelegates.h"

@implementation MapDelegates

@synthesize delegate;

-(id)init
{
    self = [super init];
    return self;
}


-(void)showMap
{
    [delegate newMap:self];
}

@end
