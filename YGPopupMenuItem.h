//
//  YGPopupMenuItem.h
//  iOutletShopping
//
//  Created by Ray on 2017/7/14.
//  Copyright © 2017年 aolaigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGPopupMenuItem : UIButton

@property (nonatomic, copy)  void(^popupMenuItemBlock)(void);
@property (nonatomic, weak, readonly) id target;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign, readonly) SEL action;
@property (nonatomic, assign, readonly) CGSize itemSize;

+ (instancetype)itemTitle:(NSString *)title target:(id)target action:(SEL)action;

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
