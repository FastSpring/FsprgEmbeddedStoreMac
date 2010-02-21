//
//  FSOrder.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FSOrder : NSObject {
	NSDictionary *dictionary;
}

+ (FSOrder *)orderFromData:(NSData *)aData;

- (NSDictionary *)dictionary;
- (void)setDictionary:(NSDictionary *)aDictionary;

- (NSString *)valueForKey:(NSString *)aKey;

@end
