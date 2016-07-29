//
//  ProductAttrCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/29.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "ProductAttrCell.h"
#import "ProductInfoCell.h"
#import "ProductAttr.h"
#import "ProductAttrItem.h"
#import "ProductAttrItemValue.h"
//#import "ActionSheetPicker.h"
#import "ActionSheetStringPicker.h"

@interface ProductAttrCell ()
{
    UILabel *_titleView;
    Product *_product;
    ProductForm *_productForm;
}

@end

@implementation ProductAttrCell

+ (CGFloat)heightWithProduct:(Product *)product
{
    CGFloat height = 0;
    CGFloat extraHeight = 40;
    CGFloat attrItemHeight = 40;
    NSInteger count = product.productAttrs.count;
    if (count > 0) {
        height = extraHeight + attrItemHeight * count;
    }
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier product:(Product *)product productForm:(ProductForm *)productForm
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _product = product;
        _productForm = productForm;
        
        //padding
        CGFloat leftMargin = 8;
        CGFloat topMargin = 10;
        CGFloat marginHeight = 12;
        
        if (product.productAttrs.count > 0) {
            //titleView
            CGFloat titleViewHeight = 18;
            CGFloat productInfoCellHeight = [ProductInfoCell heightWithNoShortDescription];
            if (product.short_description.length > 0)
                productInfoCellHeight = [ProductInfoCell heightWithShortDescription];
            _titleView = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, topMargin, kScreenWidth, titleViewHeight)];
            _titleView.text = @"请选择您的口味";
            
            //attr item view
            CGFloat itemNameLeftMargin = 20;
            CGFloat itemNameViewWidth = 50;
            CGFloat itemNameViewHeight = 25;
            int i = 0;
            for (ProductAttr *item in product.productAttrs) {
                UILabel *itemNameView = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin + itemNameLeftMargin, (topMargin + titleViewHeight + marginHeight) * (i+1) , itemNameViewWidth, itemNameViewHeight)];
                ProductAttrItem *attrItem = item.productAttrItem;
                itemNameView.text = attrItem.print_name;
                
                //动态添加属性选择器
                CGFloat valueViewLeftMargin = 5;
                CGFloat valueViewWidth = 190;
                UIButton *valueView = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin + itemNameLeftMargin + itemNameViewWidth + valueViewLeftMargin, (topMargin + titleViewHeight + marginHeight) * (i+1), valueViewWidth, itemNameViewHeight)];
                [valueView addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];
                if (attrItem.productAttrItemValues.count > 0) {
                    ProductAttrItemValue *value = attrItem.productAttrItemValues[0];
                    [valueView setTitle:value.name forState:UIControlStateNormal];
                    [valueView setTitleColor:kColorMainBlack forState:UIControlStateNormal];
                    valueView.layer.borderWidth = 1;
                    valueView.layer.cornerRadius = 4;
                    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                    CGColorRef colorRef = CGColorCreate(colorSpace,(CGFloat[]){ 0.5, 0.5, 0.5, 0.5 });
                    valueView.layer.borderColor = colorRef;
                    //valueView.backgroundColor = kBackgoundColor;
                }
                valueView.tag = i;//标记是第几个属性
                
                [self addSubview:itemNameView];
                [self addSubview:valueView];
                i++;
            }
            
            
            [self addSubview:_titleView];
        }
    }
    return self;
}


#pragma mark - 属性选择器

//打开属性选择器
- (void)openPicker:(UIButton *)sender
{
    NSInteger itemIndex = sender.tag; //第几个属性被点击
    
    if (_product.productAttrs.count < itemIndex+1) {
        return;
    }
    
    ProductAttr *attr = _product.productAttrs[itemIndex];
    ProductAttrItem *item = attr.productAttrItem;
    NSArray *values = item.productAttrItemValues;
    NSMutableArray *valueNames = [[NSMutableArray alloc] init];
    for (ProductAttrItemValue *value in values) {
        NSString *valueName = value.name;
        if (value.price && [value.price floatValue]>0) {
            valueName = [NSString stringWithFormat:@"%@  +%@元", valueName, [FormatUtil formatPrice:value.price]];
        }
        [valueNames addObject:valueName];
    }
    
    __weak typeof (sender) weakSender = sender;
    __weak typeof (_productForm) weakProductForm = _productForm;
    int initValueIndex = 0;
    if (_productForm.attrIds.count > itemIndex) {
        NSDictionary *attrId = _productForm.attrIds[itemIndex];
        NSNumber *selectedValueId = [attrId objectForKey:@"valueId"];
        for (int i=0; i<item.productAttrItemValues.count; i++) {
            ProductAttrItemValue *value = item.productAttrItemValues[i];
            if ([value.id isEqualToNumber:selectedValueId]) {
                initValueIndex = i;
                break;
            }
        }
    }
    ActionSheetStringPicker * picker = [[ActionSheetStringPicker alloc]
                                        initWithTitle:nil
                                        rows:valueNames
                                        initialSelection:initValueIndex
                                        doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                            //更改按钮的文字
                                            [weakSender setTitle:selectedValue forState:UIControlStateNormal];
                                            //更改productForm表单的值
                                            NSDictionary *attrId = weakProductForm.attrIds[itemIndex];
                                            ProductAttr *attr = _product.productAttrs[itemIndex];
                                            ProductAttrItem *item = attr.productAttrItem;
                                            ProductAttrItemValue *value = item.productAttrItemValues[selectedIndex];
                                            [attrId setValue:value.id forKey:@"valueId"];
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

@end
