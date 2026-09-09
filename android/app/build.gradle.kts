import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("com.palantir.git-version")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

val keystorePropertiesDebug = Properties()
val keystorePropertiesDebugFile = rootProject.file("key.debug.properties")
if (keystorePropertiesDebugFile.exists()) {
    keystorePropertiesDebug.load(FileInputStream(keystorePropertiesDebugFile))
}

val releaseChannelEnv = System.getenv("RELEASE_CHANNEL") ?: "debug"

val versionDetails: groovy.lang.Closure<com.palantir.gradle.gitversion.VersionDetails> by extra
val gitHash = versionDetails().gitHash

android {
    namespace = "com.karasu256.denpamemo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    buildFeatures {
        buildConfig = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.karasu256.denpamemo"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
        if (keystorePropertiesDebugFile.exists()) {
            getByName("debug") {
                keyAlias = keystorePropertiesDebug["keyAlias"] as String?
                keyPassword = keystorePropertiesDebug["keyPassword"] as String?
                storeFile = keystorePropertiesDebug["storeFile"]?.let { file(it as String) }
                storePassword = keystorePropertiesDebug["storePassword"] as String?
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            versionNameSuffix = "-$gitHash-$releaseChannelEnv"
            buildConfigField("String", "RELEASE_CHANNEL", "\"$releaseChannelEnv\"")
        }
        debug {
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-$gitHash-$releaseChannelEnv"
            buildConfigField("String", "RELEASE_CHANNEL", "\"$releaseChannelEnv\"")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.material:material:1.14.0")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
