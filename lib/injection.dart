import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:fastic_step_counter/injection.config.dart';

final GetIt getIt = GetIt.instance;

// I used the injectable library because it makes it so much easier to resolve
// the dependencies and removed a lot of boilerplate code.
@injectableInit
void configureInjection(String env) {
  $initGetIt(getIt, environment: env);
}
