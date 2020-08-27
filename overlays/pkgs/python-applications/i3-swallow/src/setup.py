from setuptools import setup
import shutil
import os

setup(
    name='i3-swallow',
    version='1',
    packages=['i3swallow'],
    package_data={},
    author="tesq0",
    author_email="",
    description="I3 window swallow functionality",
    long_description=open('README.md').read(),
    long_description_content_type='text/x-md',
    license="GPLv3",
    keywords="i3 swallow",
    url="https://gist.github.com/windwp/b46e8bdeac793867b34d2191e66a6f44",
    entry_points={
        'console_scripts': ['i3-swallow = i3swallow.i3swallow:main']
    },
    install_requires=[
        "i3ipc"
    ],
    data_files=[
        ('share/man/man1', ['i3-swallow.1'] if os.path.exists('i3-swallow.1') else []),
    ],
    classifiers=[
        "Programming Language :: Python :: 3",
    ]
)
