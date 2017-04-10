#!/usr/bin/python3

import pkgconfig

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize

cflags = pkgconfig.cflags('purple')
ldflags = pkgconfig.libs('purple')

long_description = "\
Python bindings for libpurple, a multi-protocol instant messaging library."

class pypurple_build_ext(build_ext):
    def finalize_options(self):
        build_ext.finalize_options(self)
        self.include_dirs.insert(0, 'libpurple')
        self.pyrex_include_dirs.extend(self.include_dirs)

sourcefiles = ['purple/purple.pyx', 'purple/c_purple.c']
extensions = [Extension("purple", sourcefiles,
                        extra_compile_args=cflags.split(),
                        extra_link_args=ldflags.split())]
setup(
    name='purple',
    version='0.0.1',
    author='Andrey Petrov',
    author_email='andrey.petrov@gmail.com',
    packages=['purple'],
    description='Python bindings for Purple',
    url="https://github.com/anpetrov/python-purple",
    download_url="https://github.com/anpetrov/python-purple/archive/0.0.1.tar.gz",
    long_description=long_description,
    include_package_data=True,
    ext_modules=cythonize(extensions, include_path=["purple/libpurple"]),
    cmdclass={'build_ext': pypurple_build_ext}
)
