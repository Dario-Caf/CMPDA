#!/usr/bin/env python

"""
   Installing from local source in Development Mode, i.e. in such a way that the
   project appears to be installed, but yet is still editable from the src tree:

      $ git clone https://github.com/Dario-Caf/EM-shower-simulator-with-NN.git
      $ cd EM-shower-simulator-with-NN
      $ python3 -m pip install -e .

   All of the package's informations are stored in setup.cfg and are passed as
   arguments to setuptools.setup() when it is executed through pip install.
"""

import setuptools

with open('requirements.txt', 'r') as f:
    _DEPENDENCIES = f.read().splitlines()

_PACKAGES = setuptools.find_packages(exclude='tests')

setuptools.setup(install_requires=_DEPENDENCIES, packages=_PACKAGES)
