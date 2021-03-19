# cnode_flutter2

flutter2.0开发cnode社区

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 多语言
> flutter pub run intl_utils:generate

## 自定义预览端口和host
> flutter run -d chrome --web-port 55555 --web-hostname 0.0.0.0
>

## 桌面端适配
> flutter config --enable-macos-desktop
>

## web端
> 开开启chrome浏览器然后再运行 flutter run -d chrome
>
> 打包 flutter build web --web-renderer html 

## 部署web网页
> 使用vercel服务做静态服务器