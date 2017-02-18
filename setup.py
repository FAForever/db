from distutils.core import setup
from setuptools import find_packages

setup(
    name='faf-db',
    version='20',
    url='http://www.faforever.com',
    packages=['faf'] + find_packages(),
    license='GPLv3',
    author='Michael Sondergaard, Michel Jung',
    author_email='sheeo@faforever.com',
    description='FAF database project',
    requires=['pymysql', 'aiomysql']
)
