//
//  FaceMessageCell.m
//  UIKit
//
//  Created by annidyfeng on 2019/5/30.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "TUIFaceMessageCell.h"
#import <TIMCommon/TIMDefine.h>

@interface TUIFaceMessageCell ()
@end

@implementation TUIFaceMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _face = [[UIImageView alloc] init];
        _face.contentMode = UIViewContentModeScaleAspectFit;
        [self.container addSubview:_face];
        _face.mm_fill();
        _face.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.messageData.messageModifyReactsSize.height > 0) {
        if (self.tagView) {
            CGFloat topMargin = 10;
            CGFloat tagViewTopPadding = 6;
            CGFloat height = self.container.mm_h - topMargin - self.messageData.messageModifyReactsSize.height - tagViewTopPadding;
            _face.mm_height(height).mm_left(0).mm_top(topMargin).mm_width(self.container.mm_w);
            self.tagView.frame = CGRectMake(0, self.container.mm_h - self.messageData.messageModifyReactsSize.height - tagViewTopPadding,
                                            self.container.frame.size.width, self.messageData.messageModifyReactsSize.height);
        }
        self.bubbleView.hidden = NO;
    } else {
        CGFloat topMargin = 0;
        CGFloat height = self.container.mm_h;
        _face.mm_height(height).mm_left(0).mm_top(topMargin).mm_width(self.container.mm_w);
        self.bubbleView.hidden = YES;
    }
    _face.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}
- (void)fillWithData:(TUIFaceMessageCellData *)data {
    // set data
    [super fillWithData:data];
    self.faceData = data;

    _face.image = [[TUIImageCache sharedInstance] getFaceFromCache:data.path];
    ;
}

#pragma mark - TUIMessageCellProtocol
+ (CGSize)getContentSize:(TUIMessageCellData *)data {
    NSAssert([data isKindOfClass:TUIFaceMessageCellData.class], @"data must be kind of TUIFaceMessageCellData");
    TUIFaceMessageCellData *faceCellData = (TUIFaceMessageCellData *)data;
    UIImage *image = [[TUIImageCache sharedInstance] getFaceFromCache:faceCellData.path];
    CGFloat imageHeight = image.size.height;
    CGFloat imageWidth = image.size.width;
    if (imageHeight > TFaceMessageCell_Image_Height_Max) {
        imageHeight = TFaceMessageCell_Image_Height_Max;
        imageWidth = image.size.width / image.size.height * imageHeight;
    }
    if (imageWidth > TFaceMessageCell_Image_Width_Max) {
        imageWidth = TFaceMessageCell_Image_Width_Max;
        imageHeight = image.size.height / image.size.width * imageWidth;
    }
    return CGSizeMake(imageWidth, imageHeight);
}

@end
