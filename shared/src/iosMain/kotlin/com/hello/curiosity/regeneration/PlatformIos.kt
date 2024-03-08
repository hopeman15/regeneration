package com.hello.curiosity.regeneration

import platform.UIKit.UIDevice

class PlatformIos: Platform {
    override val name: String = UIDevice.currentDevice.systemName() + " " + UIDevice.currentDevice.systemVersion
}

actual fun getPlatform(): Platform = PlatformIos()
