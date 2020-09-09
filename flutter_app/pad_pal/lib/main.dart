import 'package:flutter/widgets.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pad_pal/app.dart';

Future<void> main() async {
  var env = "dev";
  await GlobalConfiguration().loadFromAsset("app_settings_$env.json");
  runApp(App());
}
