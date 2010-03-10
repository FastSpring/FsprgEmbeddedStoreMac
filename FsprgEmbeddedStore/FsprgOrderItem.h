//
//  FsprgOrderItem.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FsprgFulfillment.h"
#import "FsprgLicense.h"
#import "FsprgFileDownload.h"


@interface FsprgOrderItem : NSObject {
	NSDictionary *raw;
}

+ (FsprgOrderItem *)itemWithDictionary:(NSDictionary *)aDictionary;

- (FsprgOrderItem *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (NSString *)productName;
- (NSString *)productDisplay;
- (NSNumber *)quantity;
- (FsprgFulfillment *)fulfillment;

/*
	Shortcut to fulfillment.license
 */
- (FsprgLicense *)license;

/*
	Shortcut to fulfillment.download
 */
- (FsprgFileDownload *)download;

@end
