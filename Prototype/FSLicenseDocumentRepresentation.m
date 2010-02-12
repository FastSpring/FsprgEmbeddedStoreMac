//
//  FSLicenseDocumentRepresentation.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSLicenseDocumentRepresentation.h"


@implementation FSLicenseDocumentRepresentation

- (FSAquaticPrimeLicense *)license {
	return license;
}

- (void)setDataSource:(WebDataSource *)aDataSource {
}

- (void)receivedData:(NSData *)aData withDataSource:(WebDataSource *)aDataSource {
	license = [[FSAquaticPrimeLicense licenseFromData:aData] retain];
}

- (void)receivedError:(NSError *)anError withDataSource:(WebDataSource *)aDataSource {
}

- (void)finishedLoadingWithDataSource:(WebDataSource *)aDataSource {
}

@end
