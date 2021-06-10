import 'package:fastic_step_counter/injection.dart';
import 'package:fastic_step_counter/presentation/my_app.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.dev);

  runApp(MyApp());
}
