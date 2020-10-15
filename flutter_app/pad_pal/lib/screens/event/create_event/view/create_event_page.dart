import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/factories/snack_bar_factory.dart';
import 'package:pad_pal/screens/event/components/components.dart';

import 'create_event_add_players_step.dart';
import 'create_event_other_information_step.dart';
import 'create_event_time_and_location_step.dart';

import '../bloc/create_event_bloc.dart';

class CreateEventPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider<CreateEventCubit>(
        create: (context) => CreateEventCubit(
          gameRepository: context.repository<GameRepository>(),
        ),
        child: CreateEventPage(),
      ),
    );
  }

  @override
  _CreateEventWizardState createState() => _CreateEventWizardState();
}

class _CreateEventWizardState extends State<CreateEventPage> {
  @override
  Widget build(BuildContext context) {
    final meCubit = context.bloc<MeCubit>();
    final steps = [
      CreateEventAddPlayers(players: [Player(profile: meCubit.state.me, state: PlayerState.Creator)],),
      CreateEventTimeAndLocation(),
      CreateEventOtherInformation(),
    ];

    final theme = Theme.of(context);

    return BlocBuilder<CreateEventCubit, CreateEventState>(
      builder: (context, state) {
        final eventCubit = context.bloc<CreateEventCubit>();
        final currentStep = state.currentStep;

        return WillPopScope(
          onWillPop: () {
            return eventCubit.back();
          },
          child: Scaffold(
            resizeToAvoidBottomPadding: true,
            appBar: CustomAppBar(
              title: "Create event",
              leading: currentStep > 0
                  ? IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => eventCubit.back(),
                    )
                  : Container(),
              actions: [
                FlatButton(
                  onPressed: () => {Navigator.of(context).pop<void>()},
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            body: BlocListener<CreateEventCubit, CreateEventState>(
              listenWhen: (previous, current) => previous.status != current.status,
              listener: (context, state) {
                // TODO, Use state.status to indicate if the match was created or not!
                if (state.status == FormzStatus.submissionFailure) {
                  Scaffold.of(context).showSnackBar(
                    SnackBarFactory.buildSnackBar("Failed to create event!", SnackBarType.error),
                  );
                } else if (state.status == FormzStatus.submissionSuccess) {
                  Scaffold.of(context).showSnackBar(
                    SnackBarFactory.buildSnackBar("Event was created!", SnackBarType.success),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints viewportConstraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              EventStepTitle(title: "Players", subtitle: "Lorem ipsom dolar sit amet"),
                              const SizedBox(height: 38),
                              steps[currentStep],
                              Expanded(child: Container()),
                              const SizedBox(height: 24),
                              _Progress(currentPage: currentStep),
                              const SizedBox(height: 12),
                              ButtonLargePrimary(
                                text: "Next",
                                onPressed: state.isNextEnabled ? () => eventCubit.next() : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({
    Key key,
    @required this.currentPage,
  }) : super(key: key);

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final doneColor = Theme.of(context).primaryColor;
    final todoColor = Theme.of(context).primaryColor.withOpacity(0.12);

    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 8,
              color: doneColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 8,
              color: currentPage >= 1 ? doneColor : todoColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 8,
              color: currentPage >= 2 ? doneColor : todoColor,
            ),
          ),
        ),
      ],
    );
  }
}
