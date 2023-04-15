@echo off

setlocal enabledelayedexpansion



@REM Check if arguments were passed
if "%~1"=="" goto :error
if "%~2"=="" goto :error


@REM ${config:mesonbuild.buildFolder} or eg: "bin"
set BUILD_DIR=%1

@REM ${command:cpptools.activeConfigName} or "debug", "release" etc
set BUILD_TYPE=%2

set /p LAST_BUILD_TYPE=<.vscode\scripts\lastbuildtype.txt


cls

if not exist "%BUILD_DIR%/meson-info/meson-info.json" (
    meson setup "%BUILD_DIR%" --buildtype "%BUILD_TYPE%"
)

if not %LAST_BUILD_TYPE%==%BUILD_TYPE% (
    echo Build type changed, reconfiguring...
    meson setup --reconfigure "%BUILD_DIR%" --buildtype "%BUILD_TYPE%"
)

@REM Build type is saved in a file since windows doesnt have regex or other simlar things built in
echo %BUILD_TYPE% > .vscode\scripts\lastbuildtype.txt

meson compile -C "%BUILD_DIR%"


goto :exit

:error
echo Something went wrong
goto :exit

:exit