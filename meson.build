project(
    'meson template',
    'cpp', 'c',
    version: '0.1.0',
    license: 'MIT',
    default_options: ['warning_level=1', 'cpp_std=c++20', 'c_std=c11'],
    meson_version: '>=1.0',
)


deps = [
    dependency('threads'),
]

template = executable(
    'template',
    'src/main.cpp',
    dependencies: deps,
    install: true,
)
