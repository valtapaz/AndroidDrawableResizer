@REM AndroidDrawableResizer (https://github.com/delight-im/AndroidDrawableResizer)
@REM Copyright (c) delight.im (https://www.delight.im/)
@REM Licensed under the MIT License (https://opensource.org/licenses/MIT)

@echo off

@REM ### BEGIN CONFIGURATION ###
set IMAGE_MAGICK_PATH=""C:\Program Files\ImageMagick-7.1.0-Q16-HDRI\magick.exe""
@REM ### END CONFIGURATION ###

echo This file has been modified to assume that the input density is set to xxxhdpi (1920x1280, or 1280x1920). It may not work otherwise.
::echo Resize all PNGs in this script's folder for all densities?
::echo Type current density of those PNGs below. Example: mdpi
set inputDensity=xxxhdpi

echo Portrait or Landscape? [P/L]
set /p rotation=

if /i %rotation%==L (
	set EXTENDED=""-extent 111.11111111111x100%%""
	set EXTENDED2=""-extent 118.5x100%%""
	set PATH_MDPI=drawable-land-mdpi
	set PATH_HDPI=drawable-land-hdpi
	set PATH_XHDPI=drawable-land-xhdpi
	set PATH_XXHDPI=drawable-land-xxhdpi
	set PATH_XXXHDPI=drawable-land-xxxhdpi
) else (
	set EXTENDED=""-extent 100x111.11111111111%%""
	set EXTENDED2=""-extent 100x118.5%%""
	set PATH_MDPI=drawable-port-mdpi
	set PATH_HDPI=drawable-port-hdpi
	set PATH_XHDPI=drawable-port-xhdpi
	set PATH_XXHDPI=drawable-port-xxhdpi
	set PATH_XXXHDPI=drawable-port-xxxhdpi
)

if /i %inputDensity%==xxxhdpi (
	set PERCENT_MDPI=25%%
	set PERCENT_HDPI=37.5%%
	set PERCENT_XHDPI=56.25%%
	set PERCENT_XXHDPI=75%%
	set PERCENT_XXXHDPI=100%%
) else (
	exit
)

echo.

if exist %PATH_MDPI% (
	echo Directory %PATH_MDPI% does already exist.
) else (
	mkdir %PATH_MDPI%
)
if exist %PATH_HDPI% (
	echo Directory %PATH_HDPI% does already exist.
) else (
	mkdir %PATH_HDPI%
)
if exist %PATH_XHDPI% (
	echo Directory %PATH_XHDPI% does already exist.
) else (
	mkdir %PATH_XHDPI%
)
if exist %PATH_XXHDPI% (
	echo Directory %PATH_XXHDPI% does already exist.
) else (
	mkdir %PATH_XXHDPI%
)
if exist %PATH_XXXHDPI% (
	echo Directory %PATH_XXXHDPI% does already exist.
) else (
	mkdir %PATH_XXXHDPI%
)

set SETUP=""-gravity center -background white""

echo Moving on...
for %%f in (*.png) do (
	echo %%f
	if not [%PERCENT_MDPI%]==[] (
		"%IMAGE_MAGICK_PATH%" "%%f" -resize %PERCENT_MDPI% "%~dp0%PATH_MDPI%\%%f"
	)
	if not [%PERCENT_HDPI%]==[] (
		"%IMAGE_MAGICK_PATH%" "%%f" -resize %PERCENT_HDPI% %SETUP% %EXTENDED% "%~dp0%PATH_HDPI%\%%f"
	)
	if not [%PERCENT_XHDPI%]==[] (
		"%IMAGE_MAGICK_PATH%" "%%f" -resize %PERCENT_XHDPI% %SETUP% %EXTENDED2% "%~dp0%PATH_XHDPI%\%%f"
	)
	if not [%PERCENT_XXHDPI%]==[] (
		"%IMAGE_MAGICK_PATH%" "%%f" -resize %PERCENT_XXHDPI% %SETUP% %EXTENDED% "%~dp0%PATH_XXHDPI%\%%f"
	)
	if not [%PERCENT_XXXHDPI%]==[] (
		"%IMAGE_MAGICK_PATH%" "%%f" -resize %PERCENT_XXXHDPI% "%~dp0%PATH_XXXHDPI%\%%f"
	)
	pause
)

echo.
echo Finished

pause