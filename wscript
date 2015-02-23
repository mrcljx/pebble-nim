
#
# This file is the default set of rules to compile a Pebble project.
#
# Feel free to customize this to your needs.
#

import shutil

from waflib import Task, TaskGen
from waflib.TaskGen import extension

top = '.'
out = 'build'

TaskGen.declare_chain(
    name='nim',
    rule=('${NIM} c '
          '--compileOnly '
          '--define:release '
          '--os:standalone '
          '--deadCodeElim:off '
          '--noMain '
          '--stackTrace:off '
          '--lineTrace:off '
          '--gc:none '
          '--parallelBuild:1 '
          '--app:staticlib '
          '--cpu:arm '
          '--nimcache:./src '
          '--threadanalysis:off '
          '--debugger:off '
          '${SRC}'),
    ext_in='.nim',
    ext_out='.c',)

def options(ctx):
    ctx.load('pebble_sdk')

def configure(ctx):
    ctx.load('pebble_sdk')

def build(ctx):
    ctx.env.NIM = 'nim'
    ctx.env.NIM_PATH = '/usr/local/opt/nimrod'

    shutil.copy2(ctx.env.NIM_PATH + '/nim/lib/nimbase.h', 'src/_nimbase.h')

    ctx.load('pebble_sdk')

    ctx.pbl_program(source=ctx.path.ant_glob('src/main.nim'),
                    target='pebble-app.elf')

    ctx.pbl_bundle(elf='pebble-app.elf',
                   js=ctx.path.ant_glob('src/js/**/*.js'))
