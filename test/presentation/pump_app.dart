import 'package:arch_practice/presentation/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget child,
  ) {
    return pumpWidget(
      MaterialApp(
        theme: AppThemes.material,
        home: child,
      ),
    );
  }
}
