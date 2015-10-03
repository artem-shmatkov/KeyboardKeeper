//
//  ViewController.m
//  KeyboardKeeper
//
//  Created by Artem Shmatkov on 02/10/15.
//  Copyright © 2015 zakhej.com. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardKeeper.h"
#import "UIViewController+AnimateConstraintChange.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[KeyboardKeeper shared] addBlock:^(CGFloat heightDelta, CGFloat duration, BOOL show) {
        self.bottomConstraint.constant -= heightDelta;
        [self animateConstraintChangeWithDuration:duration];
    } forOwner:self.description];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[KeyboardKeeper shared] removeBlockForOwner:self.description];
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

@end
