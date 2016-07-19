//
//  FsprgOrderItem.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FsprgFulfillment.h"
#import "FsprgLicense.h"
#import "FsprgFileDownload.h"


/*!
 * Order item information. FsprgOrderItem is backed by a NSMutableDictionary that
 * can be accessed and modified via the raw and setRaw: methods.
 */
@interface FsprgOrderItem : NSObject {
	NSDictionary *raw;
}

+ (FsprgOrderItem *)itemWithDictionary:(NSDictionary *)aDictionary;

- (FsprgOrderItem *)initWithDictionary:(NSDictionary *)aDictionary NS_DESIGNATED_INITIALIZER;
@property (NS_NONATOMIC_IOSONLY, copy) NSDictionary *raw;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *productName;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *productDisplay;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *quantity;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *itemTotal;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *itemTotalUSD;

/*!
 * This reference can be used to make calls to FastSpring's Subscription API.
 * See https://support.fastspring.com/entries/236487-api-subscriptions
 */
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *subscriptionReference;

/*!
 * This URL can be presented to the customer to manage their subscription.
 */
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSURL *subscriptionCustomerURL;

@property (NS_NONATOMIC_IOSONLY, readonly, strong) FsprgFulfillment *fulfillment;

/*!
 * Shortcut for [[self fulfillment] valueForKey:@"license"].
 * @result License information.
 */
@property (NS_NONATOMIC_IOSONLY, readonly, strong) FsprgLicense *license;

/*!
 * Shortcut for [[self fulfillment] valueForKey:@"download"].
 * @result Download information.
 */
@property (NS_NONATOMIC_IOSONLY, readonly, strong) FsprgFileDownload *download;

@end
