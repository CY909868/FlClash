<div>

[**English**](README.md)

</div>

## FlClash

<p style="text-align: left;">
    <img alt="stars" src="https://img.shields.io/github/stars/chen08209/FlClash?style=flat-square&logo=github"/>
    <img alt="downloads" src="https://img.shields.io/github/downloads/chen08209/FlClash/total?style=flat-square"/>
    <a href="LICENSE">
        <img alt="license" src="https://img.shields.io/github/license/chen08209/FlClash?style=flat-square"/>
    </a>
</p>

基于 ClashMeta 的多平台代理客户端，简单易用，开源无广告。

在桌面平台上：
<p style="text-align: center;">
    <img alt="desktop" src="snapshots/desktop.gif">
</p>

在移动平台上：
<p style="text-align: center;">
    <img alt="mobile" src="snapshots/mobile.gif">
</p>

## Features

✈️ 多平台：Android、Windows、macOS 和 Linux

💻 自适应多个屏幕尺寸，多种颜色主题可供选择

💡 基本 Material You 设计，类 [Surfboard](https://github.com/getsurfboard/surfboard) 用户界面

☁️ 支持通过 WebDAV 同步数据

✨ 支持一键导入订阅、深色模式

## Download

<a href="https://chen08209.github.io/FlClash-fdroid-repo/repo?fingerprint=789D6D32668712EF7672F9E58DEEB15FBD6DCEEC5AE7A4371EA72F2AAE8A12FD"><img alt="Get it on F-Droid" src="snapshots/get-it-on-fdroid.svg" width="200px"/></a> <a href="https://github.com/chen08209/FlClash/releases"><img alt="Get it on GitHub" src="snapshots/get-it-on-github.svg" width="200px"/></a>

## Contact

[Telegram](https://t.me/+G-veVtwBOl4wODc1)

## Build

1. 更新 submodules
   ```bash
   git submodule update --init --recursive
   ```

2. 安装 `Flutter` 和 `Golang` 环境

3. 构建应用

    - Android

        1. 安装 `Android SDK` 和 `Android NDK`

        2. 设置 `ANDROID_NDK` 环境变量

        3. 运行构建脚本

           ```bash
           dart .\setup.dart android
           ```

    - Windows

        1. 你需要一个 Windows 客户端

        2. 安装 `Gcc` 和 `Inno Setup`

        3. 运行构建脚本

           ```bash
           dart .\setup.dart	
           ```

    - Linux

        1. 你需要一个 Linux 客户端

        2. 运行构建脚本

           ```bash
           dart .\setup.dart	
           ```

    - macOS

        1. 你需要一个 macOS 客户端

        2. 运行构建脚本

           ```bash
             dart .\setup.dart	
           ```

## Star History

支持开发者的最简单方式是点击页面顶部的星标（⭐）。

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=chen08209/FlClash&Date">
        <img alt="start" width=50% src="https://api.star-history.com/svg?repos=chen08209/FlClash&Date"/>
    </a>
</p>