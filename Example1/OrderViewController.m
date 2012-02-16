//
//  OrderViewController.m
//  Example1
//
//  Created by Lars Steiger on 2/28/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "OrderViewController.h"
#import "FsprgEmbeddedStore.h"


@implementation OrderViewController

- (IBAction)showLicense:(id)sender
{
	FsprgOrder *order = [self representedObject];
	
	NSString *message = [NSString stringWithFormat:@"Name: %@\nEmail: %@", [order customerLastName], [order customerEmail]];
	NSRunInformationalAlertPanel(@"Your License", message, @"OK", nil, nil);
}

@end
