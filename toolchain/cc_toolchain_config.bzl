# toolchain/cc_toolchain_config.bzl:
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

# NEW
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    tool_paths = [
        # NEW
        tool_path(
            name = "gcc",
            path = "/Users/allstar/llvm/bin/clang",
        ),
        tool_path(
            name = "ld",
            path = "/Users/allstar/bin/lld",
        ),
        tool_path(
            name = "ar",
            path = "/Users/allstar/bin/llvm-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/Users/allstar/llvm/bin/clang++",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "nm",
            path = "/Users/allstar/llvm/bin/llvm-nm",
        ),
        tool_path(
            name = "objdump",
            path = "/Users/allstar/llvm/bin/llvm-objdump",
        ),
        tool_path(
            name = "strip",
            path = "/Users/allstar/llvm/bin/llvm-strip",
        ),
    ]
    features = [
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
											flag_group(flags = [
												"-lstdc++",
												"-L/Users/allstar/llvm/lib",
												"-Wl,-rpath,/Users/allstar/llvm/lib",
											])
										]),
                ),
            ],
        ),

    ]
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        cxx_builtin_include_directories = [
            "/Users/allstar/llvm/lib/clang/20/include",
            "/Users/allstar/llvm/include",
						"/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.0.sdk/usr/include",
        ],
        features = features,
        toolchain_identifier = "local",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "darwin_arm64",
        target_libc = "unknown",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,  # NEW
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
