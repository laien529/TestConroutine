//
//  NetDetector.m
//  TestConroutine
//
//  Created by chengsc on 2021/3/16.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import "NetDetector.h"

@interface NetDetector () {
    
}

@end

@implementation NetDetector

+ (instancetype)sharedDetector {
    static dispatch_once_t onceToken;
    static NetDetector *detector;
    dispatch_once(&onceToken, ^{
        detector = [[NetDetector alloc] init];
    });
    return detector;
}



@end
