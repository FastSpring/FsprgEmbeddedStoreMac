//
//  MyOrderViewController.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/21/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "MyOrderViewController.h"


@implementation MyOrderViewController

- (IBAction)showMessageBox:(id)sender
{
	NSRunInformationalAlertPanel(@"Info", @"You've pressed the button.", @"OK", nil, nil);
}

@end
