//
//  PreorderEntity.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/07/19.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseEntity.h"
#import "CouponUserEntity.h"
#import "AreaEntity.h"

@interface PreorderEntity : BaseEntity

@property (nonatomic, copy) NSNumber *totalCount;
@property (nonatomic, copy) NSNumber *totalPrice;
@property (nonatomic, copy) NSNumber *isOrdered; //是否已经下单
@property (nonatomic, copy) NSNumber *couponUserTotalPrice;
@property (nonatomic, copy) NSNumber *originTotalPrice;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *areaParentId;
@property (nonatomic, copy) NSString *areaPathIds;
@property (nonatomic, copy) NSString *areaPathNames;
@property (nonatomic, copy) NSString *areaSimpleName;
@property (nonatomic, copy) NSString *areaZipCode;
@property (nonatomic, copy) NSString *storeId; //用户选择不同的地址，就会有不同的店铺id
@property (nonatomic, copy) NSString *addressFullname;
@property (nonatomic, copy) NSString *addressTelephone;
@property (nonatomic, copy) NSString *addressDetail;
@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, copy) NSString *payType; //@see Order entity
@property (nonatomic, copy) NSString *roughPayType;
@property (nonatomic, copy) NSString *minTotalPriceLabel; //最少支付金额标记
@property (nonatomic, copy) NSString *couponUserId;//优惠券id, 对应CouponUserEntity

@end
