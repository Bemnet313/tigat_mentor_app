allprojects {
    repositories {
        google()
        mavenCentral()
    }
    // Force-resolve the test dependencies that Flutter's own Gradle plugin
    // declares internally (flutter_tools/gradle/build.gradle.kts). Without this,
    // the IDE reports them as "unresolved" during Gradle sync.
    configurations.all {
        resolutionStrategy {
            force("org.jetbrains.kotlin:kotlin-test:2.0.21")
            force("org.mockito:mockito-core:5.8.0")
            force("io.mockk:mockk:1.13.16")
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
