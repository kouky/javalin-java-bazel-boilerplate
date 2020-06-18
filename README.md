# Javalin Java Bazel Boilerplate

Boilerplate for a [Javalin](https://javalin.io/) web server written in Java and built with [Bazel](https://bazel.build/).

Generate Bazel dependencies transitively using [bazel-deps](https://github.com/johnynek/bazel-deps)

    ./update_dependencies.sh

Build and run the web server for local development

    make local

Build and run the web server as a self-contained deployable binary    
 
    make deploy

Can be used with IntelliJ by installing the [Bazel plugin](https://ij.bazel.build/docs/bazel-plugin.html) and importing with the provided `.bazelproject` project view file.
