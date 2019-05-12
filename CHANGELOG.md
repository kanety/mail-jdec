# CHANGELOG

## 1.0.8

* Prefer utf-8 to us-ascii for header's charset.

## 1.0.7

* Force us-ascii when header's charset is not detected.
* Make autodetect_skip_charsets empty by default.

## 1.0.6

* Fix decoding for invalid ascii characters in mail header.

## 1.0.5

* Force utf-8 when charset is not detected.

## 1.0.4

* Sanitize some wrong parameters for content type and content disposition.
* Sanitize unescaped characters for RFC2231 filename.
* Strip null bytes from decoded string.
* Decode unicode-1-1-utf-7.
* Fallback parser errors for date and addresses.
* Fallback unknown encoding errors for body.
* Sort filename parameters by counter number.

## 1.0.3

* Fix decoding of quoted printable with space.

## 1.0.2

* Don't run auto-detection if content type is not text.

## 1.0.1

* Add path for references field to handle comma-splitted value.

## 1.0.0

* First release.
