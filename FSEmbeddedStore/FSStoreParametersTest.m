//
//  FSStoreParametersTest.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 3/1/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSStoreParametersTest.h"


@implementation FSStoreParametersTest

- (void) setUp
{
	params = [[FSStoreParameters parameters] retain];
}

- (void) tearDown
{
    [params release];
}

- (void)testNoParam
{
	[params setStoreId:@"storeId" withProductId:@"productId"];
	
	STAssertEqualObjects(@"http://sites.fastspring.com/storeId/product/productId", [[[params toURLRequest] URL] description], nil);
}

- (void)testOneParam
{
	[params setStoreId:@"storeId" withProductId:@"productId"];
	[params setMode:kFSModeTest];
	
	STAssertEqualObjects(@"http://sites.fastspring.com/storeId/product/productId?mode=test", [[[params toURLRequest] URL] description], nil);
}

- (void)testTwoParams
{
	[params setStoreId:@"storeId" withProductId:@"productId"];
	[params setMode:kFSModeTest];
	[params setCampaign:@"aCampaign"];
	
	STAssertEqualObjects(@"http://sites.fastspring.com/storeId/product/productId?campaign=aCampaign&mode=test", [[[params toURLRequest] URL] description], nil);
}

- (void)testAllParams
{
	[params setStoreId:@"storeId" withProductId:@"productId"];
	[params setMode:kFSModeTest];
	[params setCampaign:@"aCampaign"];
	[params setOption:@"anOption"];
	[params setReferrer:@"aReferrer"];
	[params setSource:@"aSource"];
	
	STAssertEqualObjects(@"http://sites.fastspring.com/storeId/product/productId?campaign=aCampaign&mode=test&option=anOption&referrer=aReferrer&source=aSource",
						 [[[params toURLRequest] URL] description], nil);
}

- (void)testSpecialChars
{
	[params setStoreId:@"ä" withProductId:@"ö"];
	[params setCampaign:@"ü"];
	[params setOption:@">"];
	[params setReferrer:@"<"];
	[params setSource:@"%"];
	
	STAssertEqualObjects(@"http://sites.fastspring.com/%C3%A4/product/%C3%B6?campaign=%C3%BC&option=%3E&referrer=%3C&source=%25",
						 [[[params toURLRequest] URL] description], nil);
}

- (void)testParamViaRaw
{
	[params setStoreId:@"storeId" withProductId:@"productId"];
	[[params raw] setValue:@"aValue" forKey:@"additional"];
	
	STAssertEqualObjects(@"http://sites.fastspring.com/storeId/product/productId?additional=aValue", [[[params toURLRequest] URL] description], nil);
}

@end
