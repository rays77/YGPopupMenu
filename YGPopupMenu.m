//
//  YGPopupMenu.m
//  iOutletShopping
//
//  Created by Ray on 2017/7/13.
//  Copyright © 2017年 aolaigo. All rights reserved.
//

#import "YGPopupMenu.h"

@interface YGPopupMenu ()

@property (nonatomic, strong) UIImageView *bgImageView;
/** 默认40 */
@property (nonatomic, assign) CGFloat popupMenuHeight;
@property (nonatomic, assign) CGFloat width;

@end

@implementation YGPopupMenu

+ (instancetype)menuItems:(NSArray<YGPopupMenuItem *> *)items
{
    return [[self alloc] initWithItems:items];
}

- (instancetype)initWithItems:(NSArray<YGPopupMenuItem *> *)items
{
    if (self = [super initWithFrame:CGRectZero]) {
        self.alpha = 0;
        _popupMenuHeight = 40;
        self.backgroundColor = [UIColor clearColor];
        self.items = items;
    }
    return self;
}

#pragma mark - Setter Method

- (void)setItems:(NSArray<YGPopupMenuItem *> *)items
{
    _items = items;
    
    [self createBackgroudImageView];
    [self createItems];
    [self resetRect];
}

- (void)createItems
{
    _width = 0;
    
    __weak typeof(self) weakSelf = self;
    
    // 创建按钮
    for (int i = 0; i < _items.count; ++i)
    {
        YGPopupMenuItem *item = _items[i];
        
        [item setPopupMenuItemBlock:^{
            // item被点击
            [weakSelf dismiss];
        }];
        
        // item
        item.frame = CGRectMake(i*(item.itemSize.width), 6, item.itemSize.width, _popupMenuHeight-6);
        [self addSubview:item];
        
        _width += item.bounds.size.width;
        
        // 分割线
        if (_items.count > 1 && i < _items.count-1) {
            
            UIView *line = ({
                UIView *l = [[UIView alloc] init];
                l.frame = CGRectMake(CGRectGetMaxX(item.frame), CGRectGetMinY(item.frame)+8, 1, _popupMenuHeight-CGRectGetMinY(item.frame)-16);
                l.backgroundColor = UIColorHex(0xF6F6F6);
                l;
            });
            [self addSubview:line];
            
            _width += line.bounds.size.width;
        }
    }
}

#pragma mark - rest popupMenu frame and backgroundImageView frame

- (void)resetRect
{
    // 重设 popupMenu 的宽高
    CGRect rect = self.frame;
    rect.size.width = _width;
    rect.size.height = _popupMenuHeight;
    self.frame = rect;
    
    // 重设 bgImageView 的frame
    self.bgImageView.frame = self.bounds;
}

- (void)createBackgroudImageView
{
    if (_bgImageView == nil) {
        _bgImageView = ({
            UIImageView *bg = [[UIImageView alloc] init];
            UIImage *image = [UIImage imageNamed:@"btn_assessment_center_copy_delete"];
            bg.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2)];
            bg;
        });
        [self addSubview:_bgImageView];
    }
}

#pragma mark - show and hidden popupMenu

- (void)showInView:(UIView *)showView targetView:(UIView *)targetView
{
    [showView addSubview:self];
    
    // 将item坐标转换到showView中
    CGPoint targetCenter = CGPointMake(targetView.bounds.origin.x + targetView.bounds.size.width/2, targetView.bounds.origin.y + targetView.bounds.size.height/2);
    CGPoint p = [targetView convertPoint:targetCenter toView:showView];
    p.x = p.x-self.bounds.size.width+targetView.bounds.size.width/2;
    
    // 先移到目标位置
    self.alpha = 0;
    CGRect rect = self.frame;
    rect.origin = p;
    self.frame = rect;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.alpha = 1;
        
        CGRect tmpRect = weakSelf.frame;
        tmpRect.origin = p;
        weakSelf.frame = tmpRect;
    }];
}

- (void)dismiss
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
