NSMenu+Dark.h
=============

Rather than finish building my from-scratch custom black NSMenus, I
decided to look into how the Dock gets them. Since Apple refuses to
let QuickPick in the Mac App Store, I don't need to worry about
using private APIs anyway. ;)

The menus are darkened by setting a property on the Carbon MenuRef
for the NSMenu. I'm not 100% certain this is how the Dock does it,
(IOW, I can't find it actually set this property), but it's a legit
technique anyway.


![Screenshot](https://github.com/swillits/NSMenu-Dark/raw/master/Screenshot.png)


Usage
=============
Using NSMenu+Dark.h, all you need to do is:

	menu.dark = YES;


Requirements
=============
This requires linking against Carbon, but the private functions used
are in 64-bit, so this isn't 32-bit only. I've confirmed that this
property works on 10.6, 10.7, and 10.8.


License
=============
Code-level credit would be nice. No credit visible to the end-user
is necessary.


--

Seth Willits
http://www.araelium.com/
