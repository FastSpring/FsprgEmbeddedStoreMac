//
//  FSStoreParameters.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const kFSModeActive;
extern NSString * const kFSModeActiveTest;
extern NSString * const kFSModeTest;

@interface FSStoreParameters : NSObject {
	NSString *storeId;
	NSString *productId;
	NSMutableDictionary *raw;
}

+ (FSStoreParameters *)parameters;

- (NSURLRequest *)toURLRequest;

- (NSMutableDictionary *)raw;
- (void)setRaw:(NSMutableDictionary *)aRaw;

- (NSString *)storeId;
- (NSString *)productId;
- (void)setStoreId:(NSString *)aStoreId withProductId:(NSString *)aProductId;
- (NSString *)mode;
- (void)setMode:(NSString *)aMode;
- (NSString *)campaign;
- (void)setCampaign:(NSString *)aCampaign;
- (NSString *)option;
- (void)setOption:(NSString *)anOption;
- (NSString *)referrer;
- (void)setReferrer:(NSString *)aReferrer;
- (NSString *)source;
- (void)setSource:(NSString *)aSource;

@end
