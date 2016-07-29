//
//  AddressEntity.h
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
#import "AreaEntity.h"

@interface AddressEntity : BaseEntity

@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *fullname;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSNumber *isDefault;

@property (nonatomic, strong) AreaEntity *area;

@end
