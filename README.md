# TreesMaxComp
Maximum layer composition performance test for iOS/SpriteKit

This example app provides a GUI that makes it possible to add full screen iPad 2x sized images at 2048x1536 pixels.

I OpenGL mode: PrefersOpenGL=YES in Info.plist

	With 7 layers : 60 FPS
	With 8 layers : 50 FPS
	With 9 layers : 44 FPS
	With 10 layers: 39 FPS

Metal mode: PrefersOpenGL=NO in Info.plist

	With 7 layers : 60 FPS
	With 8 layers : 57 FPS
	With 9 layers : 50 FPS
	With 10 layers: 46 FPS

The Metal results are slightly better, but basically 8 layers of 2048x1536 (about 12 megs of pixels each layer)
is the limit of what this iPad 4 64bit hardware can handle while still pushing 60 FPS.

