//
//  FstSpgOrderItem.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FstSpgFulfillment.h"
#import "FstSpgLicense.h"
#import "FstSpgFileDownload.h"


@interface FstSpgOrderItem : NSObject {
	NSDictionary *raw;
}

+ (FstSpgOrderItem *)itemWithDictionary:(NSDictionary *)aDictionary;

- (FstSpgOrderItem *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (NSString *)productName;
- (NSString *)productDisplay;
- (NSNumber *)quantity;
- (FstSpgFulfillment *)fulfillment;

/*
	Shortcut to fulfillment.license
 */
- (FstSpgLicense *)license;

/*
	Shortcut to fulfillment.download
 */
- (FstSpgFileDownload *)download;

@end
