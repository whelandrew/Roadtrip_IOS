//
//  SystemFunctions.h
//  RoadtripIOS
//
//  Created by Krom on 8/18/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemFunctions : NSObject

+(bool)FindFilePath;

+(void)SaveData:(NSDictionary*)routePointsArray;
+(void)SavePOIData:(NSMutableArray*)routePointsArray;
+(void)SavePolyArrayData:(NSMutableString*)polyArray;

+(NSDictionary*)LoadRoutePointsData;
+(NSMutableArray*)LoadPOIData;
+(NSMutableString*)LoadPolyArrayData;

+(NSString*)kMDDirectionsURL;
+(NSString*)apiKey;
+(NSString*)photoRequestURL;
@end