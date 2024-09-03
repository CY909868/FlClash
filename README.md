<div>

[**简体中文**](README_zh_CN.md)

</div>

## FlClash

<p style="text-align: left;">
    <img alt="stars" src="https://img.shields.io/github/stars/chen08209/FlClash?style=flat-square&logo=github"/>
    <img alt="downloads" src="https://img.shields.io/github/downloads/chen08209/FlClash/total"/>
    <a href="LICENSE">
        <img alt="license" src="https://img.shields.io/github/license/chen08209/FlClash"/>
    </a>
</p>

A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.

on Desktop:
<p style="text-align: center;">
    <img alt="desktop" src="snapshots/desktop.gif">
</p>

on Mobile:
<p style="text-align: center;">
    <img alt="mobile" src="snapshots/mobile.gif">
</p>

## Features

✈️ Multi-platform: Android, Windows, macOS and Linux

💻 Adaptive multiple screen sizes, multiple color themes available

💡 Based on Material You design, [Surfboard](https://github.com/getsurfboard/surfboard)-like UI

☁️ Supports data sync via WebDAV

✨ Support subscription link, dark mode

## Download

<a href="https://chen08209.github.io/FlClash-fdroid-repo/repo?fingerprint=789D6D32668712EF7672F9E58DEEB15FBD6DCEEC5AE7A4371EA72F2AAE8A12FD"><img alt="Get it on F-Droid" src="snapshots/get-it-on-fdroid.svg" width="200px"/></a> <a href="https://github.com/chen08209/FlClash/releases"><img alt="Get it on GitHub" src="snapshots/get-it-on-github.svg" width="200px"/></a>

## Contact

[Telegram](https://t.me/+G-veVtwBOl4wODc1)

## Build

1. Update submodules
   ```bash
   git submodule update --init --recursive
   ```

2. Install `Flutter` and `Golang` environment

3. Build Application

    - Android

        1. Install `Android SDK` and `Android NDK`

        2. Set `ANDROID_NDK` environment variables

        3. Run build script

           ```bash
           dart .\setup.dart android
           ```

    - Windows

        1. You need a Windows client

        2. Install `Gcc` and `Inno Setup`

        3. Run build script

           ```bash
           dart .\setup.dart	
           ```

    - Linux

        1. You need a Linux client

        2. Run build script

           ```bash
           dart .\setup.dart	
           ```

    - macOS

        1. You need a macOS client

        2. Run build script

           ```bash
           dart .\setup.dart	
           ```

## Star History

The easiest way to support developers is to click on the star (⭐) at the top of the page.

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=chen08209/FlClash&Date">
        <img alt="start" width=50% src="https://api.star-history.com/svg?repos=chen08209/FlClash&Date"/>
    </a>
</p>