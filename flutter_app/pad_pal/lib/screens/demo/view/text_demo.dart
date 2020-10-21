import 'package:flutter/material.dart';

class TextDemo extends StatelessWidget {
  const TextDemo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.amber,
      body: ListView(
        children: [
          Text("textTheme.HeadLine1", style: theme.textTheme.headline1),
          Text("textTheme.HeadLine2", style: theme.textTheme.headline2),
          Text("textTheme.HeadLine3", style: theme.textTheme.headline3),
          Text("textTheme.HeadLine4", style: theme.textTheme.headline4),
          Text("textTheme.HeadLine5", style: theme.textTheme.headline5),
          Text("textTheme.HeadLine6", style: theme.textTheme.headline6),
          Text("textTheme.subtitle1", style: theme.textTheme.subtitle1),
          Text("textTheme.subtitle2", style: theme.textTheme.subtitle2),
          Text("textTheme.bodyText1", style: theme.textTheme.bodyText1),
          Text("textTheme.bodyText2", style: theme.textTheme.bodyText2),
          Text("textTheme.button", style: theme.textTheme.button),
          Text("textTheme.caption", style: theme.textTheme.caption),
          Text("textTheme.overline", style: theme.textTheme.overline),
          Text("primaryTextTheme.HeadLine1", style: theme.primaryTextTheme.headline1),
          Text("primaryTextTheme.HeadLine2", style: theme.primaryTextTheme.headline2),
          Text("primaryTextTheme.HeadLine3", style: theme.primaryTextTheme.headline3),
          Text("primaryTextTheme.HeadLine4", style: theme.primaryTextTheme.headline4),
          Text("primaryTextTheme.HeadLine5", style: theme.primaryTextTheme.headline5),
          Text("primaryTextTheme.HeadLine6", style: theme.primaryTextTheme.headline6),
          Text("primaryTextTheme.subtitle1", style: theme.primaryTextTheme.subtitle1),
          Text("primaryTextTheme.subtitle2", style: theme.primaryTextTheme.subtitle2),
          Text("primaryTextTheme.bodyText1", style: theme.primaryTextTheme.bodyText1),
          Text("primaryTextTheme.bodyText2", style: theme.primaryTextTheme.bodyText2),
          Text("primaryTextTheme.button", style: theme.primaryTextTheme.button),
          Text("primaryTextTheme.caption", style: theme.primaryTextTheme.caption),
          Text("primaryTextTheme.overline", style: theme.primaryTextTheme.overline),
          Text("accentTextTheme.HeadLine1", style: theme.accentTextTheme.headline1),
          Text("accentTextTheme.HeadLine2", style: theme.accentTextTheme.headline2),
          Text("accentTextTheme.HeadLine3", style: theme.accentTextTheme.headline3),
          Text("accentTextTheme.HeadLine4", style: theme.accentTextTheme.headline4),
          Text("accentTextTheme.HeadLine5", style: theme.accentTextTheme.headline5),
          Text("accentTextTheme.HeadLine6", style: theme.accentTextTheme.headline6),
          Text("accentTextTheme.subtitle1", style: theme.accentTextTheme.subtitle1),
          Text("accentTextTheme.subtitle2", style: theme.accentTextTheme.subtitle2),
          Text("accentTextTheme.bodyText1", style: theme.accentTextTheme.bodyText1),
          Text("accentTextTheme.bodyText2", style: theme.accentTextTheme.bodyText2),
          Text("accentTextTheme.button", style: theme.accentTextTheme.button),
          Text("accentTextTheme.caption", style: theme.accentTextTheme.caption),
          Text("accentTextTheme.overline", style: theme.accentTextTheme.overline),
        ],
      ),
    );
  }
}
