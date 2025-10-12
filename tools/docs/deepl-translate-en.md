# DeepL Translate English Tool

## Overview

This document provides a specification for the `deepl-translate-en.py` script.

## Purpose

The `deepl-translate-en.py` script is a command-line tool that translates Japanese text to English. It is designed to be simple and easy to use, integrating with the system clipboard for input.

## Features

-   Translates Japanese text from the clipboard to English.
-   Uses the DeepL API for translation.
-   Securely handles the API key using a `.env` file.
-   Outputs the translated text to standard output.
-   Provides clear error messages for common issues (e.g., missing API key, empty clipboard, API errors).

## Technical Details

-   **Language:** Python 3
-   **Libraries:**
    -   `requests`: For making HTTP requests to the DeepL API.
    -   `pyperclip`: For accessing the system clipboard.
    -   `python-dotenv`: For loading environment variables from a `.env` file.
-   **API Endpoint:** `https://api-free.deepl.com/v2/translate`
-   **Authentication:** The DeepL API key is passed in the `auth_key` parameter of the request.

## Error Handling

The script handles the following error conditions:

-   **Missing `DEEPL_API_KEY`:** If the `DEEPL_API_KEY` is not found in the `.env` file, the script will print an error message to `stderr` and exit with a status code of 1.
-   **Empty Clipboard:** If no text is found in the clipboard, the script will print an error message to `stderr` and exit with a status code of 1.
-   **API Request Failed:** If the request to the DeepL API fails for any reason (e.g., network error, invalid API key), the script will print an error message to `stderr` and exit with a status code of 1.
-   **Invalid API Response:** If the API response is not in the expected format, the script will print an error message to `stderr` and exit with a status code of 1.
