import 'package:fastic_step_counter/presentation/step_counter/step_counter_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fastic Step Counter',
      home: StepCounterPage(),
    );
  }
}
