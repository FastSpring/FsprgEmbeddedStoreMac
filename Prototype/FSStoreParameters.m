//
//  FSStoreParameters.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSStoreParameters.h"


NSString * const kFSModeActive = @"active";
NSString * const kFSModeActiveTest = @"active.test";
NSString * const kFSModeTest = @"test";

@implementation FSStoreParameters

+ (FSStoreParameters *)parameters
{
	return [[[FSStoreParameters alloc] init] retain];
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setStoreId:nil withProduct:nil];
		[self setCampaign:nil];
		[self setOption:nil];
		[self setMode:kFSModeActive];
		[self setReferrer:nil];
		[self setSource:nil];
	}
	return self;
}

- (NSURLRequest *)toURLRequest
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"page1" ofType:@"html"];
	NSString *urlAsStr = [NSString stringWithFormat:@"file://%@", path];
	//NSString *urlAsStr = @"file:///Users/lars/Desktop/FSEmbeddedStoreStyle/window.xhtml";
	
	return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlAsStr]];
}

- (NSString *)storeId
{
    return [[storeId retain] autorelease]; 
}
- (NSString *)product
{
    return [[product retain] autorelease]; 
}
- (void)setStoreId:(NSString *)aStoreId withProduct:(NSString *)aProduct
{
    if (storeId != aStoreId) {
        [storeId release];
        storeId = [aStoreId retain];
    }
    if (product != aProduct) {
        [product release];
        product = [aProduct retain];
    }
}

- (NSString *)campaign
{
    return [[campaign retain] autorelease]; 
}
- (void)setCampaign:(NSString *)aCampaign
{
    if (campaign != aCampaign) {
        [campaign release];
        campaign = [aCampaign retain];
    }
}

- (NSString *)option
{
    return [[option retain] autorelease]; 
}
- (void)setOption:(NSString *)anOption
{
    if (option != anOption) {
        [option release];
        option = [anOption retain];
    }
}

- (NSString *)mode
{
    return [[mode retain] autorelease]; 
}
- (void)setMode:(NSString *)aMode
{
    if (mode != aMode) {
        [mode release];
        mode = [aMode retain];
    }
}

- (NSString *)referrer
{
    return [[referrer retain] autorelease]; 
}
- (void)setReferrer:(NSString *)aReferrer
{
    if (referrer != aReferrer) {
        [referrer release];
        referrer = [aReferrer retain];
    }
}

- (NSString *)source
{
    return [[source retain] autorelease]; 
}
- (void)setSource:(NSString *)aSource
{
    if (source != aSource) {
        [source release];
        source = [aSource retain];
    }
}

@end