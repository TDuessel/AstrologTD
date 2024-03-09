# Astrolog TD

This is based on the "official" version of Astrolog 7.60 (released April 9, 2023)
described at: http://www.astrolog.org/astrolog.htm

The changes in version 7.60 are described at: http://www.astrolog.org/ftp/updat760.htm

This modified version of the software is available from [GitHub][astrolog-td].

This version of the software is inteded to be build with the GNU and/or
the MinGW compiler suite. 

The MS Visual Studio project files are kept in this repository for those who 
want to try bilding with them but will sooner or later stop beeing functional.

Recent changes in this version:

- Fix of wrongly scaled postscript output for formats other than 'Letter'.
- Decan and ruler changes can be listed with aspects and progressions.
- Makefile for building the Windows version with the MinGW toolchain
- Bugfix for internal handling of chart information (by [CruiserOne][])
- Drop usage of register storage class specifier (by [listout][])
- Ephemeris files moved into subfolder 'ephem'
- Line endings in all text files changed from CRLF to LF

[astrolog-td]: https://github.com/TDuessel/AstrologTD
[listout]: https://github.com/listout
[CruiserOne]: https://github.com/CruiserOne
