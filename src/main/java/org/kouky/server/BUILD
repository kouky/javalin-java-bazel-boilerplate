java_binary(
    name = "hello_world_server",
    main_class = "org.kouky.server.HelloWorldServer",
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":hello_world_server_lib",
    ],
)

java_library(
    name = "hello_world_server_lib",
    srcs = glob(["*.java"]),
    deps = [
        "@third_party//3rdparty/jvm/io/javalin:javalin",
        "@third_party//3rdparty/jvm/org/slf4j:slf4j_simple",

    ],
)

