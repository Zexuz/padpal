import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/bloc/event_filter/event_filter_cubit.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/screens/create_event/create_event.dart';
import 'package:pad_pal/screens/event/cubit/event_cubit.dart';
import 'package:pad_pal/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'event_filter_page.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Events nearby',
          leading: IconButton(
            icon: Icon(Icons.filter_alt, color: Colors.black),
            onPressed: () => Navigator.of(context).push(EventFilterPage.route(context)),
          ),
          actions: [
            FlatButton(
              onPressed: () => {Navigator.of(context).push<void>(CreateEventPage.route())},
              child: Text(
                'Create',
                style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        backgroundColor: const Color(0xFFDDE2E9),
        body: Container(
          padding: const EdgeInsets.all(12.0),
          child: _EventView(),
        ));
  }
}

class _EventView extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  Future _onRefresh(BuildContext context) async {
    final filter = context.bloc<EventFilterCubit>().state;
    await context.bloc<EventCubit>().findGames(filter);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<EventCubit, EventState>(
      buildWhen: (previous, current) => previous.games.length != current.games.length,
      builder: (context, state) {
        if (state.games.length == 0) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("no games found!"),
                Text("Try changing the filter settings!"),
                TextButton(
                  child: Text("Refresh"),
                  onPressed: () {
                    final filter = context.bloc<EventFilterCubit>().state;
                    context.bloc<EventCubit>().findGames(filter);
                  },
                )
              ],
            ),
          );
        }

        return SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(waterDropColor: theme.primaryColor),
          controller: _refreshController,
          onRefresh: () async {
            await _onRefresh(context);
          },
          child: ListView.builder(
            itemBuilder: (c, i) {
              return CustomCard(gameInfo: state.games[i]);
            },
            itemCount: state.games.length,
          ),
        );
      },
    );
  }
}
