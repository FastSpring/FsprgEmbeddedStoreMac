//
//  AppController.m
//  Example2
//
//  Created by Lars Steiger on 3/11/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "AppController.h"
#import "MGTemplateEngine.h"
#import "ICUTemplateMatcher.h"


@implementation AppController

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setStoreController:[[[FsprgEmbeddedStoreController alloc] init] autorelease]];
		[[self storeController] setDelegate:self];
	}
	return self;
}

- (void)awakeFromNib
{
	[[self storeController] setWebView:storeView];
	[self load:nil];
}

- (FsprgEmbeddedStoreController *)storeController
{
    return [[storeController retain] autorelease]; 
}

- (void)setStoreController:(FsprgEmbeddedStoreController *)aStoreController
{
    if (storeController != aStoreController) {
        [storeController release];
        storeController = [aStoreController retain];
    }
}

- (IBAction)load:(id)sender
{
	FsprgStoreParameters *parameters = [FsprgStoreParameters parameters];
	[parameters setOrderProcessType:kFsprgOrderProcessDetail];
	[parameters setStoreId:@"spootnik" withProductId:@"fsembeddedstore"];
	[parameters setMode:kFsprgModeTest];
	
	[[self storeController] loadWithParameters:parameters];
}

// FsprgEmbeddedStoreDelegate

- (void)didLoadStore
{
}

- (void)didReceiveOrder:(FsprgOrder *)order
{
	NSLog(@"Order from %@ successfully received.", [order customerEmail]);
}

- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FsprgOrder *)order
{
	MGTemplateEngine *engine = [MGTemplateEngine templateEngine];
	[engine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:engine]];
	
	NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"OrderView" ofType:@"html"];
	NSDictionary *variables = [NSDictionary dictionaryWithObject:order forKey:@"order"];
	NSString *htmlString = [engine processTemplateInFileAtPath:templatePath withVariables:variables];

	NSString *templateDirectory = [templatePath substringToIndex:[templatePath length]-[[templatePath lastPathComponent] length]];
	NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", templateDirectory]];
	
	WebFrame *webFrame = [[[WebView alloc] initWithFrame:frame] mainFrame];
	[webFrame loadHTMLString:htmlString baseURL:baseURL];
	
	return [webFrame frameView];
}

- (void)dealloc
{
    [self setStoreController:nil];
	
    [super dealloc];
}

@end