//
//  MapDelegates.h
//  RoadtripIOS
//
//  Created by Krom on 9/26/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@class MapDelegates;

@protocol MapDelegat
-(void)newMap:(MapDelegates*)mapDelegate;

@end

@interface MapDelegates : NSObject{}

@property (nonatomic,assign) id delegate;
-(void)showMap;

@end
