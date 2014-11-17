//
//  UserData.h
//  RoadtripIOS
//
//  Created by Krom on 8/21/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemFunctions.h"
@interface UserData : NSObject
+(void)SetUserLatitude:(float)latitude;
+(void)SetUserLongitude:(float)longitude;

+(float)GetUserLatitude;
+(float)GetUserLongitude;
@end
