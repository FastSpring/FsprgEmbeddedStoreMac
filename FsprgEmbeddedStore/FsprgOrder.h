//
//  FsprgOrder.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FsprgOrderItem.h"


@interface FsprgOrder : NSObject {
	NSDictionary *raw;
}

+ (FsprgOrder *)orderFromData:(NSData *)aData;

- (FsprgOrder *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (BOOL)orderIsTest;
- (NSString *)orderReference;
- (NSString *)orderLanguage;
- (NSString *)orderCurrency;
- (NSNumber *)orderTotal;
- (NSString *)customerFirstName;
- (NSString *)customerLastName;
- (NSString *)customerCompany;
- (NSString *)customerEmail;
	
- (FsprgOrderItem *)firstOrderItem;
- (NSArray *)orderItems;

@end
