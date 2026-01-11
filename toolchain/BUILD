package(default_visibility = ["//visibility:public"])

load(":cc_toolchain_config.bzl", "cc_toolchain_config")

CLANG20_ROOT = "/Users/allstar/llvm"

MACOS_SDK_PATH = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.0.sdk"

cc_toolchain_suite(
    name = "clang_suite",
    toolchains = {
        "darwin_arm64": ":darwin_arm64_toolchain",
    },
)

filegroup(name = "empty")

# darwin_arm64
cc_toolchain(
    name = "darwin_arm64_toolchain",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":darwin_arm64_toolchain_config",
    toolchain_identifier = "darwin_arm64-toolchain",
)

cc_toolchain_config(name = "darwin_arm64_toolchain_config")

toolchain(
    name = "toolchain",
    exec_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:arm64",
    ],
    target_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:arm64",
    ],
    toolchain = ":darwin_arm64_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
