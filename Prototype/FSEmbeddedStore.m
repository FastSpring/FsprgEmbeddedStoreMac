#import "FSEmbeddedStore.h"
#import "TextPlainView.h"


@implementation FSEmbeddedStore

- (void)awakeFromNib {
	[self open:nil];
}

- (IBAction)open:(id)sender {
	[self setLoading:TRUE];
	[webView setFrameLoadDelegate:self];

	[webView setMaintainsBackForwardList:FALSE];
	[webView setMaintainsBackForwardList:TRUE];
	
	NSString *urlAsStr = @"http://test.fastspring.com/system/site/66bb028a-9f82-4156-86aa-702925f37066/product/fsembeddedstore?member=y2qG0XqIUH%2BUNuiUf4Jley87dh18RAEw9MNCV2RR9Mg4CWKFOPqK5Omg5cLIUCrOHNlPVKk2bNl%2FO%2FYAdRqgyqezZX50c4YKtzWFiHlMItNjjrOF1eYahiajlZRtNmq2%2Fn4lIcB62%2BLvjV1PUN33zjhzyFNuysnG6awLK1Y2K31LSX%2Fm8QRUwHRRCeo2v4GC&mode=test";
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlAsStr]];
	[[webView mainFrame] loadRequest:request];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
	[[webView windowScriptObject] evaluateWebScript:@"Ext.select('.store-page-navigation').hide()"];

	// set completeOrderPage
	id storeCompleteE = [[webView windowScriptObject] evaluateWebScript:@"Ext.get('store-complete-element')"];
	[self setCompleteOrderPage:(storeCompleteE != nil)];
	
	// set orderCompleted
	id storeActionCommand = [[webView windowScriptObject] evaluateWebScript:@"Ext.select('.store-action-command').item(0).dom"];
	[self setOrderCompleted:(storeActionCommand == [WebUndefined undefined])];
	
	// error message handling
	id errorMessage = [[webView windowScriptObject] evaluateWebScript:@"Ext.select('.core-message-error').item(0).dom.innerHTML"];
	if(errorMessage != [WebUndefined undefined]) {
		[[webView windowScriptObject] evaluateWebScript:@"Ext.select('.core-message-error').findParent('div').remove()"];
		
		errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"\t" withString:@""];
		NSRunAlertPanel(@"Error", errorMessage, @"OK", nil, nil);
	}
	
	// license information
	id licenseKey = [[webView windowScriptObject] evaluateWebScript:@"Ext.get('license').dom.innerHTML"];
	if(licenseKey != [WebUndefined undefined]) {
		id licenseName = [[webView windowScriptObject] evaluateWebScript:@"Ext.get('licenseName').dom.innerHTML"];
		
		NSString *message = [NSString stringWithFormat:@"License Key: %@\nName: %@", licenseKey, licenseName];
		NSRunInformationalAlertPanel(@"Your License", message, @"OK", @"", @"");
	}
	
	[self setFirstOrderPage:![webView canGoBack]];
	[self setLoading:FALSE];
}

- (IBAction)previous:(id)sender {
	[self setLoading:TRUE];
	[webView goBack];
}

- (IBAction)next:(id)sender {
	[self setLoading:TRUE];

	[[webView windowScriptObject] evaluateWebScript:@"Ext.select('.store-page-navigation').item(0).select('.store-action-command').item(0).dom.onclick()"];
}

- (void)setFirstOrderPage:(BOOL)aFlag {
	firstOrderPage = aFlag;
}

- (BOOL)firstOrderPage {
	return firstOrderPage;
}

- (void)setCompleteOrderPage:(BOOL)aFlag {
	completeOrderPage = aFlag;
}

- (BOOL)completeOrderPage {
	return completeOrderPage;
}

- (void)setOrderCompleted:(BOOL)aFlag {
	orderCompleted = aFlag;
}

- (BOOL)orderCompleted {
	return orderCompleted;
}

- (void)setLoading:(BOOL)aFlag {
	loading = aFlag;
}

- (BOOL)loading {
	return loading;
}


@end
