//
//  FSLicenseDocumentRepresentation.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "FSAquaticPrimeLicense.h"


@interface FSLicenseDocumentRepresentation : NSObject {
	FSAquaticPrimeLicense *license;
}

- (FSAquaticPrimeLicense *)license;

- (void)setDataSource:(WebDataSource *)aDataSource;
- (void)receivedData:(NSData *)aData withDataSource:(WebDataSource *)aDataSource;
- (void)receivedError:(NSError *)anError withDataSource:(WebDataSource *)aDataSource;
- (void)finishedLoadingWithDataSource:(WebDataSource *)aDataSource;

@end
