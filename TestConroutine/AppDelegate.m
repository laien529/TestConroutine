//
//  AppDelegate.m
//  TestConroutine
//
//  Created by chengsc on 2019/8/23.
//  Copyright © 2019 chengsc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TestWeakHttpController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.blueColor;
   
    ViewController *root = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    [self.window addSubview:root.view];
    return YES;
}



@end
