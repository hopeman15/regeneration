import io.gitlab.arturbosch.detekt.Detekt
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    alias(libs.plugins.androidApplication) apply false
    alias(libs.plugins.androidLibrary) apply false
    alias(libs.plugins.compose.compiler) apply false
    alias(libs.plugins.detekt)
    alias(libs.plugins.kotlinAndroid) apply false
    alias(libs.plugins.kotlinMultiplatform) apply false
    alias(libs.plugins.kotlinter)
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        jvmTarget = "17"
    }
}

allprojects {
    apply(plugin = "io.gitlab.arturbosch.detekt")
    apply(plugin = "org.jmailen.kotlinter")

    detekt {
        config.setFrom("$rootDir/detekt/detekt.yml")
        buildUponDefaultConfig = true
    }

    tasks.withType<Detekt>().configureEach {
        reports {
            xml.required.set(false)
            html.required.set(true)
            txt.required.set(false)
            sarif.required.set(false)
            md.required.set(false)
        }
    }
}
