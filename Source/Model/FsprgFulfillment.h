//
//  FsprgFulfillment.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/*!
 * Order fulfillment information. FsprgFulfillment is backed by a NSMutableDictionary that
 * can be accessed and modified via the raw and setRaw: methods.
 */
@interface FsprgFulfillment : NSObject {
	NSDictionary *raw;
}

+ (FsprgFulfillment *)fulfillmentWithDictionary:(NSDictionary *)aDictionary;

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary NS_DESIGNATED_INITIALIZER;
@property (NS_NONATOMIC_IOSONLY, copy) NSDictionary *raw;

/*!
 * @param aKey type of fulfillment (e.g. license, download)
 * @result Specific fulfillment information (FsprgLicense, FsprgFileDownload).
 */
- (id)valueForKey:(NSString *)aKey;

@end
