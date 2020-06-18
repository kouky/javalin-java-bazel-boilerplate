# Build and run a self-contained, deployable binary
# https://docs.bazel.build/versions/master/tutorial/java.html#package-a-java-target-for-deployment
deploy:
	@bazel build //src/main/java/org/kouky/server:hello_world_server_deploy.jar
	@bazel-bin/src/main/java/org/kouky/server/hello_world_server --singlejar

# Build and run locally
local:
	@bazel build //src/main/java/org/kouky/server:hello_world_server
	@bazel-bin/src/main/java/org/kouky/server/hello_world_server

