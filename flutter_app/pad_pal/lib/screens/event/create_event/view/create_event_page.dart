import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/factories/snack_bar_factory.dart';
import 'package:social_repository/social_repository.dart';

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

class InviteFriend extends StatelessWidget {
  InviteFriend({@required this.onTap});

  static const orPadding = 16.0;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: orPadding, right: orPadding),
          child: const Text("or"),
        ),
        Button.primary(
          child: const Text('Invite friend'),
          large: false,
          onPressed: onTap,
        )
      ],
    );
  }
}

class _CreateEventWizardState extends State<CreateEventPage> {
  _onInviteFriend(BuildContext context) async {
    final selectedProfile = await showDialog<Profile>(
      context: context,
      builder: (context) {
        return Dialog(
          child: BlocProvider(
            create: (context) => ProfileSearchCubit(
              socialRepository: RepositoryProvider.of<SocialRepository>(context),
              onlySearchForFriends: true,
            ),
            child: Builder(
              builder: (context) => ListView(
                children: [
                  TextFormField(
                    onChanged: (value) async {
                      await context.bloc<ProfileSearchCubit>().onSearchTermChange(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search for friends",
                    ),
                  ),
                  BlocBuilder<ProfileSearchCubit, ProfileSearchState>(
                    builder: (context, state) {
                      if (state.isLoading) return CircularProgressIndicator(backgroundColor: Colors.red);

                      return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.profiles.length,
                        itemBuilder: (context, index) {
                          const radius = 24.0;
                          final profile = state.profiles[index];

                          return ListTile(
                            leading: Avatar(
                              borderWidth: 0,
                              url: profile.imageUrl,
                              name: profile.name,
                              radius: radius,
                            ),
                            trailing: Icon(Icons.add),
                            title: Text(profile.name),
                            subtitle: Text("Beginner"),
                            onTap: () => Navigator.of(context).pop(profile),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (selectedProfile == null) {
      return;
    }

    context.bloc<CreateEventCubit>().addPlayerToInvite(selectedProfile);
  }

  @override
  Widget build(BuildContext context) {
    const radius = 24.0;

    const offset = (radius * 2);

    return BlocBuilder<CreateEventCubit, CreateEventState>(
      builder: (context, state) {
        final eventCubit = context.bloc<CreateEventCubit>();
        final currentStep = state.currentStep;

        final steps = [
          BlocBuilder<MeCubit, MeState>(
            builder: (_, meState) {
              final column = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              );

              column.children.add(CreatorSpot(
                user: SpotData.fromProfile(meState.me),
                radius: radius,
                offset: offset,
                onTap: () => {print("tapepd")},
              ));

              for (var i = 0; i < state.invitedPlayers.length; i++) {
                final profile = state.invitedPlayers[i];
                column.children.add(InvitedSpot(
                  user: SpotData.fromProfile(profile),
                  radius: radius,
                  offset: offset,
                  onTap: () => context.bloc<CreateEventCubit>().removePlayerToInvite(profile),
                ));
              }
              for (var i = column.children.length; i < 4; i++) {
                column.children.add(FreeSpot(
                  radius: radius,
                  offset: offset,
                  actionText: "Invite",
                  onTap: () => _onInviteFriend(context),
                  playerNumber: i + 1,
                ));
              }

              return column;
            },
          ),
          CreateEventTimeAndLocation(),
          CreateEventOtherInformation(),
        ];

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
                              TitleAndSubtitle(title: "Players", subtitle: "Lorem ipsom dolar sit amet"),
                              const SizedBox(height: 38),
                              steps[currentStep],
                              Expanded(child: Container()),
                              const SizedBox(height: 24),
                              _Progress(currentPage: currentStep),
                              const SizedBox(height: 12),
                              Button.primary(
                                child: Text('Next'),
                                onPressed: state.isNextEnabled ? () => eventCubit.next() : null,
                              )
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
