//
//  FsprgOrder.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <FsprgEmbeddedStore/FsprgOrderItem.h>


/*!
 * Order information. FsprgOrder is backed by a NSMutableDictionary that
 * can be accessed and modified via the raw and setRaw: methods.
 */
@interface FsprgOrder : NSObject {
	NSDictionary *raw;
}

+ (FsprgOrder *)orderFromData:(NSData *)aData;

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary NS_DESIGNATED_INITIALIZER;
@property (NS_NONATOMIC_IOSONLY, copy) NSDictionary *raw;

@property (NS_NONATOMIC_IOSONLY, readonly) BOOL orderIsTest;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *orderReference;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *orderLanguage;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *orderCurrency;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *orderTotal;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *orderTotalUSD;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *customerFirstName;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *customerLastName;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *customerCompany;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *customerEmail;

/*!
 * Shortcut for [[self orderItems] objectAtIndex:0].
 * @result First item.
 */
@property (NS_NONATOMIC_IOSONLY, readonly, strong) FsprgOrderItem *firstOrderItem;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *orderItems;

@end
