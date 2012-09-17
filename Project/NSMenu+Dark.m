//
//  NSMenu+Dark.m
//  Dark NSMenu
//
//  Created by Seth Willits on 9/17/12.
//  Copyright (c) 2012 Araelium Group. All rights reserved.
//

#import <Carbon/Carbon.h>
#import <objc/runtime.h>
#import "NSMenu+Dark.h"


// This method is not public in 64-bit, but still exists within
// the Carbon framework so we just declare it exists and link to Carbon.
extern void SetMenuItemProperty(MenuRef         menu,
								MenuItemIndex   item,
								OSType          propertyCreator,
								OSType          propertyTag,
								ByteCount       propertySize,
								const void *    propertyData);


// Menus have a private implementation object, which is "always" a
// NSCarbonMenuImpl instance.
@interface NSMenu (Private)
- (id)_menuImpl;
@end


// NSCarbonMenuImpl is a class, but since it's not public, using
// a protocol to get at the method we want works easily.
@protocol NSCarbonMenuImplProtocol <NSObject>
- (MenuRef)_principalMenuRef;
@end


// Private method which sets the Dark property
@interface NSMenu (DarkPrivate)
- (void)makeDark;
@end


// Helper class used to set darkness after the Carbon MenuRef has been created.
// (The MenuRef doesn't exist until tracking starts.)
@interface NSMenuDarkMaker : NSObject {
	NSMenu * mMenu;
}
- (id)initWithMenu:(NSMenu *)menu;
@end








#pragma mark -
@implementation NSMenu (Dark)
static int MAKE_DARK_KEY;

- (void)setDark:(BOOL)isDark;
{
	if (isDark) {
		NSMenuDarkMaker * maker = [[[NSMenuDarkMaker alloc] initWithMenu:self] autorelease];
		objc_setAssociatedObject(self, &MAKE_DARK_KEY, maker, OBJC_ASSOCIATION_RETAIN);
	} else {
		objc_setAssociatedObject(self, &MAKE_DARK_KEY, nil, OBJC_ASSOCIATION_RETAIN);
	}
}


- (BOOL)isDark;
{
	return (objc_getAssociatedObject(self, &MAKE_DARK_KEY) != nil);
}


- (void)makeDark;
{
	// Make it dark
	id impl = [self _menuImpl];
	if ([impl respondsToSelector:@selector(_principalMenuRef)]) {
		MenuRef m = [impl _principalMenuRef];
		if (m) {
			char on = 1;
			SetMenuItemProperty(m, 0, 'dock', 'dark', 1, &on);
		}
	}
	
	// Make all submenus dark too
	for (NSMenuItem * item in self.itemArray) {
		[item.submenu makeDark];
	}
}

@end






#pragma mark -
@implementation NSMenuDarkMaker

- (id)initWithMenu:(NSMenu *)menu;
{
	if (!(self = [super init])) return nil;
	mMenu = menu;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginTracking:) name:NSMenuDidBeginTrackingNotification object:mMenu];
	return self;
}


- (void)dealloc;
{
	mMenu = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}


- (void)beginTracking:(NSNotification *)note;
{
	[mMenu makeDark];
}

@end

