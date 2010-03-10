//
//  FsprgFulfillment.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FsprgFulfillment : NSObject {
	NSDictionary *raw;
}

+ (FsprgFulfillment *)fulfillmentWithDictionary:(NSDictionary *)aDictionary;

- (FsprgFulfillment *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (id)valueForKey:(NSString *)aKey;

@end
