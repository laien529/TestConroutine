//
//  ViewController.m
//  TestConroutine
//
//  Created by chengsc on 2019/8/23.
//  Copyright © 2019 chengsc. All rights reserved.
//

#import "ViewController.h"
#import <coobjc/coobjc.h>
#import "RunloopDemo.h"
#import "TestWeakHttpController.h"

@interface ViewController () {
    NSArray *menuArray;
}

@end

@implementation ViewController

#pragma --mark -LifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blueColor;
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"menu_cell"];
    menuArray = @[@"WeakHttpTest"
//                  ,@"Coroutine"
    ];
    [self.tableView reloadData];
//    [self testCoroutine];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ids = @"menu_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ids forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ids];
    }
    cell.textLabel.text = menuArray[indexPath.row];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            TestWeakHttpController *test = [[TestWeakHttpController alloc] initWithNibName:@"TestWeakHttpController" bundle:nil];
            [self.navigationController pushViewController:test animated:YES];
            break;
        }
        case 1:
        {
            
            break;
        }
        default:
            break;
    }
}

- (void)testCoroutine {
    //    co_launch(^{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self sleepTime:2];
        NSLog(@"%@",@"zzzzzz");
        [self sleepTime:6];
        NSLog(@"%@",@"zzzzzz2");
    });
    
    //    });
    co_launch(^{
        [self sleepTime:5];
        NSLog(@"%@",@"zzzzzz3");
        [self sleepTime:10];
        NSLog(@"%@",@"zzzzzz4");
    });
    RunloopDemo *runloop = [RunloopDemo alloc];
    [runloop runloopObserveDemo];
}



- (void)sleepTime:(NSInteger)t {
    [NSThread sleepForTimeInterval:t];
}

- (void)tableView:(nonnull UITableView *)tableView prefetchRowsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths {
    
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeZero;
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return YES;
}

- (void)updateFocusIfNeeded {
    
}

@end
