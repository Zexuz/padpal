import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pad_pal/app.dart';
import 'package:pad_pal/app_push.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  var env = "dev";
  await GlobalConfiguration().loadFromAsset("app_settings_$env");
  runApp(AppPush(child: App(),));
}
