# SwiftXPC

This is a Swift binding of the OS X XPC module. It makes it possible to call 95% of the public XPC API
from pure Swift. (The only part of XPC that isn’t exposed currently is the API found in `<xpc/activity.h>`.)

To use this framework, you must be running Xcode 6 beta 4. Clone this repository, add the Xcode project
to your application, and copy `SwiftXPC.framework` into your app’s Frameworks folder.
