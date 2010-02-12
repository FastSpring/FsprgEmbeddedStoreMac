#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@interface FSEmbeddedStore : NSObject {
	IBOutlet WebView* webView;
	BOOL firstOrderPage;
	BOOL completeOrderPage;
	BOOL orderCompleted;
	BOOL loading;
}

- (IBAction)open:(id)sender;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (void)setFirstOrderPage:(BOOL)aFlag;
- (BOOL)firstOrderPage;
- (void)setCompleteOrderPage:(BOOL)aFlag;
- (BOOL)completeOrderPage;
- (void)setOrderCompleted:(BOOL)aFlag;
- (BOOL)orderCompleted;
- (void)setLoading:(BOOL)aFlag;
- (BOOL)loading;

@end
