//
//  RunloopDemo.m
//  TestConroutine
//
//  Created by chengsc on 2019/11/29.
//  Copyright © 2019 chengsc. All rights reserved.
//

#import "RunloopDemo.h"

@implementation RunloopDemo

- (void)runloopObserveDemo {
    
    CFRunLoopObserverRef observeRef =  CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observeRef, kCFRunLoopCommonModes);
}
@end
