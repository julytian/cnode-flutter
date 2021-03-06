import 'dart:io';

import 'package:cnode_flutter2/config/provider_manager.dart';
import 'package:cnode_flutter2/config/router_manager.dart';
import 'package:cnode_flutter2/config/storage_manager.dart';
import 'package:cnode_flutter2/generated/l10n.dart';
import 'package:cnode_flutter2/view_models/theme_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 使用HttpOverrides.global来创建一个可用于在实例化时创建HTTP客户端的拦截器
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  // 桌面端
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    HttpOverrides.global = new MyHttpOverrides();
  }
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  //滚动性能优化 1.22.0
  GestureBinding.instance.resamplingEnabled = true;
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child: Consumer<ThemeViewModel>(
          builder: (context, themeModel, child) {
            return RefreshConfiguration(
              hideFooterWhenNotFull: true,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeModel.themeData(),
                darkTheme: themeModel.themeData(platformDarkMode: true),
                localizationsDelegates: [
                  S.delegate,
                  RefreshLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                onGenerateRoute: MyRouter.generateRoute,
                initialRoute: RouteName.home,
              ),
            );
          },
        ),
      ),
    );
  }
}
