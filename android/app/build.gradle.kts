import java.util.Properties

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use {
        keystoreProperties.load(it)
    }
}

// تعريف المتغيرات
val MY_KEYSTORE: String = keystoreProperties.getProperty("MY_KEYSTORE") ?: ""
val MY_KEYSTORE_PASSWORD: String = keystoreProperties.getProperty("MY_KEYSTORE_PASSWORD") ?: ""
val MY_KEY_ALIAS: String = keystoreProperties.getProperty("MY_KEY_ALIAS") ?: ""
val MY_KEY_PASSWORD: String = keystoreProperties.getProperty("MY_KEY_PASSWORD") ?: ""
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    signingConfigs {
        create("release") {
            storeFile = file(MY_KEYSTORE)
            storePassword = MY_KEYSTORE_PASSWORD
            keyAlias = MY_KEY_ALIAS
            keyPassword = MY_KEY_PASSWORD
        }
    }

    namespace = "com.example.minimal_weather_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.minimal_weather_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}