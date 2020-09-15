import 'package:flutter/widgets.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pad_pal/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var env = "dev";
  await GlobalConfiguration().loadFromAsset("app_settings_$env");
  runApp(AppPush(child: App(),));
}
