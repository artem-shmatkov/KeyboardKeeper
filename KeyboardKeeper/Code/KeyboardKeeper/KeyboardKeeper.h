//
//  KeyboardKeeper.h
//  KeyboardKeeper
//
//  Created by Artem Shmatkov on 02/10/15.
//  Copyright © 2015 zakhej.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^KeyboardKeeperBlock)(CGFloat heightDelta, CGFloat duration, BOOL show);

@interface KeyboardKeeper : NSObject

+ (KeyboardKeeper *)shared;
- (void)addBlock:(KeyboardKeeperBlock)block forOwner:(id)owner;
- (void)removeBlockForOwner:(id)owner;

@end
