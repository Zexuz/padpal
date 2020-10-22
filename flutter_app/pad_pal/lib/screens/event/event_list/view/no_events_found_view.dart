import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/bloc/me/me_cubit.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/components/pulse_painter/pulse_painter.dart';

class NoEventFoundView extends StatefulWidget {
  const NoEventFoundView();

  @override
  NoEventFoundViewState createState() => new NoEventFoundViewState();
}

class NoEventFoundViewState extends State<NoEventFoundView> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
    );
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.repeat(
      period: Duration(seconds: 3),
    );
  }

  Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }

  double displayWidth(BuildContext context) {
    return displaySize(context).width;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CustomPaint(
          painter: PulsePainter(_controller),
          child: SizedBox(
            width: displayWidth(context) * 0.65,
            height: displayWidth(context) * 0.65,
            child: BlocBuilder<MeCubit, MeState>(
              buildWhen: (previous, current) => previous.isLoading != current.isLoading,
              builder: (context, state) {
                if (state.isLoading)
                  return CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  );
                return Center(
                  child: Avatar(
                    elevation: 0,
                    radius: displayWidth(context) * 0.15,
                    borderWidth: displayWidth(context) * 0.015,
                    url: state.me.imageUrl,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
          child: Text("No events found", style: theme.textTheme.headline2),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 48.0),
          child: Text(
            "Looks like there are no events nearby you at the moment. Please check your preferences or post you own event.",
            style: theme.textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(child: Container()),
        SizedBox(
          width: double.infinity,
          child: Button.primary(child: const Text("Create an event"), onPressed: () {}),
        ),
      ],
    );
  }
}
