//
//  FstSpgOrder.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FstSpgOrderItem.h"


@interface FstSpgOrder : NSObject {
	NSDictionary *raw;
}

+ (FstSpgOrder *)orderFromData:(NSData *)aData;

- (FstSpgOrder *)initWithDictionary:(NSDictionary *)aDictionary;
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
	
- (FstSpgOrderItem *)firstOrderItem;
- (NSArray *)orderItems;

@end
