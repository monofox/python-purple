#!/usr/bin/python3

import pkgconfig

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

cflags = pkgconfig.cflags('purple')
ldflags = pkgconfig.libs('purple')

purplemodule = Extension('purple',
                         sources=['c_purple.c','purple.c'],
                         extra_compile_args=cflags.split(),
                         extra_link_args=ldflags.split())

long_description = "\
Python bindings for libpurple, a multi-protocol instant messaging library."

setup(name = 'python-purple',
      version = '0.1',
      author ='Bruno Abinader',
      author_email = 'bruno.abinader@openbossa.org',
      description = 'Python bindings for Purple',
      long_description = long_description,
      ext_modules = [purplemodule],
      )
                  extra_compile_args=cflags.split(),
                  extra_link_args=ldflags.split())
