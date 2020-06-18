package org.kouky.server;

import io.javalin.Javalin;

public class HelloWorldServer {
    public static void main(String[] args) {
        Javalin app = Javalin.create().start(7000);
        app.get("/", ctx -> ctx.result("Hello World"));
    }
}