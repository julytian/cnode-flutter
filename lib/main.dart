import 'package:cnode_flutter2/config/router_manager.dart';
import 'package:cnode_flutter2/config/storage_manager.dart';
import 'package:cnode_flutter2/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async{
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: RefreshConfiguration(
        hideFooterWhenNotFull: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
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
      ),
    );
  }
}
