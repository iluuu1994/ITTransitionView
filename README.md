ITTransitionView
================

What is this?
-------------

`ITTransitionView` is a port of [ADTransitionController](https://github.com/applidium/ADTransitionController) from iOS to Mac OS X.


Demo
----

[Here you go](./demo.mp4)  
If someone is not too lazy to make some gifs, let me know ;)


What makes it special?
----------------------

Mixing Core Animation with AppKit can cause issues, which is why the content of the `NSView` will be cached into a layer-backed `NSView`, rather than layer-backing itself.

This enables you to keep your views non-layer-backed, but animatable.


How to use?
-----------

Look at the demo-project. Using `ITTransitionView` is fairly simple.


ARC
---

ARC is not supported, it is required. 
