//
//  TUISystemMessageCell.m
//  UIKit
//
//  Created by annidyfeng on 2019/5/30.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "TUISystemMessageCell.h"
#import <TIMCommon/TIMDefine.h>
#import <TUICore/NSString+TUIUtil.h>

@interface TUISystemMessageCell ()
@property(nonatomic, strong) UILabel *messageLabel;
@property TUISystemMessageCellData *systemData;
@end

@implementation TUISystemMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.textColor = [UIColor d_systemGrayColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.layer.cornerRadius = 3;
        [_messageLabel.layer setMasksToBounds:YES];
        [self.container addSubview:_messageLabel];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)fillWithData:(TUISystemMessageCellData *)data;
{
    [super fillWithData:data];
    self.systemData = data;
    self.messageLabel.attributedText = data.attributedString;
    self.nameLabel.hidden = YES;
    self.avatarView.hidden = YES;
    self.retryView.hidden = YES;
    [self.indicator stopAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.container.center = self.contentView.center;
    self.messageLabel.frame = self.container.bounds;
}


#pragma mark - TUIMessageCellProtocol
+ (CGFloat)getEstimatedHeight:(TUIMessageCellData *)data {
    return 42.f;
}

+ (CGFloat)getHeight:(TUIMessageCellData *)data withWidth:(CGFloat)width {
    return [self getContentSize:data].height + kScale375(16);
}

+ (CGSize)getContentSize:(TUIMessageCellData *)data {
    NSAssert([data isKindOfClass:TUISystemMessageCellData.class], @"data must be kind of TUISystemMessageCellData");
    TUISystemMessageCellData *systemCellData = (TUISystemMessageCellData *)data;
    
    static CGSize maxSystemSize;
    if (CGSizeEqualToSize(maxSystemSize, CGSizeZero)) {
        maxSystemSize = CGSizeMake(TSystemMessageCell_Text_Width_Max, MAXFLOAT);
    }
    CGSize size = [systemCellData.attributedString.string textSizeIn:maxSystemSize font:systemCellData.contentFont];
    size.height += 10;
    size.width += 16;
    return size;
}

@end
