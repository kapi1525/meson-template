project(
    'meson template',
    'cpp',
    version: '0.1.0',
    license: 'MIT',
    default_options: ['warning_level=3', 'cpp_std=c++17', 'c_std=c11'],
    meson_version: '>=0.60.0',
)


files = files(
    'src/main.cpp',
)

# includes = include_directories(
#     '',
# )

deps = [
    dependency('threads'),
]

template = executable(
    'template',
    files,
    # include_directories: includes,
    dependencies: deps,
)
