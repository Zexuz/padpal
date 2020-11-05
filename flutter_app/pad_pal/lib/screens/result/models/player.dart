import 'package:flutter/widgets.dart';

class Player {
  const Player({
    @required this.name,
    @required this.url,
    this.key,
  });

  final String name;
  final String url;
  final Key key;
}
