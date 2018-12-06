def _bazel_deps_impl(repository_ctx):

    print("executing rule collector rule")

    repository_ctx.file("BUILD")
#    repository_ctx.file("repositories.bzl")

    print("rule collector tool : ", repository_ctx.attr._rule_collector_tool)
    rule_collector_tool_path = repository_ctx.path(repository_ctx.attr._rule_collector_tool)
    print("rule collector tool path: ", rule_collector_tool_path)
    print("rule collector tool??", repository_ctx.which(repository_ctx.attr._rule_collector_tool_string))
    print("java: ", repository_ctx.which("java"))
    print("direct deps file: ", repository_ctx.attr.direct_deps_file)
    direct_deps_file_path = repository_ctx.path(repository_ctx.attr.direct_deps_file)
    print("direct deps file path: ", direct_deps_file_path)
    print("direct deps file name: ", repository_ctx.attr.direct_deps_file.name)
    print ("output file name: ", repository_ctx.attr.bzl_filename)



    # run jar
    command = "{java} -jar {rule_collector} {direct_deps_file} {output_file}".format(
        java = repository_ctx.attr._java,
        rule_collector = repository_ctx.attr._rule_collector_tool,
        direct_deps_file = repository_ctx.attr.direct_deps_file.name,
        output_file = repository_ctx.attr.bzl_filename
    )

    res = repository_ctx.execute(["java",
                            "-jar",
                            rule_collector_tool_path,
                            direct_deps_file_path],
                            quiet = False)

    print("after execute")
    print(dir(res))
    print(res.return_code)
    print(res.stderr)

    return None

rule_collector_rule = repository_rule(
    implementation = _bazel_deps_impl,
    attrs = {
        "direct_deps_file": attr.label(allow_single_file = True, default = Label("//:input.txt", relative_to_caller_repository=True)),
        "bzl_filename": attr.string(default = "repositories.bzl"),
#        "output_file": attr.label(allow_single_file = True),
        "_rule_collector_tool_string": attr.string(default = "rule_collector_deploy.jar"),
        "_rule_collector_tool": attr.label(default = Label("//:rule_collector_deploy.jar")),
        "_java": attr.string(default = "java")
    },
)