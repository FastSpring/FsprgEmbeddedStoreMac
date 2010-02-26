//
//  FSOrder.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FSOrderItem.h"


@interface FSOrder : NSObject {
	NSDictionary *raw;
}

+ (FSOrder *)orderFromData:(NSData *)aData;

- (FSOrder *)initWithDictionary:(NSDictionary *)aDictionary;
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
	
- (FSOrderItem *)firstOrderItem;
- (NSArray *)orderItems;

@end
