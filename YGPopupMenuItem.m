//
//  YGPopupMenuItem.m
//  iOutletShopping
//
//  Created by Ray on 2017/7/14.
//  Copyright © 2017年 aolaigo. All rights reserved.
//

#import "YGPopupMenuItem.h"

@implementation YGPopupMenuItem

#pragma mark - instance Method

+ (instancetype)itemTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[self alloc] initWithTitle:title target:target action:action];
}

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _title = title;
        _target = target;
        _action = action;
        
        [self createItem];
    }
    return self;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_popupMenuItemBlock) {
        _popupMenuItemBlock();
    }
    return YES;
}

- (void)createItem
{
    [self setTitle:_title forState:UIControlStateNormal];
    [self addTarget:_target action:_action forControlEvents:UIControlEventTouchUpInside];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
}

- (CGSize)itemSize
{
    return [_title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24]} context:nil].size;
}

@end
