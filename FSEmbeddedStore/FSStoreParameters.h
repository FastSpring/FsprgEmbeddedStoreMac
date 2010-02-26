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
	NSString *product;
	NSString *campaign;
	NSString *option;
	NSString *mode;
	NSString *referrer;
	NSString *source;
}

+ (FSStoreParameters *)parameters;

- (NSURLRequest *)toURLRequest;

- (NSString *)storeId;
- (NSString *)product;
- (void)setStoreId:(NSString *)aStoreId withProduct:(NSString *)aProduct;
- (NSString *)campaign;
- (void)setCampaign:(NSString *)aCampaign;
- (NSString *)option;
- (void)setOption:(NSString *)anOption;
- (NSString *)mode;
- (void)setMode:(NSString *)aMode;
- (NSString *)referrer;
- (void)setReferrer:(NSString *)aReferrer;
- (NSString *)source;
- (void)setSource:(NSString *)aSource;

@end
