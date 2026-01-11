load("@bazel_skylib//rules:write_file.bzl", "write_file")
load("@rules_uv//uv:pip.bzl", "pip_compile")
load("@rules_uv//uv:venv.bzl", "create_venv", "sync_venv")

pip_compile(
    name = "generate_requirements_txt",
    requirements_in = "//:requirements.in",
    requirements_txt = "//:requirements.txt",
)

create_venv(name = "create_venv")

sync_venv(
    name = "sync_venv",
    destination_folder = ".sync_venv",
)
