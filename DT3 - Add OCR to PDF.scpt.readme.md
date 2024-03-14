DEVONthink 3 script to automatically OCR PDFs using a local install of https://ocrmypdf.readthedocs.io/

# Install OCRmyPDF

Easiest is to use homebrew:

```
brew install ocrmypdf
```

If you need languages other than English, install additional language pack:

```
brew install tesseract-lang
```

# Customize the `.scpt` script

- Set `strExportPath` to include the `ocrmypdf` binary path. Default value is valid for an install with homebrew.
- Set the [OCRmyPDF parameters you need](https://ocrmypdf.readthedocs.io/en/latest/cookbook.html#image-processing) in `strCmd`, specifically if you want to [use other languages](https://ocrmypdf.readthedocs.io/en/latest/cookbook.html#ocr-languages-other-than-english), e.g. for French: `-l fra` (you can get other language codes with `tesseract --list-langs)`.
- Finally copy the script file to `~/Library/Application Scripts/com.devon-technologies.think3/Smart Rules` (path for DEVONthink 3 beta)

# Create smart rules in DEVONthink

## Automatic OCR

Create a new smart rule by right-clicking in sidebar > New Smart Rule...

- Name: `PDFs without OCR`
- Search in: `Databases`
- Search all:
  - `Kind` is `PDF/PS`
  - `Extension` is `PDF document` (_required as some .AI files are recognized as PDF kind as well_)
  - `Word Count` is `0`
  - `Tag` is not `ocr_error` (_this is how we automatically exclude files which couldn't be OCR'd for some reason_)
  - `Tag` is not `ocr_ignore` (_this is how we **manually** exclude files which we don't want to OCR_)
- Perform the following actions: `Daily` (_as I always keep DT open, this is how I make sure it's done automatically. But feel free to adapt it to your needs_)
- Action: `Execute Script` - `External` - `DT3 - Add OCR to PDF`

## OCR failures

To list files which couldn't be OCR'd for some reason, create another smart rule:

- Name: `OCR errors`
- Search in: `Databases`
- Search all:
  - `Tag` is `ocr_error`
- Perform the following actions: `Weekly`
- Actions: 
  - Bounce Dock Icon
  - Display Notification: `Some PDFs cannot be OCR'd.`

# Usage

## Automatic OCR

First rule `PDFs without OCR` will show you all the PDF files which require OCR.
OCR will be triggered every day (early morning for me, when laptop automatically wakes up to backup).

To bypass OCR for some files, add tag `ocr_ignore`.

## OCR failures

Second rule will show a weekly reminder when there's some file waiting to be checked manually.
To get details about why OCR didn't succeed, try running the `ocrmypdf` command manually on the files.

One possible fix is to try to [force OCR](https://ocrmypdf.readthedocs.io/en/latest/cookbook.html#redo-existing-ocr) (try first with `--redo-ocr` before doing `--force-ocr`).
Otherwise you'll probably have to "fix" the PDF (e.g. extract each page individually and create a new PDF), before OCR'ing it again.