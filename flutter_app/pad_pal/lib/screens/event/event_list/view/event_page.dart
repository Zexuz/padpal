import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/bloc/event_filter/event_filter_cubit.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/screens/event/create_event/create_event.dart';
import 'package:pad_pal/screens/event/event_list/cubit/event_cubit.dart';
import 'package:pad_pal/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'event_filter_page.dart';
import 'no_events_found_view.dart';

class EventPage extends StatelessWidget {
  const EventPage();

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
      create: (_) => EventFilterCubit(),
      child: Builder(
        builder: (context) => Scaffold(
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
          ),
        ),
      ),
    );
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
      builder: (context, state) {
        return SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(waterDropColor: theme.primaryColor),
          controller: _refreshController,
          onRefresh: () async {
            await _onRefresh(context);
          },
          child: state.games.length == 0
              ? ListView(
                  children: [
                    NoEventFoundView(),
                  ],
                )
              : ListView.builder(
                  itemBuilder: (c, i) {
                    return GameOverviewCard(gameInfo: state.games[i]);
                  },
                  itemCount: state.games.length,
                ),
        );
      },
    );
  }
}
