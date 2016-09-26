//
//  FsprgStoreParameters.m
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FsprgStoreParameters.h"

NSString * const kFsprgOrderProcessDetail = @"detail";
NSString * const kFsprgOrderProcessInstant = @"instant";
NSString * const kFsprgOrderProcessCheckout = @"checkout";

NSString * const kFsprgModeActive = @"active";
NSString * const kFsprgModeActiveTest = @"active.test";
NSString * const kFsprgModeTest = @"test";

static NSString * const kLanguage = @"language";
static NSString * const kOrderProcessType = @"orderProcessType";
static NSString * const kStoreId = @"storeId";
static NSString * const kProductId = @"productId";
static NSString * const kMode = @"mode";
static NSString * const kCampaign = @"campaign";
static NSString * const kOption = @"option";
static NSString * const kReferrer = @"referrer";
static NSString * const kSource = @"source";
static NSString * const kCoupon = @"coupon";
static NSString * const kTags = @"tags";
static NSString * const kContactFname = @"contact_fname";
static NSString * const kContactLname = @"contact_lname";
static NSString * const kContactEmail = @"contact_email";
static NSString * const kContactCompany = @"contact_company";
static NSString * const kContactPhone = @"contact_phone";

static NSMutableDictionary *keyPathsForValuesAffecting; 

@implementation FsprgStoreParameters

+ (void)initialize
{
	keyPathsForValuesAffecting = [NSMutableDictionary dictionaryWithCapacity:1];
	
	NSSet *toURLSet = [NSSet setWithObjects:NSStringFromSelector(@selector(language)),
											NSStringFromSelector(@selector(orderProcessType)), 
											NSStringFromSelector(@selector(storeId)),
											NSStringFromSelector(@selector(productId)),
											NSStringFromSelector(@selector(mode)),
											NSStringFromSelector(@selector(campaign)),
											NSStringFromSelector(@selector(option)),
											NSStringFromSelector(@selector(referrer)),
											NSStringFromSelector(@selector(source)),
											NSStringFromSelector(@selector(coupon)),
											NSStringFromSelector(@selector(contactFname)),
											NSStringFromSelector(@selector(contactLname)),
											NSStringFromSelector(@selector(contactEmail)),
											NSStringFromSelector(@selector(contactCompany)),
											NSStringFromSelector(@selector(contactPhone)),
											nil];
	keyPathsForValuesAffecting[NSStringFromSelector(@selector(toURL))] = toURLSet;
}

+ (FsprgStoreParameters *)parameters
{
	NSMutableDictionary *raw = [NSMutableDictionary dictionaryWithCapacity:15];
	return [[FsprgStoreParameters alloc] initWithRaw:raw];
}

+ (FsprgStoreParameters *)parametersWithRaw:(NSMutableDictionary *)aRaw
{
	return [[FsprgStoreParameters alloc] initWithRaw:aRaw];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
	NSSet *keyPaths = [keyPathsForValuesAffecting valueForKey:key];
	if(keyPaths == nil) {
		return [NSSet set];
	} else {
		return keyPaths;
	}
}

- (instancetype)init
{
    return [self initWithRaw:[NSMutableDictionary dictionary]];
}

- (instancetype)initWithRaw:(NSMutableDictionary *)aRaw
{
	self = [super init];
	if (self != nil) {
		self.raw = aRaw;
	}
	return self;
}

- (NSMutableDictionary *)raw
{
    return raw; 
}

- (void)setRaw:(NSMutableDictionary *)aRaw
{
    if (raw != aRaw) {
        raw = aRaw;
    }
}

- (NSURLRequest *)toURLRequest
{
	NSURL *toURL = self.toURL;
	if (toURL) {
        return [NSMutableURLRequest requestWithURL:toURL];
    } else {
        return nil;
    }
}

- (NSURL *)toURL
{
	NSString *storeIdEncoded = [self.storeId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	if(storeIdEncoded == nil) {
		storeIdEncoded = @"";
	}
	NSString *productIdEncoded = [self.productId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	if(productIdEncoded == nil) {
		productIdEncoded = @"";
	}

	NSString *urlAsStr;
	if([kFsprgOrderProcessDetail isEqualTo:self.orderProcessType]) {
		NSString *protocol = @"http";
		if(self.hasContactDefaults) {
			protocol = @"https";
		}
		urlAsStr = [NSString stringWithFormat:@"%@://sites.fastspring.com/%@/product/%@", protocol, storeIdEncoded, productIdEncoded];
	} else if([kFsprgOrderProcessInstant isEqualTo:self.orderProcessType]) {
		urlAsStr = [NSString stringWithFormat:@"https://sites.fastspring.com/%@/instant/%@", storeIdEncoded, productIdEncoded];
	} else if ([kFsprgOrderProcessCheckout isEqualTo:self.orderProcessType]) {
		urlAsStr = [NSString stringWithFormat:@"https://sites.fastspring.com/%@/checkout/%@", storeIdEncoded, productIdEncoded];
	} else {
		NSAssert1(FALSE, @"OrderProcessType '%@' unknown.", [self orderProcessType]);
		return nil;
	}

	NSMutableArray *keys = [NSMutableArray arrayWithArray:self.raw.allKeys];
	[keys removeObject:kOrderProcessType];
	[keys removeObject:kStoreId];
	[keys removeObject:kProductId];
	[keys sortUsingSelector:@selector(compare:)];
	
	NSString *queryStr = @"";
	NSUInteger i, count = keys.count;
	for (i = 0; i < count; i++) {
		NSString *key = keys[i];
		NSString *value = [self.raw valueForKey:key];
		if(value != nil) {
			queryStr = [queryStr stringByAppendingFormat:@"&%@=%@",
						key,
						[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		}
	}
		
	if(queryStr.length > 0) {
		urlAsStr = [NSString stringWithFormat:@"%@?%@", urlAsStr, [queryStr substringFromIndex:1]];
	}
	
	return [NSURL URLWithString:urlAsStr];
}

- (void)setObject:(NSString *)anObject forKey:(NSString *)aKey
{
	if(anObject == nil) {
		[self.raw removeObjectForKey:aKey];
	} else {
		self.raw[aKey] = anObject;
	}
}

- (NSString *)language
{
    return self.raw[kLanguage];
}

- (void)setLanguage:(NSString *)aLanguage
{
	[self setObject:aLanguage forKey:kLanguage];
}

- (NSString *)orderProcessType
{
    return self.raw[kOrderProcessType];
}
- (void)setOrderProcessType:(NSString *)anOrderProcessType
{
    [self setObject:anOrderProcessType forKey:kOrderProcessType];
}

- (void)setStoreId:(NSString *)aStoreId withProductId:(NSString *)aProductId
{
	self.storeId = aStoreId;
	self.productId = aProductId;
}

- (NSString *)storeId
{
    return self.raw[kStoreId];
}
- (void)setStoreId:(NSString *)aStoreId
{
    [self setObject:aStoreId forKey:kStoreId];
}

- (NSString *)productId
{
    return self.raw[kProductId];
}
- (void)setProductId:(NSString *)aProductId
{
    [self setObject:aProductId forKey:kProductId];
}

- (NSString *)mode
{
	return self.raw[kMode];
}
- (void)setMode:(NSString *)aMode
{
	[self setObject:aMode forKey:kMode];
}

- (NSString *)campaign
{
    return self.raw[kCampaign];
}
- (void)setCampaign:(NSString *)aCampaign
{
	[self setObject:aCampaign forKey:kCampaign];
}

- (NSString *)option
{
    return self.raw[kOption];
}
- (void)setOption:(NSString *)anOption
{
	[self setObject:anOption forKey:kOption];
}

- (NSString *)referrer
{
    return self.raw[kReferrer];
}
- (void)setReferrer:(NSString *)aReferrer
{
	[self setObject:aReferrer forKey:kReferrer];
}

- (NSString *)source
{
    return self.raw[kSource];
}
- (void)setSource:(NSString *)aSource
{
	[self setObject:aSource forKey:kSource];
}

- (NSString *)coupon
{
	return self.raw[kCoupon];
}
- (void)setCoupon:(NSString *)aCoupon
{
	[self setObject:aCoupon forKey:kCoupon];
}

- (NSString *)tags
{
    return self.raw[kTags];
}
- (void)setTags:(NSString *)aTags
{
    [self setObject:aTags forKey:kTags];
}

- (BOOL)hasContactDefaults
{
	NSArray *allKeys = self.raw.allKeys;

	return [allKeys containsObject:kContactFname] ||
		   [allKeys containsObject:kContactLname] ||
		   [allKeys containsObject:kContactEmail] ||
		   [allKeys containsObject:kContactCompany] ||
		   [allKeys containsObject:kContactPhone];
}

- (NSString *)contactFname
{
    return self.raw[kContactFname];
}
- (void)setContactFname:(NSString *)aContactFname
{
	[self setObject:aContactFname forKey:kContactFname];
}

- (NSString *)contactLname
{
    return self.raw[kContactLname];
}
- (void)setContactLname:(NSString *)aContactLname
{
	[self setObject:aContactLname forKey:kContactLname];
}

- (NSString *)contactEmail
{
    return self.raw[kContactEmail];
}
- (void)setContactEmail:(NSString *)aContactEmail
{
	[self setObject:aContactEmail forKey:kContactEmail];
}

- (NSString *)contactCompany
{
    return self.raw[kContactCompany];
}
- (void)setContactCompany:(NSString *)aContactCompany
{
	[self setObject:aContactCompany forKey:kContactCompany];
}

- (NSString *)contactPhone
{
    return self.raw[kContactPhone];
}
- (void)setContactPhone:(NSString *)aContactPhone
{
	[self setObject:aContactPhone forKey:kContactPhone];
}

- (void)dealloc
{
    [self setRaw:nil];
	
}

@end
