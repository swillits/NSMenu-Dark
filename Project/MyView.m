//
//  MyView.m
//  Dark NSMenu
//
//  Created by Seth Willits on 9/17/12.
//  Copyright (c) 2012 Araelium Group. All rights reserved.
//

#import "MyView.h"
#import "NSMenu+Dark.h"


@implementation MyView
{
	NSMenu * mRightMenu;
}

- (NSMenu *)menuForEvent:(NSEvent *)event;
{
	// Demonstrating the same menu instance can go from dark <-> light
	if (!mRightMenu) {
		mRightMenu = [[NSMenu alloc] init];
		
		NSMenu * submenu = [[[NSMenu alloc] init] autorelease];;
		[submenu addItemWithTitle:@"Test" action:@selector(terminate:) keyEquivalent:@""];
		
		[mRightMenu addItemWithTitle:@"A Real" action:@selector(terminate:) keyEquivalent:@""];
		[[mRightMenu addItemWithTitle:@"Darkened" action:@selector(terminate:) keyEquivalent:@""] setSubmenu:submenu];;
		[mRightMenu addItemWithTitle:@"NSMenu" action:@selector(terminate:) keyEquivalent:@""];
		[mRightMenu addItem:[NSMenuItem separatorItem]];
		[mRightMenu addItemWithTitle:@"Show All Windows" action:@selector(terminate:) keyEquivalent:@""];
		[mRightMenu addItemWithTitle:@"Hide" action:@selector(terminate:) keyEquivalent:@""];
		[mRightMenu addItem:[NSMenuItem separatorItem]];
		[mRightMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
	}
	
	
	// The preference is hooked up to the checkbox in the UI
	mRightMenu.dark = [[NSUserDefaults standardUserDefaults] boolForKey:@"makeMenuDark"];
	
	return mRightMenu;
}



@end
