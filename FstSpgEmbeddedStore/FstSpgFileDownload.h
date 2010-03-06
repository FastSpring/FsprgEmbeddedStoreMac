//
//  FstSpgFileDownload.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FstSpgFileDownload : NSObject {
	NSDictionary *raw;
}

+ (FstSpgFileDownload *)fileDownloadWithDictionary:(NSDictionary *)aDictionary;

- (FstSpgFileDownload *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (NSURL *)fileURL;

@end
