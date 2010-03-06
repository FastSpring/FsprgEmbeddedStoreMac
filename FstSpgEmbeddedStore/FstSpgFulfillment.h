//
//  FstSpgFulfillment.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FstSpgFulfillment : NSObject {
	NSDictionary *raw;
}

+ (FstSpgFulfillment *)fulfillmentWithDictionary:(NSDictionary *)aDictionary;

- (FstSpgFulfillment *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (id)valueForKey:(NSString *)aKey;

@end
