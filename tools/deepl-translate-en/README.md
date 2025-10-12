# DeepL Translate English

This script translates Japanese text from the clipboard to English using the DeepL API.

## Requirements

- Python 3
- See `requirements.txt` for dependencies.

## Installation

1.  Install the required Python libraries using pip. The `--user` flag is recommended to avoid modifying system-wide packages.

    ```bash
    python3 -m pip install --user -r /Users/hideaki/dotfiles/tools/deepl-translate-en/requirements.txt
    ```

2.  Create a `.env` file in the `tools/deepl-translate-en/` directory.

3.  Add your DeepL API key to the `.env` file:

    ```
    DEEPL_API_KEY=your_api_key
    ```

## Usage

1.  Copy some Japanese text to your clipboard.
2.  Run the script:

    ```bash
    ./tools/deepl-translate-en/deepl-translate-en.py
    ```

The English translation will be printed to the standard output.

You can pipe the output to `pbcopy` to copy the translation to your clipboard:
```bash
./tools/deepl-translate-en/deepl-translate-en.py | pbcopy
```

Or redirect it to a file:
```bash
./tools/deepl-translate-en/deepl-translate-en.py > translation.txt
```
