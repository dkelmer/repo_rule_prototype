def _bazel_deps_impl(repository_ctx):

    print("executing rule collector rule")

    repository_ctx.file("BUILD")

    # TODO: check bzl_filename and pass it (and remove default name from deploy jar)

    rule_collector_tool_path = repository_ctx.path(repository_ctx.attr._rule_collector_tool)
    direct_deps_file_path = repository_ctx.path(repository_ctx.attr.direct_deps_file)
    res = repository_ctx.execute(["java",
                            "-jar",
                            rule_collector_tool_path,
                            direct_deps_file_path])
    return None

rule_collector_rule = repository_rule(
    implementation = _bazel_deps_impl,
    attrs = {
        "direct_deps_file": attr.label(allow_single_file = True, default = Label("//:input.txt", relative_to_caller_repository=True)),
        "bzl_filename": attr.string(default = "repositories.bzl"),
        "_rule_collector_tool": attr.label(default = Label("//:rule_collector_deploy.jar")),
        "_java": attr.string(default = "java")
    },
)