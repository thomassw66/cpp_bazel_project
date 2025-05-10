
cc_binary(
    name = "hello-world",
    srcs = ["hello-world.cc"],
	  copts = [
	  ]
)

genrule(
  name = "g",
  outs = [
    "g.txt",
  ],
  cmd = "echo \"$(TARGET_CPU) $(COMPILATION_MODE) $(JAVA) $(JAVABASE)\" > $@",
  toolchains = [
    "@bazel_tools//tools/jdk:current_java_runtime",
  ],
)
