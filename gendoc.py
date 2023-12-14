#!/usr/bin/env python3

import datetime
import logging
import os
import pathlib
import shutil
import subprocess
import sys
import typing
from dataclasses import dataclass

import click
from mdutils.mdutils import MdUtils
from tinydb import Query, TinyDB

def collect_symbols(p):

@click.command()
@click.option(
    "-d",
    "--debug",
    "debug_opt",
    is_flag=True,
    help="enable debug",
)
def gendoc(debug_opt):
    with os.scandir("./lua/commons") as modules:
        for entry in modules:
            if entry.name.endswith(".lua") and entry.is_file():
                print(entry.name, entry.path)


if __name__ == "__main__":
    gendoc()
