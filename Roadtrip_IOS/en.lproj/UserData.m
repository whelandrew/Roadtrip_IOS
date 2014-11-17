//
//  UserData.m
//  RoadtripIOS
//
//  Created by Krom on 8/21/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import "UserData.h"

@implementation UserData

static float user_Lat;
static float user_Long;

+(void)SetUserLatitude:(float)latitude
{
    self.user_Lat=latitude;
}

+(float)GetUserLatitude
{
    return self.user_Lat;
}

+(void)SetUserLongitude:(float)longitude
{
    self.user_Long=longitude;
}

+(float)GetUserLongitude
{
    return self.user_long;
}
@end
