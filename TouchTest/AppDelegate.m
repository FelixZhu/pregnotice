//
//  AppDelegate.m
//  TouchTest
//
//  Created by Lion User on 23/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
//#import "ViewController.h"
//#import "MainScrollView.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)createEditableCopyOfDatabaseIfNeeded:(NSString *)database {
    // First, test for existence. 
    BOOL success=NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error; 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:database];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    { 
        NSLog(@"数据库存在");
        return;
    }
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:database];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) 
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        NSLog(@"Failed to create writable database file with message");
    }
    else 
    {
        NSLog(@"createEditableCopyOfDatabaseIfNeeded 初始化成功");
    } 
}

- (void)deleteEditableCopyOfDatabaseIfNeeded:(NSString *)database {
    
    BOOL success=NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error; 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:database];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    { 
        NSLog(@"数据库存在,准备删除");
    }
    // The writable database does not exist, so copy the default to the appropriate location.
//    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:database];
    success = [fileManager removeItemAtPath:writableDBPath error:&error];
    if(success)
    {
        NSLog(@"删除成功");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{        
    [self deleteEditableCopyOfDatabaseIfNeeded:@"careNoti.db"];
    [self createEditableCopyOfDatabaseIfNeeded:@"careNoti.db"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
