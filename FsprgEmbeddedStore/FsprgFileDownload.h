//
//  FsprgFileDownload.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FsprgFileDownload : NSObject {
	NSDictionary *raw;
}

+ (FsprgFileDownload *)fileDownloadWithDictionary:(NSDictionary *)aDictionary;

- (FsprgFileDownload *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (NSURL *)fileURL;

@end
