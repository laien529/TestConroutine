//
//  TestWeakHttpController.m
//  TestConroutine
//
//  Created by chengsc on 2021/3/15.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import "TestWeakHttpController.h"
#import "NetworkModel.h"

@interface TestWeakHttpController ()
@property (weak, nonatomic) IBOutlet UILabel *lbHttpRtt;
@property (weak, nonatomic) IBOutlet UILabel *lbThroughput;

@end

@implementation TestWeakHttpController

- (IBAction)requestOnce:(id)sender {
    [self requestOnce];
}
- (IBAction)requestBatch:(id)sender {
    [self requestBatch];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view from its nib.
    [[NetDetector sharedDetector] registService:self];
}

- (void)viewDidAppear:(BOOL)animated {
    //@"https://img.alicdn.com/tfs/TB148AkSFXXXXa3apXXXXXXXXXX-1130-500.jpg_q100.jpg_.webp"
    //http://172.28.125.111:8888/json/startConfig.json?r=%f
    //@"http://192.168.50.93:8080/startConfig.json?r=%f"
    [self requestOnce];
}

- (void)requestOnce {
    [[NetworkModel sharedModel] requestWithMethod:@"GET" url:[NSString stringWithFormat:@"http://172.28.125.111:8888/json/startConfig.json?r=%f", [NSDate timeIntervalSinceReferenceDate]] params:@{}];
}

- (void)requestBatch {
    NSInteger times = 10;
    for (int i = 0; i < times; i++) {
        [NSThread sleepForTimeInterval:0.1];
        [self requestOnce];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma - --mark NetDetectDelegate

- (void)statusDidChanged:(NetStatus *)status {
    switch (status.netStatus) {
        case NetDetectStatusWeak:{
            self.view.backgroundColor = UIColor.redColor;
            break;
        }
        case NetDetectStatusGreat:{
            self.view.backgroundColor = UIColor.greenColor;

            break;
        }
        case NetDetectStatusNormal:{
            self.view.backgroundColor = UIColor.whiteColor;
            break;
        }
        case NetDetectStatusUnknown:{
            self.view.backgroundColor = UIColor.lightGrayColor;
            break;
        }
        default:
            break;
    }
}

- (void)dealloc {
    [[DetectorPolicy sharedPolicy] stopDetectTrigger];
}
@end
