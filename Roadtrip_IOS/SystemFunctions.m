//
//  SystemFunctions.m
//  RoadtripIOS
//
//  Created by Krom on 8/18/14.
//  Copyright (c) 2014 SomethingOrOther. All rights reserved.
//

#import "SystemFunctions.h"

@implementation SystemFunctions

static NSString *kMDDirectionsURL = @"https://maps.googleapis.com/maps/api/directions/json?";
static NSString *apiKey=@"AIzaSyCTelYl1t2ED9vUQ5Xa3198XVA4GlL-qb0";
static NSString *photoRequestURL=@"https://maps.googleapis.com/maps/api/place/photo?";

NSString* routeFilePath=@"roadtrip.dat";
NSString* POIFilePath=@"poi.dat";
NSString* polyFilePath=@"poly.dat";

+(NSString*)kMDDirectionsURL{return kMDDirectionsURL;}
+(NSString*)apiKey{return apiKey;}
+(NSString*)photoRequestURL{return photoRequestURL;}

+(bool)FindFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:routeFilePath];
    if(path!=nil)
        return true;
    return false;
}

+(void)SaveData:(NSDictionary*)routePointsArray
{
    // Determine Path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:routeFilePath];
    
    // Archive Array
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:routePointsArray];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}


+(NSDictionary*)LoadRoutePointsData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:routeFilePath];
    NSDictionary *theArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if([theArray count]>0)
        return theArray;
    
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"starterMap"ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    NSString *json_string = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    theArray = [NSKeyedUnarchiver unarchiveObjectWithFile:json_string];
    
    if([theArray count]>0)
        return theArray;
    else
        return nil;
}

+(void)SavePOIData:(NSMutableArray*)routePointsArray
{
    // Determine Path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:POIFilePath];
    
    // Archive Array
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:routePointsArray];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}


+(NSMutableArray*)LoadPOIData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:POIFilePath];
    NSMutableArray *theArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if([theArray count]>0)
        return theArray;
    else
        return nil;
}

+(void)SavePolyArrayData:(NSMutableString*)polyString
{
    // Determine Path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:polyFilePath];
    
    // Archive Array
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:polyString];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}


+(NSMutableString*)LoadPolyArrayData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:polyFilePath];
    NSMutableString *newString = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return newString;
}
@end
