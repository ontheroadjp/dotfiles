#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
This script translates Japanese text from the clipboard to English using the DeepL API.
"""

import os
import sys

if sys.version_info[0] < 3:
    sys.stderr.write("This script requires Python 3.\n")
    sys.exit(1)

import pyperclip

# Suppress the NotOpenSSLWarning for environment-dependent SSL issues.
# This warning appears on macOS systems where the 'ssl' module is compiled with LibreSSL.
# See: https://github.com/urllib3/urllib3/issues/3020
import warnings
from urllib3.exceptions import NotOpenSSLWarning
warnings.filterwarnings("ignore", category=NotOpenSSLWarning)

import requests
from dotenv import load_dotenv

def main():
    """
    Main function to translate clipboard text.
    """
    script_dir = os.path.dirname(os.path.realpath(__file__))
    dotenv_path = os.path.join(script_dir, '.env')
    load_dotenv(dotenv_path=dotenv_path)

    api_key = os.getenv("DEEPL_API_KEY")
    if not api_key:
        sys.stderr.write("Error: DEEPL_API_KEY not found in .env file.\n")
        sys.exit(1)

    clipboard_text = pyperclip.paste()
    if not clipboard_text:
        sys.stderr.write("Error: No text found in the clipboard.\n")
        sys.exit(1)

    url = "https://api-free.deepl.com/v2/translate"
    params = {
        "auth_key": api_key,
        "text": clipboard_text,
        "source_lang": "JA",
        "target_lang": "EN",
    }

    try:
        response = requests.post(url, data=params)
        response.raise_for_status()
        translated_text = response.json()["translations"][0]["text"]
        print(translated_text)
    except requests.exceptions.RequestException as e:
        sys.stderr.write(f"Error: API request failed: {e}\n")
        sys.exit(1)
    except (KeyError, IndexError):
        sys.stderr.write("Error: Could not parse API response.\n")
        sys.exit(1)

if __name__ == "__main__":
    main()
