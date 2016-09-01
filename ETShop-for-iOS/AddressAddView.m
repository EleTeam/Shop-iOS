//
//  AddressAddView.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/10/23.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "AddressAddView.h"
#import "ButtonUtil.h"
#import "Area.h"
#import "ActionSheetStringPicker.h"
#import "StringUtil.h"

@interface AddressAddView () <UITextFieldDelegate>
{
    NSString    *_areaId;
    NSArray     *_chainedAreas;
    NSInteger   _pickerSelectedIndex;
    
    UIImageView *_vReceiverIcon;
    UITextField *_vReceiverName;
    UILabel     *_vReceiverLine;
    
    UIImageView *_vMobileIcon;
    UITextField *_vMobile;
    UILabel     *_vMobileLine;
    
    UIImageView *_vPreAreaIcon;
    UILabel     *_vPreArea;
    UILabel     *_vPreAreaLine;
    
    UIImageView *_vAreaIcon;
    UIButton    *_vAreaBtn;
    UILabel     *_vAreaLine;
    
    UIImageView *_vDetailIcon;
    UITextField *_vDetail;
    UILabel     *_vDetailLine;
    
    UIButton    *_vSaveBtn;
}

@end

@implementation AddressAddView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    CGFloat iconWidth = 15;
    CGFloat topOffset = 15;
    CGFloat iconTopOffset = topOffset + 4;
    _vReceiverIcon = [UIImageView new];
    _vReceiverIcon.image = [UIImage imageNamed:@"icon_person_address"];
    [self addSubview:_vReceiverIcon];
    [_vReceiverIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(self).with.offset(iconTopOffset);
        make.width.mas_equalTo(iconWidth);
        make.height.mas_equalTo(iconWidth);
    }];
     
    _vReceiverName = [UITextField new];
    _vReceiverName.placeholder = @"收货人姓名";
    [self addSubview:_vReceiverName];
    [_vReceiverName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReceiverIcon.mas_right).with.offset(8);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self).with.offset(topOffset);
    }];
    _vReceiverName.delegate = self;
    
//    _vReceiverLine = [self createLine];
//    [self addSubview:_vReceiverLine];
//    [_vReceiverLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self);
//        make.trailing.equalTo(self);
//        make.height.mas_equalTo(1);
//    }];
    
    _vReceiverLine = [self lineWithTopItem:_vReceiverName];
    
    _vMobileIcon = [UIImageView new];
    _vMobileIcon.image = [UIImage imageNamed:@"icon_mobile"];
    [self addSubview:_vMobileIcon];
    [_vMobileIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReceiverIcon);
        make.top.equalTo(_vReceiverLine.mas_bottom).with.offset(iconTopOffset);
        make.width.mas_equalTo(iconWidth);
        make.height.mas_equalTo(iconWidth);
    }];
    
    _vMobile = [UITextField new];
    _vMobile.placeholder = @"手机号";
    _vMobile.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:_vMobile];
    [_vMobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReceiverName);
        make.right.equalTo(_vReceiverName);
        make.top.equalTo(_vReceiverLine.mas_bottom).with.offset(topOffset);
    }];
    _vMobile.delegate = self;
    
    _vMobileLine = [self lineWithTopItem:_vMobile];
    
    _vPreAreaIcon = [UIImageView new];
    _vPreAreaIcon.image = [UIImage imageNamed:@"icon_pen"];
    [self addSubview:_vPreAreaIcon];
    [_vPreAreaIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReceiverIcon);
        make.top.equalTo(_vMobileLine.mas_bottom).with.offset(iconTopOffset);
        make.width.mas_equalTo(iconWidth);
        make.height.mas_equalTo(iconWidth);
    }];
    
    _vPreArea = [UILabel new];
    _vPreArea.text = @"深圳市宝安区福永";
    [self addSubview:_vPreArea];
    [_vPreArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReceiverName);
        make.right.equalTo(_vReceiverName);
        make.top.equalTo(_vMobileLine.mas_bottom).with.offset(topOffset);
    }];
    
    _vPreAreaLine = [self lineWithTopItem:_vPreArea];
    
    _vAreaIcon = [UIImageView new];
    _vAreaIcon.image = [UIImage imageNamed:@"icon_pen"];
    [self addSubview:_vAreaIcon];
    [_vAreaIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReceiverIcon);
        make.top.equalTo(_vPreAreaLine.mas_bottom).with.offset(iconTopOffset+5);
        make.width.mas_equalTo(iconWidth);
        make.height.mas_equalTo(iconWidth);
    }];
    
    _vAreaBtn = [UIButton new];
    [_vAreaBtn setTitle:@"请选择街区" forState:UIControlStateNormal];
    [_vAreaBtn setTitleColor:kColorBlack forState:UIControlStateNormal];
    _vAreaBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _vAreaBtn.layer.borderWidth = 1;
    _vAreaBtn.layer.borderColor = kColorUnderline.CGColor;
    _vAreaBtn.layer.cornerRadius = 3;
    [self addSubview:_vAreaBtn];
    [_vAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReceiverName);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(_vPreAreaLine.mas_bottom).with.offset(topOffset);
    }];
    
    _vAreaLine = [self lineWithTopItem:_vAreaBtn];

    _vDetailIcon = [UIImageView new];
    _vDetailIcon.image = [UIImage imageNamed:@"icon_pen"];
    [self addSubview:_vDetailIcon];
    [_vDetailIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReceiverIcon);
        make.top.equalTo(_vAreaLine.mas_bottom).with.offset(iconTopOffset);
        make.width.mas_equalTo(iconWidth);
        make.height.mas_equalTo(iconWidth);
    }];

    _vDetail = [UITextField new];
    _vDetail.placeholder = @"房号(如11栋502)";
    [self addSubview:_vDetail];
    [_vDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vReceiverName);
        make.right.equalTo(_vReceiverName);
        make.top.equalTo(_vAreaLine.mas_bottom).with.offset(topOffset);
    }];
    _vDetail.delegate = self;
    
    _vDetailLine = [self lineWithTopItem:_vDetail];
    
    _vSaveBtn = [ButtonUtil redButtonWithTitle:@"保存收货地址"];
    [self addSubview:_vSaveBtn];
    [_vSaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(_vDetailLine.mas_bottom).with.offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [_vAreaBtn addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];
    [_vSaveBtn addTarget:self action:@selector(clickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (UILabel *)lineWithTopItem:(UIView *)topItem
{
    UILabel *line = [UILabel new];
    line.backgroundColor = kColorUnderline;
    
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.top.equalTo(topItem.mas_bottom).with.offset(10);
        make.height.mas_equalTo(1);
    }];
    return line;
}

- (void)setChainedAreas:(NSArray *)chainedAreas
{
    _chainedAreas = chainedAreas;
}

//打开地址选择器
- (void)openPicker:(UIButton *)sender
{
    //收起键盘
    [_vReceiverName resignFirstResponder];
    [_vMobile resignFirstResponder];
    [_vDetail resignFirstResponder];
    
    NSMutableArray *areaNames = [NSMutableArray new];
    [areaNames addObject:@"请选择街区"];
    
    //选取最后一级的区域
    NSArray *childrenArea;
    if (_chainedAreas.count > 0) {
        childrenArea = [_chainedAreas[_chainedAreas.count-1] objectForKey:@"children"];
        for (Area *area in childrenArea) {
            [areaNames addObject:area.name];
        }
    }
    
    __weak typeof (sender) weakSender = sender;
    ActionSheetStringPicker * picker = [[ActionSheetStringPicker alloc]
                                        initWithTitle:nil
                                        rows:areaNames
                                        initialSelection:_pickerSelectedIndex
                                        doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                            //更改按钮的文字
                                            [weakSender setTitle:selectedValue forState:UIControlStateNormal];
                                            _pickerSelectedIndex = selectedIndex;
                                            if (selectedIndex >= 1) {
                                                Area *area = childrenArea[selectedIndex-1];
                                                _areaId = area.id;
                                            }
                                        }
                                        cancelBlock:^(ActionSheetStringPicker *picker) {
                                            //NSLog(@"Block Picker Canceled");
                                        }
                                        origin:self];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:picker
                                                                    action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:picker
                                                                  action:nil];
    [picker setCancelButton:cancelButton];
    [picker setDoneButton:doneButton];
    [picker showActionSheetPicker];
}


- (void)clickSaveBtn
{
    NSString *areaId = _areaId;
    NSString *telephone = [StringUtil trim:_vMobile.text];
    NSString *detail = [StringUtil trim:_vDetail.text];
    NSString *fullname = [StringUtil trim:_vReceiverName.text];
    [self.delegate doClickSaveBtnWithAreaId:areaId
                                  telephone:telephone
                                     detail:detail
                                   fullname:fullname];
}

//点击return按钮收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_vReceiverName resignFirstResponder];
    [_vMobile resignFirstResponder];
    [_vDetail resignFirstResponder];
    return YES;
}

@end
