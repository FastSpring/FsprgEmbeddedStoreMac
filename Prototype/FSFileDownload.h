//
//  FSFileDownload.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FSFileDownload : NSObject {
	NSDictionary *raw;
}

+ (FSFileDownload *)fileDownloadWithDictionary:(NSDictionary *)aDictionary;

- (FSFileDownload *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (NSURL *)fileURL;

@end
