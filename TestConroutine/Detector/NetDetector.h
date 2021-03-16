//
//  NetDetector.h
//  TestConroutine
//
//  Created by chengsc on 2021/3/16.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDetectorDelegate.h"
#import "NetworkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetDetector : NSObject

@property(nonatomic, copy)id<NetworkDetectorDelegate> delegate;

+ (instancetype)sharedDetector;

@end

NS_ASSUME_NONNULL_END
