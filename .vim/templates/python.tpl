import argparse
import os
import sys
from pathlib import Path
import glob
#import codecs
#import re
#import requests
#import shutil
#from time import sleep

#from selenium import webdriver
#from selenium.webdriver.chrome.options import Options
#from bs4 import BeautifulSoup
#
#import yt_dlp
#
#import eyed3
from eyed3.id3.frames import ImageFrame

SELF = os.path.basename(__file__)

def _init():
    parser = argparse.ArgumentParser(
        prog = SELF
        , usage='python ' + SELF +  '<dir>'
        , description = 'This script is python script.'
        , epilog='end'
        , add_help=True
    )
    parser.add_argument('directory'
        , type = Path
        , default = './'
        , help = 'Target directory'
    )
    args = parser.parse_args()
    return args

def main(ini):
    print('welcome!')

main(_init())
print('All done.')
