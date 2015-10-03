//
//  KeyboardKeeper.m
//  KeyboardKeeper
//
//  Created by Artem Shmatkov on 02/10/15.
//  Copyright © 2015 zakhej.com. All rights reserved.
//

#define kAddSelfObserver(selectorName, notificationName) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectorName) name:notificationName object:nil]

#import "KeyboardKeeper.h"

@interface KeyboardKeeper ()

@property (nonatomic, strong) NSMutableDictionary *blocks;
@property (nonatomic, strong) UIWindow *frontWindow;

@end

@implementation KeyboardKeeper

+ (KeyboardKeeper *)shared {
    static dispatch_once_t pred;
    static KeyboardKeeper *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [self new];
        [sharedInstance setup];
    });
    return sharedInstance;
}

- (void)setup {
    self.blocks = [NSMutableDictionary new];
    
    kAddSelfObserver(keyboardWillShow:, UIKeyboardWillShowNotification);
    kAddSelfObserver(keyboardWillHide:, UIKeyboardWillHideNotification);
}

#pragma mark - Keyboard handlers

- (void)keyboardWillShow:(NSNotification *)notification {
    [self processKeyboard:notification show:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self processKeyboard:notification show:NO];
}

- (void)processKeyboard:(NSNotification *)notification show:(BOOL)show {
    NSDictionary *userInfo = notification.userInfo;
    
    NSValue *s = userInfo[UIKeyboardFrameBeginUserInfoKey];
    NSValue *e = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect start = s.CGRectValue;
    CGRect end = e.CGRectValue;
    
    NSNumber *d = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGFloat duration = [d floatValue];
    
    self.frontWindow = [[UIApplication sharedApplication] keyWindow];
    
    start = [self.frontWindow convertRect:start fromView:self.frontWindow];
    end = [self.frontWindow convertRect:end fromView:self.frontWindow];
    
    // FIXME: when trying to hide keyboard while it is animating "show state" the "delta height" will be zero
    
    for (KeyboardKeeperBlock block in self.blocks.allValues) {
        if (block) {
            block((end.origin.y - start.origin.y), duration, show);
        }
    }
}

- (void)addBlock:(KeyboardKeeperBlock)block forOwner:(NSString *)owner {
    [self.blocks setObject:block forKey:owner];
}

- (void)removeBlockForOwner:(id)owner {
    [self.blocks removeObjectForKey:owner];
}

@end
