//
//  FSFulfillment.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FSFulfillment : NSObject {
	NSDictionary *raw;
}

+ (FSFulfillment *)fulfillmentWithDictionary:(NSDictionary *)aDictionary;

- (FSFulfillment *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (id)valueForKey:(NSString *)aKey;

@end
