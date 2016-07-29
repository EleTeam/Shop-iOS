//
//  PreorderNoteCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/11/01.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "PreorderNoteCell.h"
#import "StringUtil.h"

@interface PreorderNoteCell () <UITextFieldDelegate>
{
    UILabel *_vTitle;
    UITextField *_vNoteText;
}

@end

@implementation PreorderNoteCell

+ (CGFloat)height
{
    return 44;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _vTitle = [UILabel new];
    _vTitle.text = @"备注:";
    [self addSubview:_vTitle];
    [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.centerY.equalTo(self);
    }];
    
    _vNoteText = [UITextField new];
    _vNoteText.placeholder = @"在这里写下您的备注";
    [self addSubview:_vNoteText];
    [_vNoteText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vTitle.mas_right).with.offset(6);
        make.centerY.equalTo(self);
        make.width.equalTo(self);
    }];
    _vNoteText.delegate = self;
    
    return self;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *note = [StringUtil trim:textField.text];
    [self.delegate doNoteFinished:note];
}

//点击return按钮收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_vNoteText resignFirstResponder];
    return YES;
}

- (void)closeKeyboard
{
    if (![_vNoteText isExclusiveTouch]) {
        [_vNoteText resignFirstResponder];
    }
}

@end
