import json
from setuptools import setup, find_packages

with open('install.json', 'r') as fh:
    version = json.load(fh)['programVersion']

if not version:
    raise RuntimeError('Cannot find version information')

setup(
    author='Floyd Hightower',
    description='Iterate through an array and send each item to a playbook trigger.',
    name='array_iterator',
    packages=find_packages(),
    version=version
)
