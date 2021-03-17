import 'package:cnode_flutter2/view_models/theme_view_model.dart';
import 'package:cnode_flutter2/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<UserViewModel>(
    create: (context) => UserViewModel(),
  ),
  ChangeNotifierProvider<ThemeViewModel>(
    create: (context) => ThemeViewModel(),
  ),
];
