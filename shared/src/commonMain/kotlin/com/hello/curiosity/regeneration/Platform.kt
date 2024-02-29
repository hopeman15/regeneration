package com.hello.curiosity.regeneration

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform
