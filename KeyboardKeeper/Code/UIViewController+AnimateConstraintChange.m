//
//  UIViewController+AnimateConstraintChange.m
//  KeyboardKeeper
//
//  Created by Artem Shmatkov on 03/10/15.
//  Copyright © 2015 zakhej.com. All rights reserved.
//

#import "UIViewController+AnimateConstraintChange.h"

@implementation UIViewController (AnimateConstraintChange)

- (void)animateConstraintChangeWithDuration:(CGFloat)duration {
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:nil];
}

@end
