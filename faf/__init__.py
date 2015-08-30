"""
Required to make faf work as a namespace package on Python < 3.3
"""
from pkgutil import extend_path
__path__ = extend_path(__path__, __name__)
