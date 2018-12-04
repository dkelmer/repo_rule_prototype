def _bazel_deps_impl(ctx):

    # create output file??
    output_file = ctx.file("repositories.bzl")


    # run jar...
    command = "{java} -jar {rule_collector} {direct_deps_file} {output_file}".format(
        java = ctx.attr._java,
        rule_collector = ctx.attr._rule_collector_tool,
        direct_deps_file = ctx.attr.direct_deps_file,
        output_file = output_file
    )


    ctx.symlink(ctx.os.environ[ctx.attr.env], ctx.attr.env)
    ctx.file("BUILD", ctx.attr.build_file)
    return None

rule_collector_rule = repository_rule(
    implementation = _bazel_deps_impl,
    attrs = {
        "direct_deps_file": attr.label(mandatory = True, allow_single_file = True),
#        "output_file": attr.label(allow_single_file = True),
        "_rule_collector_tool": attr.string(default = "rule_collector_deploy.jar"),
        "_java": attr.string(default = "java")
    },
)