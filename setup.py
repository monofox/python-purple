#!/usr/bin/python3

import pkgconfig

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

cflags = pkgconfig.cflags('purple')
ldflags = pkgconfig.libs('purple')

long_description = "\
Python bindings for libpurple, a multi-protocol instant messaging library."

class pypurple_build_ext(build_ext):
    def finalize_options(self):
        build_ext.finalize_options(self)
        self.include_dirs.insert(0, 'libpurple')
        self.pyrex_include_dirs.extend(self.include_dirs)

setup(name = 'python-purple',
      version = '0.1',
      author ='Bruno Abinader',
      author_email = 'bruno.abinader@openbossa.org',
      description = 'Python bindings for Purple',
      long_description = long_description,
      ext_modules = [purplemodule],
      cmdclass = {'build_ext': pypurple_build_ext},
      )
                  extra_compile_args=cflags.split(),
                  extra_link_args=ldflags.split())
