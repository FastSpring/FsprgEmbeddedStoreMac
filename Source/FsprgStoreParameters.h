//
//  FsprgStoreParameters.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*! Constants for setOrderProcessType: */
extern NSString * const kFsprgOrderProcessDetail;
extern NSString * const kFsprgOrderProcessInstant;
extern NSString * const kFsprgOrderProcessCheckout;

/*! Constants for setMode: */
extern NSString * const kFsprgModeActive;
extern NSString * const kFsprgModeActiveTest;
extern NSString * const kFsprgModeTest;


/*!
 * FastSpring store parameters. FsprgStoreParameters is backed by a NSMutableDictionary that
 * can be accessed and modified via the raw and setRaw: methods.
 */
@interface FsprgStoreParameters : NSObject {
	BOOL hasContactDefaults;
	NSMutableDictionary *raw;
}

+ (FsprgStoreParameters *)parameters;
+ (FsprgStoreParameters *)parametersWithRaw:(NSMutableDictionary *)aRaw;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSURLRequest *toURLRequest;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSURL *toURL;

- (instancetype)initWithRaw:(NSMutableDictionary *)aRaw NS_DESIGNATED_INITIALIZER;
@property (NS_NONATOMIC_IOSONLY, copy) NSMutableDictionary *raw;

/*!
 * Pass a language code via the URL to bypass automatic language detection.
 * Example: de
 */
@property (NS_NONATOMIC_IOSONLY, copy) NSString *language;

/*!
 * Use kFsprgOrderProcessDetail or kFsprgOrderProcessInstant.
 */
@property (NS_NONATOMIC_IOSONLY, copy) NSString *orderProcessType;

/*!
 * Store path name and product path name.
 * These are found in a full product URL such as sites.fastspring.com/<STOREPATH>/product/<PRODUCTPATH>
 */
- (void)setStoreId:(NSString *)aStoreId withProductId:(NSString *)aProductId;
@property (NS_NONATOMIC_IOSONLY, copy) NSString *storeId;
@property (NS_NONATOMIC_IOSONLY, copy) NSString *productId;

/*!
 * Use kFsprgModeActive, kFsprgModeActiveTest or kFsprgModeTest.
 */
@property (NS_NONATOMIC_IOSONLY, copy) NSString *mode;

/*!
 * Used for "External Tracking". Go to "Link Sources" inside SpringBoard.
 * Example: november_sale_post
 */
@property (NS_NONATOMIC_IOSONLY, copy) NSString *campaign;

/*!
 * Used for advanced and atypical store configuration options.
 */
@property (NS_NONATOMIC_IOSONLY, copy) NSString *option;

/*!
 * Pass a custom referrer via the URL to override the automatically detected referring URL (HTTP_REFERER).
 * The value passed in this parameter is available in notifications and data exports. If a value is 
 * passed in this parameter then no data will be stored from the HTTP_REFERER header.
 * Example: xyz123
 */
@property (NS_NONATOMIC_IOSONLY, copy) NSString *referrer;

/*!
 * Used for "External Tracking". Go to "Link Sources" inside SpringBoard.
 * Example: my_blog
 */
@property (NS_NONATOMIC_IOSONLY, copy) NSString *source;

/*!
 * Pass a coupon code via the URL to automatically apply a coupon to the order so that the customer 
 * does not need to enter it. A corresponding coupon code must be setup and associated with a promotion.
 * Example: DECSPECIAL987
 */
@property (NS_NONATOMIC_IOSONLY, copy) NSString *coupon;

/*!
 * This parameter has many uses within SpringBoard. A tag is a variable that can hold any positive integer value.
 * If no value is specified, it holds a value of 1. Tags can be used by parts of the order process. Adding multiple
 * tag parameters can be achieved by separating each tag (sometimes with numeric value) with a comma, as shown below.
 *
 * mytaga,mytagb,mytagc=2,anothertag=8
 */
@property (NS_NONATOMIC_IOSONLY, copy) NSString *tags;

@property (NS_NONATOMIC_IOSONLY, readonly) BOOL hasContactDefaults;
@property (NS_NONATOMIC_IOSONLY, copy) NSString *contactFname;
@property (NS_NONATOMIC_IOSONLY, copy) NSString *contactLname;
@property (NS_NONATOMIC_IOSONLY, copy) NSString *contactEmail;
@property (NS_NONATOMIC_IOSONLY, copy) NSString *contactCompany;
@property (NS_NONATOMIC_IOSONLY, copy) NSString *contactPhone;

@end
