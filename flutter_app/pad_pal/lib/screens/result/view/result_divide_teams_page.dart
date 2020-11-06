import 'package:drag_and_drop_lists_fork_robin/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/screens/result/bloc/result_cubit.dart';
import 'package:pad_pal/screens/result/models/player.dart';
import 'package:pad_pal/theme.dart';

class ResultDivideTeamsPage extends StatelessWidget {
  static Route route(GameInfo gameInfo) {
    return MaterialPageRoute<void>(builder: (_) => ResultDivideTeamsPage(gameInfo: gameInfo));
  }

  const ResultDivideTeamsPage({
    Key key,
    @required this.gameInfo,
  }) : super(key: key);

  final GameInfo gameInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Result",
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocProvider<ResultCubit>(
          create: (_) => ResultCubit(gameInfo: gameInfo),
          child: ResultDivideTeamsView(),
        ),
      ),
    );
  }
}

class ResultDivideTeamsView extends StatelessWidget {
  ResultDivideTeamsView({Key key}) : super(key: key);

  DragAndDropList _buildList(String teamName, List<Player> players, bool isValid) {
    return DragAndDropList(
      leftSide: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Container(
          width: 40,
          decoration: BoxDecoration(
            color: AppTheme.lightGrayBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
              child: Text(
            teamName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          )),
        ),
      ),
      canDrag: false,
      children: <DragAndDropItem>[
        for (var item in players)
          DragAndDropItem(
            child: PlayerListTile(item),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultCubit, ResultState>(
      buildWhen: (previous, current) => previous.teamA != current.teamA || previous.teamB != current.teamB,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleAndSubtitle(
              title: "Divide into teams",
              subtitle: "Lorem ipsum dolor sit amet",
            ),
            const SizedBox(height: 36),
            Expanded(
              child: DragAndDropLists(
                listDivider: Divider(
                  thickness: 1,
                  height: 25,
                  indent: 100,
                  color: AppTheme.grayBorder,
                ),
                itemDivider: SizedBox(height: 25),
                listDividerOnLastChild: false,
                children: [
                  _buildList("A", state.teamA, state.isTeamSetupValid),
                  _buildList("B", state.teamB, state.isTeamSetupValid),
                ],
                onItemReorder: context.bloc<ResultCubit>().onItemReorder,
                lastItemTargetHeight: 0,
                dragHandle: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.menu,
                  ),
                ),
              ),
            ),
            Button.primary(child: Text("Next"), onPressed: state.isTeamSetupValid ? () => {} : null)
          ],
        );
      },
    );
  }
}

class PlayerListTile extends StatelessWidget {
  const PlayerListTile(
    this.player, {
    Key key,
  }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = 24.0;

    final avatar = player == null
        ? DottedAvatar(
            radius: radius,
          )
        : Avatar(
            url: player.url,
            name: player.name,
            elevation: 0,
            borderWidth: 0,
            radius: radius,
          );

    final text = player?.name ?? "Empty spot";

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: avatar,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: theme.textTheme.headline4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
