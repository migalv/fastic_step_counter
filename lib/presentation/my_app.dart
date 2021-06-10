import 'package:fastic_step_counter/presentation/step_counter/step_counter_page.dart';
import 'package:fastic_step_counter/presentation/step_counter/themes/fastic_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fastic Step Counter',
      theme: fasticTheme,
      home: const StepCounterPage(),
    );
  }
}
