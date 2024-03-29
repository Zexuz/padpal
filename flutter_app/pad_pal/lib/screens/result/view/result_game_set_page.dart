import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/factories/snack_bar_factory.dart';
import 'package:pad_pal/screens/result/bloc/result_cubit.dart';
import 'package:pad_pal/screens/result/models/player.dart';
import 'package:pad_pal/theme.dart';

class ResultGameSetPage extends StatelessWidget {
  static Route route(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: context.bloc<ResultCubit>(),
        child: ResultGameSetPage(),
      ),
    );
  }

  const ResultGameSetPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Result",
        actions: [
          FlatButton(
            onPressed: () {
              context.bloc<ResultCubit>().resetSets();
              Navigator.of(context).pop<void>();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ResultGameSetView(),
      ),
    );
  }
}

class ResultGameSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultCubit, ResultState>(
      builder: (context, state) {
        final cubit = context.bloc<ResultCubit>();
        final winners = state.winner();
        return WillPopScope(
          onWillPop: () {
            if (state.currentSetIndex != 0) {
              cubit.back();
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleAndSubtitle(title: "Set ${state.currentSetIndex + 1}", subtitle: "Lorem ipsom dolar sit amet"),
              const SizedBox(height: 36),
              _Team(
                name: "Team A",
                players: state.teamA,
                score: state.currentSet[0],
                onAdd: state.canAdd(Team.A) ? () => cubit.add(Team.A) : null,
                onRemove: state.canRemove(Team.A) ? () => cubit.remove(Team.A) : null,
              ),
              Divider(
                thickness: 1,
                height: 24.0 * 2,
                color: AppTheme.grayBorder,
              ),
              _Team(
                name: "Team B",
                players: state.teamB,
                score: state.currentSet[1],
                onAdd: state.canAdd(Team.B) ? () => cubit.add(Team.B) : null,
                onRemove: state.canRemove(Team.B) ? () => cubit.remove(Team.B) : null,
              ),
              Expanded(child: Container()),
              if (winners != null) Text("${winners.map((e) => e.name).join(" & ")} is the winners"),
              if (winners != null)
                Button.primary(
                    child: Text("Submit score"),
                    onPressed: () => Scaffold.of(context)
                        .showSnackBar(SnackBarFactory.buildSnackBar("Hurray!!", SnackBarType.success))),
              if (winners == null)
                Button.primary(child: Text("Next"), onPressed: state.isCurrentSetOver() ? () => cubit.next() : null),
            ],
          ),
        );
      },
    );
  }
}

class _Team extends StatelessWidget {
  const _Team({
    Key key,
    this.players,
    this.name,
    this.onAdd,
    this.onRemove,
    this.score,
  }) : super(key: key);

  final List<Player> players;
  final String name;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int score;

  Widget _buildTeamAvatars(List<Player> players) {
    final radius = 18.0;
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: radius * 1.5),
            child: Avatar(
              url: players[1].url,
              name: players[1].name,
              radius: radius,
              borderWidth: 5,
              color: Colors.white,
              elevation: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Avatar(
              url: players[0].url,
              name: players[0].name,
              radius: radius,
              borderWidth: 5,
              color: Colors.white,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(name, style: theme.textTheme.headline3.copyWith(fontSize: 16)),
            _buildTeamAvatars(players),
          ],
        ),
        Row(
          children: [
            _Button(
              onTap: onRemove,
              icon: Icons.remove,
            ),
            Text("$score", style: theme.textTheme.headline1),
            _Button(
              onTap: onAdd,
              icon: Icons.add,
            )
          ],
        )
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({this.onTap, this.icon});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.3 : 1,
      child: RawMaterialButton(
        onPressed: onTap,
        elevation: 0,
        fillColor: AppTheme.grayBorder,
        child: Icon(
          icon,
          size: 24.0,
          color: AppTheme.customBlack,
        ),
        padding: EdgeInsets.all(14.0),
        shape: CircleBorder(),
      ),
    );
  }
}
