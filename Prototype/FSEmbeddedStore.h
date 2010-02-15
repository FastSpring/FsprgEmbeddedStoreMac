//
//  FSEmbeddedStore.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@interface FSEmbeddedStore : NSObject {
	IBOutlet WebView* webView;
	BOOL loading;
}

- (IBAction)open:(id)sender;
- (IBAction)show1PasswordMenu:(id)sender;
- (void)setLoading:(BOOL)aFlag;
- (BOOL)loading;

- (void)js_goBack;

@end
