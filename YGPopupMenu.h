//
//  YGPopupMenu.h
//  iOutletShopping
//
//  Created by Ray on 2017/7/13.
//  Copyright © 2017年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGPopupMenuItem.h"

@interface YGPopupMenu : UIView

@property (nonatomic, strong) NSArray <YGPopupMenuItem *> *items;

+ (instancetype)menuItems:(NSArray<YGPopupMenuItem *> *)items;
- (instancetype)initWithItems:(NSArray<YGPopupMenuItem *> *)items;

- (void)showInView:(UIView *)showView targetView:(UIView *)targetView;
- (void)dismiss;

@end
