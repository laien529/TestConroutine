//
//  NetworkDetectObserver.h
//  TestConroutine
//
//  Created by Cedric Cheng on 2021/3/26.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MetricsModel;
@protocol NetworkDetectObserver <NSObject>

- (MetricsModel*)fetchData;

@end

NS_ASSUME_NONNULL_END
