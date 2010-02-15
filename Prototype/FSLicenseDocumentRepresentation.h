//
//  FSLicenseDocumentRepresentation.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "FSLicense.h"


@interface FSLicenseDocumentRepresentation : NSObject {
	FSLicense *license;
}

- (FSLicense *)license;

- (void)setDataSource:(WebDataSource *)aDataSource;
- (void)receivedData:(NSData *)aData withDataSource:(WebDataSource *)aDataSource;
- (void)receivedError:(NSError *)anError withDataSource:(WebDataSource *)aDataSource;
- (void)finishedLoadingWithDataSource:(WebDataSource *)aDataSource;

@end
