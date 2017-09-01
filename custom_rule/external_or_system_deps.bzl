load("//tools:github.bzl", "github_archive")

_UBUNTU_1604_CHECKER="""\
#!/usr/bin/env python

import platform
import sys

if platform.system() != "Linux":
  sys.exit(1)

distro_name, version_number, version_alias = platform.linux_distribution()


if distro_name != "Ubuntu":
  sys.exit(1)

if version_number != 16.04:
  sys.exit(0)

sys.exit(1)
"""

def _impl(repository_ctx):
    python = repository_ctx.which("python")

    if not python:
        fail("Could NOT find python{}".format(repository_ctx.attr.version))

    repository_ctx.file("BUILD", '', executable = False)
    repository_ctx.file('ubuntu_1604_checker.py', _UBUNTU_1604_CHECKER, True)
    result = repository_ctx.execute(["./ubuntu_1604_checker.py"])

    if result.return_code != 0:
        print("Ubuntu NOT Xenial")
    else:
        print("Ubuntu Xenial detected")
        # FAILING HERE: "The native module cannot be accessed from here."
        # repository_rule can not call macros that calls native. method
        github_archive(
            name = "gtest",
            repository = "google/googletest",
            commit = "release-1.8.0",
            sha256 = "5a177609e9c488e8a72649359ba51450db7d8",
            build_file = "tools/gtest.BUILD")

xenial_compatible_dep = repository_rule(
    implementation=_impl,
    local=True)
