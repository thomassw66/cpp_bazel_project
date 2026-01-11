load("@pybind11//:build_defs.bzl", "pybind_extension")
load("@rules_python//python:defs.bzl", "py_test")

cc_binary(
    name = "hello-world",
    srcs = ["hello-world.cc"],
    copts = [
    ],
)

pybind_extension(
    name = "hello_pybind",
    srcs = ["hello_pybind.cc"],
    visibility = ["//visibility:public"],
    deps = [
        "@eigen",
    ],
)

py_library(
    name = "hello_pybind_lib",
    data = [":hello_pybind"],
    imports = ["."],
)

py_test(
    name = "test_hello_pybind",
    srcs = ["test_hello_pybind.py"],
    python_version = "PY3",
    deps = [
        ":hello_pybind_lib",
        "@pypi//numpy",
    ],
)

cc_binary(
    name = "hello_aarch64",
    srcs = ["hello_world.s"],
    deps = [
        ":add_two_ints",
    ],
)

cc_library(
    name = "add_two_ints",
    srcs = [
        "add_two_ints.s",
    ],
    hdrs = [
        "add_two_ints.h",
    ],
    features = ["-libtool"],
)
