import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/components.dart';
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
        return Column(
          children: [
            TitleAndSubtitle(title: "Set 1", subtitle: "Lorem ipsom dolar sit amet"),
            _Team(name: "Team A", players: state.teamA),
            Divider(
              thickness: 1,
              height: 24.0 * 2,
              color: AppTheme.grayBorder,
            ),
            _Team(name: "Team B", players: state.teamB),
          ],
        );
      },
    );
  }
}

class _Team extends StatelessWidget {
  const _Team({Key key, this.players, this.name}) : super(key: key);

  final List<Player> players;
  final String name;

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
              onTap: () => print("Sub"),
              icon: Icons.remove,
            ),
            Text("4", style: theme.textTheme.headline1),
            _Button(
              onTap: () => print("Add"),
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
    return RawMaterialButton(
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
    );
  }
}
