package com.hello.curiosity.regenranch

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform