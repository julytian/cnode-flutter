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
> 1. 开开启chrome浏览器然后再运行 
>
> 2. flutter run -d chrome --web-renderer html // to run the app
>
> 打包 flutter build web --web-renderer html --release // to generate a production build

在 Chrome 浏览器上使用默认 (auto) 渲染器运行：

> flutter run -d chrome
使用默认 (auto) 渲染器构建应用（发布模式）：

> flutter build web --release
使用 CanvasKit 渲染器构建应用（发布模式）：

> flutter build web --web-renderer canvaskit --release
使用 HTML 渲染器构建应用（发布模式）：

> flutter run -d chrome --web-renderer html --profile
## 部署web网页
> 使用vercel服务做静态服务器