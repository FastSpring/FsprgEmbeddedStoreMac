//
//  FSEmbeddedStore.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSEmbeddedStoreController.h"
#import "FSOrderView.h"
#import "FSOrderDocumentRepresentation.h"
#import <AddressBook/AddressBook.h>


@implementation FSEmbeddedStoreController

- (void)awakeFromNib
{
	[WebView registerViewClass:[FSOrderView class]
		     representationClass:[FSOrderDocumentRepresentation class]
			 forMIMEType:@"text/plain"];

	[self setDelegate:[[FSEmbeddedStoreDelegate alloc] init]];
	[self load:nil];
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setDelegate:nil];
	}
	return self;
}

- (FSEmbeddedStoreDelegate *)delegate
{
    return [[delegate retain] autorelease]; 
}
- (void)setDelegate:(FSEmbeddedStoreDelegate *)aDelegate
{
    if (delegate != aDelegate) {
        [delegate release];
        delegate = [aDelegate retain];
    }
}

- (IBAction)load:(id)sender
{
	[self setLoading:TRUE];
	[webView setFrameLoadDelegate:self];
	[webView setUIDelegate:self];

	FSStoreParameters *parameters = [FSStoreParameters parameters];
	[[self delegate] willLoadStoreWithParameters:parameters];
	[[webView mainFrame] loadRequest:[parameters toURLRequest]];
}

- (void)setValue:(NSString *)aValue forId:(NSString *)anId
{
	if(aValue == nil) {
		aValue = @"";
	}
	NSString *script = [NSString stringWithFormat:@"document.getElementById('%@').value='%@'",anId, aValue];
	[[webView windowScriptObject] evaluateWebScript:script];
}

- (IBAction)fillMeFromAddressBook:(id)sender
{
	ABPerson *me = [[ABAddressBook sharedAddressBook] me];

	NSString *firstName = [me valueForProperty:kABFirstNameProperty];
	NSString *lastName = [me valueForProperty:kABLastNameProperty];
	[self setValue:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forId:@"user:name"];
	[self setValue:[me valueForProperty:kABOrganizationProperty] forId:@"user:company"];

	ABMultiValue *allPhones = [me valueForProperty:kABPhoneProperty];
	NSString *phone = [allPhones valueAtIndex:[allPhones indexForIdentifier:[allPhones primaryIdentifier]]];
	[self setValue:phone forId:@"user:phone_number"];

	ABMultiValue *allEmails = [me valueForProperty:kABEmailProperty];
	NSString *email = [allEmails valueAtIndex:[allEmails indexForIdentifier:[allEmails primaryIdentifier]]];
	[self setValue:email forId:@"user:email"];

	ABMultiValue *allAddresses = [me valueForProperty:kABAddressProperty];
	NSDictionary *address = [allAddresses valueAtIndex:[allAddresses indexForIdentifier:[allAddresses primaryIdentifier]]];
					
	NSString *countryCode = [[address valueForKey:kABAddressCountryCodeKey] uppercaseString];
	[self setValue:countryCode forId:@"user:country"];
	[self setValue:[address valueForKey:kABAddressStreetKey] forId:@"user:address_1"];
	[self setValue:@"" forId:@"user:address_2"];
	[self setValue:[address valueForKey:kABAddressCityKey] forId:@"user:city"];
	NSString *state = [address valueForKey:kABAddressStateKey];
	if(state != nil && ([countryCode isEqual:@"US"] || [countryCode isEqual:@"CA"] || [countryCode isEqual:@"AU"])) {
		NSString *region = [NSString stringWithFormat:@"%@-%@", countryCode, state];
		[self setValue:region forId:@"user:region"];
	} else {
		[self setValue:@"" forId:@"user:region"];
	}
	[self setValue:[address valueForKey:kABAddressZIPKey] forId:@"user:postal_code"];
}

#pragma: FrameLoadDelegate

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	[self setLoading:FALSE];
}

- (void)setLoading:(BOOL)aFlag
{
	loading = aFlag;
}

- (BOOL)loading
{
	return loading;
}

- (void)didReceiveOrder:(FSOrder *)anOrder {
	[[self delegate] didReceiveOrder:anOrder];
}

#pragma: UIDelegate

- (void)webView:(WebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame
{
	NSRunAlertPanel(@"Alert", message, @"OK", nil, nil);
}

- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request
{
	NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0,0,0,0)
										 styleMask:(NSClosableWindowMask|NSResizableWindowMask)
										 backing:NSBackingStoreBuffered
										 defer:NO];
	WebView *subWebView = [[[WebView alloc] initWithFrame:NSMakeRect(0,0,0,0) frameName:@"_blank" groupName:@"none"] autorelease];
	[window setReleasedWhenClosed:TRUE];
	[window setContentView:subWebView];
	[window makeKeyAndOrderFront:sender];
	
	return subWebView;
}

- (NSView *)viewWithFrame:(NSRect)aFrame forOrder:(FSOrder *)anOrder {
	return [[self delegate] viewWithFrame:aFrame forOrder:anOrder];
}

@end
