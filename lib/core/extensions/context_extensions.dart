import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;

  ThemeData get theme => Theme.of(this);
  String? get activeRouteName => ModalRoute.of(this)!.settings.name;
}

extension EmptyWidget on BuildContext {
  Widget emptyWidgetHeight(double val) => SizedBox(
        height: MediaQuery.of(this).size.height * val,
      );

  Widget emptyWidgetWidth(double val) => SizedBox(
        width: MediaQuery.of(this).size.width * val,
      );
}
