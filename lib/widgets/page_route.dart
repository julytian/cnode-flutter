import 'package:flutter/material.dart';

class NoAnimateRouteBuilder extends PageRouteBuilder {
  final Widget page;
  NoAnimateRouteBuilder(this.page)
      : super(
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration(milliseconds: 0),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
        );
}
