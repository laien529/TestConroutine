//
//  TestWeakHttpController.m
//  TestConroutine
//
//  Created by chengsc on 2021/3/15.
//  Copyright © 2021 chengsc. All rights reserved.
//

#import "TestWeakHttpController.h"

@interface TestWeakHttpController ()
@property (weak, nonatomic) IBOutlet UILabel *lbHttpRtt;
@property (weak, nonatomic) IBOutlet UILabel *lbThroughput;

@end

@implementation TestWeakHttpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.greenColor;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    
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
@end
