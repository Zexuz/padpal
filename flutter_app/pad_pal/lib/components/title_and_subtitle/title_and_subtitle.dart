import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class TitleAndSubtitle extends StatelessWidget {
  const TitleAndSubtitle({
    Key key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: theme.textTheme.headline1),
        const SizedBox(height: 12),
        Text(subtitle, style: theme.textTheme.bodyText2.copyWith(color: AppTheme.lightGrayText)),
      ],
    );
  }
}
