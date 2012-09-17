//
//  NSMenu+Dark.h
//  Dark NSMenu
//
//  Created by Seth Willits on 9/17/12.
//  Copyright (c) 2012 Araelium Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSMenu (Dark)
@property (readwrite, nonatomic, setter=setDark:) BOOL isDark;
@end
