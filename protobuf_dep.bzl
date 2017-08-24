load("//tools:github.bzl", "github_archive")
load("//tools:ros.bzl", "ros_compatible_mode")

def protobuf_dep():
    if ros_compatible_mode():
        # TODO: implement the method to get the system protobuf installation
        print("Look for the system protobuf installation")
    else:
        github_archive(
            name = "protobuf",
            repository = "google/protobuf",
            commit = "v3.1.0",
            sha256 = "0a0ae63cbffc274efb573bdde9a253e3f32e458c41261df51c5dbc5ad541e8f7",  # noqa
        )
