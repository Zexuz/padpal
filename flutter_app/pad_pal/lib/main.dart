import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pad_pal/app.dart';
import 'package:pad_pal/app_push.dart';
import 'package:pad_pal/service_locator.dart';
import 'package:sentry/sentry.dart' hide App;

import 'simple_bloc_observer.dart';

class ErrorService {
  const ErrorService(SentryClient client) : _client = client;

  final SentryClient _client;

  static bool get isInDebugMode {
    // Assume you're in production mode.
    bool inDebugMode = false;

    // Assert expressions are only evaluated during development. They are ignored
    // in production. Therefore, this code only sets `inDebugMode` to true
    // in a development environment.
    assert(inDebugMode = true);

    return inDebugMode;
  }

  Future<void> reportError(dynamic error, dynamic stackTrace) async {
    // Print the exception to the console.
    print('Caught error: $error');
    if (isInDebugMode) {
      // Print the full stacktrace in debug mode.
      print(stackTrace);
    } else {
      // Send the Exception and Stacktrace to Sentry in Production mode.
      _client.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  final sentry = SentryClient(dsn: "https://8c9e0f14b1a5421f9447d116976a21d6@o470748.ingest.sentry.io/5501793");
  final errorService = ErrorService(sentry);

  WidgetsFlutterBinding.ensureInitialized();

  var env = "dev";

  Bloc.observer = SimpleBlocObserver();
  await GlobalConfiguration().loadFromAsset("app_settings_$env");

  setupServiceLocator();

  FlutterError.onError = (details, {bool forceReport = false}) {
    errorService.reportError(details.exception, details.stack);
  };


  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runZonedGuarded<Future<void>>(() async {
    runApp(AppPush(child: App()));
  }, (Object error, StackTrace stackTrace) {
    errorService.reportError(error, stackTrace);
  });
}
