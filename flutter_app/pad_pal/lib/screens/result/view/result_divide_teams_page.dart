import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/screens/result/bloc/result_cubit.dart';
import 'package:pad_pal/screens/result/models/player.dart';
import 'package:pad_pal/screens/result/view/result_game_set_page.dart';
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
          child: MyHomePageState(),
        ),
      ),
    );
  }
}

class TeamName extends StatelessWidget {
  const TeamName(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Container(
        width: 40,
        height: 48 * 2 + 25.0,
        decoration: BoxDecoration(
          color: AppTheme.lightGrayBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
            child: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        )),
      ),
    );
  }
}

class MyHomePageState extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<ResultCubit, ResultState>(
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
              child: Row(
                children: [
                  Column(
                    children: [
                      TeamName("A"),
                      const SizedBox(height: 25),
                      TeamName("B"),
                    ],
                  ),
                  Expanded(
                    child: ReorderableList(
                      onReorder: context.bloc<ResultCubit>().reorderCallback,
                      onReorderDone: context.bloc<ResultCubit>().reorderDone,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          if (i == 2) {
                            return Divider(
                              thickness: 1,
                              height: 25,
                              indent: 0,
                              color: AppTheme.grayBorder,
                            );
                          }

                          final index = i > 2 ? i - 1 : i;

                          return Column(
                            children: [
                              DraggableItem(
                                data: state.players[index],
                              ),
                              index % 2 == 0 ? const SizedBox(height: 25) : Container(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Button.primary(
              child: Text("Next"),
              onPressed: () => Navigator.of(context).push(
                ResultGameSetPage.route(context),
              ),
            ),
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

class DraggableItem extends StatelessWidget {
  DraggableItem({
    this.data,
  });

  final Player data;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy || state == ReorderableItemState.dragProxyFinished) {
      decoration = BoxDecoration(color: Color(0xD0FFFFFF), border: null);
    }

    return Container(
      decoration: decoration,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Opacity(
          opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Expanded(child: PlayerListTile(data)),
                ReorderableListener(
                  child: Container(
                    padding: EdgeInsets.only(right: 18.0, left: 18.0),
                    child: Center(
                      child: Icon(Icons.reorder),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
      key: data.key,
      childBuilder: _buildChild,
    );
  }
}
