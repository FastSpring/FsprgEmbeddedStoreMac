//
//  FSEmbeddedStore.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSEmbeddedStore.h"
#import "FSLicenseWebView.h"
#import "FSLicenseDocumentRepresentation.h"
#import <objc/objc-runtime.h>

/* Prefix for all methods and instance variables that will be exposed in the widget */
NSString *const kJSSelectorPrefix = @"js_";

@implementation FSEmbeddedStore

- (void)awakeFromNib {
	NSBundle *webKitExtension = [NSBundle bundleWithPath:@"/Applications/1Password.app/Contents/Extensions/WebKitExtension.bundle"];
	[[[webKitExtension principalClass] alloc] init];

	[WebView registerViewClass:[FSLicenseWebView class] representationClass:[FSLicenseDocumentRepresentation class] forMIMEType:@"text/plain"];
	[self open:nil];
}

- (IBAction)open:(id)sender {
	[self setLoading:TRUE];
	[webView setFrameLoadDelegate:self];
	[webView setUIDelegate:self];

	NSString *path = [[NSBundle mainBundle] pathForResource:@"page1" ofType:@"html"];
	NSString *urlAsStr = [NSString stringWithFormat:@"file://%@", path];
	//NSString *urlAsStr = @"file:///Users/lars/Desktop/FSEmbeddedStoreStyle/window.xhtml";
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlAsStr]];
	[[webView mainFrame] loadRequest:request];
}

- (IBAction)show1PasswordMenu:(id)sender {
	[[NSApplication sharedApplication] show1PasswordMenu:sender];
}

- (void)setValue:(NSString *)aValue forId:(NSString *)anId {
	NSString *script = [NSString stringWithFormat:@"document.getElementById('%@').value='%@'",anId, aValue];
	[[webView windowScriptObject] evaluateWebScript:script];
}

- (IBAction)fillMeFromAddressBook:(id)sender {
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

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
	[self setLoading:FALSE];
}

- (void)setLoading:(BOOL)aFlag {
	loading = aFlag;
}

- (BOOL)loading {
	return loading;
}

#pragma: UIDelegate

- (void)webView:(WebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame {
	NSRunAlertPanel(@"Alert", message, @"OK", nil, nil);
}

- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request {
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

#pragma: WebScriptObject

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame {
	[windowObject setValue:self forKey:@"controller"];
}

+ (BOOL)isKeyExcludedFromWebScript:(const char *)name
{
    NSString* keyName = [[[NSString alloc] initWithUTF8String: name] autorelease];
    return !([ keyName hasPrefix:kJSSelectorPrefix]);
}

+ (NSString *)webScriptNameForKey:(const char *)name
{
    NSString* keyName = [[[NSString alloc] initWithUTF8String: name] autorelease];
    if ([ keyName hasPrefix:kJSSelectorPrefix] && ([ keyName length] > [kJSSelectorPrefix length]))
    {
        return [keyName substringFromIndex:[kJSSelectorPrefix length]];
    }
    return nil;
}

+ (NSString *)webScriptNameForSelector:(SEL)aSelector 
{
    NSString* selectorName = NSStringFromSelector(aSelector);
    if ([selectorName hasPrefix:kJSSelectorPrefix] && ([selectorName length] > [kJSSelectorPrefix length]))
    {
        return [[[selectorName substringFromIndex:[kJSSelectorPrefix length]] componentsSeparatedByString: @":"] objectAtIndex: 0];
    }
    return nil;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector 
{
    return !([NSStringFromSelector(aSelector) hasPrefix:kJSSelectorPrefix]);
}

- (void)js_goBack {
	[self setLoading:TRUE];
	[webView goBack];
}

@end
