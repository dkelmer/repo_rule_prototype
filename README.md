There are two directories: one containing the repository rule definition (rule_definition) and another demonstrating usage (test_dir). To see the rule in action, cd into test_dir and run `bazel build :bar`. 

The repository rule (rule_collector_rule) invokes a tool that is packaged as a runnable artifact in the repository (rule_collector_deploy.jar). The tool expects as input a file which contains the direct maven dependencies and will calculate the transitive dependencies and put a flattened list in a bzl file and output this file. 

At least, that is the idea. This tool skips all the processing part and just dumps the list of "direct dependencies" into the bzl file :) 

Usage of the rule is in test_dir/WORKSPACE and the artifacts present in the bzl file produced by the repo rule are used in test_dir/BUILD. 