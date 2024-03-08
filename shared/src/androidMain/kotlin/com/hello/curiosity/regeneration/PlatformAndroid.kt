package com.hello.curiosity.regeneration

class PlatformAndroid : Platform {
    override val name: String = "Android ${android.os.Build.VERSION.SDK_INT}"
}

actual fun getPlatform(): Platform = PlatformAndroid()
