//
//  FSStoreParameters.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FSStoreParameters : NSObject {
	NSString *storeId;
	NSString *product;
	NSString *campaign;
	NSString *option;
	BOOL test;
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
- (BOOL)test;
- (void)setTest:(BOOL)flag;
- (NSString *)referrer;
- (void)setReferrer:(NSString *)aReferrer;
- (NSString *)source;
- (void)setSource:(NSString *)aSource;

@end
