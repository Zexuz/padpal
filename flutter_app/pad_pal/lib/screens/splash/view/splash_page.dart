import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("PadelPal", style: AppTheme.logo.copyWith(fontSize: 31)),
          ),
          CircularProgressIndicator(backgroundColor: AppTheme.primary)
        ],
      )),
    );
  }
}
