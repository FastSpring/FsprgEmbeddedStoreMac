//
//  FSOrderItem.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FSFulfillment.h"
#import "FSLicense.h"
#import "FSFileDownload.h"


@interface FSOrderItem : NSObject {
	NSDictionary *raw;
}

+ (FSOrderItem *)itemWithDictionary:(NSDictionary *)aDictionary;

- (FSOrderItem *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (NSString *)productName;
- (NSString *)productDisplay;
- (NSNumber *)quantity;
- (FSFulfillment *)fulfillment;

/*
	Shortcut to fulfillment.license
 */
- (FSLicense *)license;

/*
	Shortcut to fulfillment.download
 */
- (FSFileDownload *)download;

@end
