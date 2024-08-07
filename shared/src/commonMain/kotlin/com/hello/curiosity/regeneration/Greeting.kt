package com.hello.curiosity.regeneration

class Greeting {
    private val platform: Platform = getPlatform()

    fun greet(): String = "Hello, ${platform.name}!"
}
