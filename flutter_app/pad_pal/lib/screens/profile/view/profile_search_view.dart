import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/components/avatar/avatar.dart';
import 'package:pad_pal/components/components.dart';
import 'package:social_repository/social_repository.dart';

class ProfileSearchView extends StatelessWidget {

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FocusRemover(
      focusNode: _focusNode,
      child: BlocProvider(
        create: (context) => ProfileSearchCubit(
          socialRepository: RepositoryProvider.of<SocialRepository>(context),
          onlySearchForFriends: true,
        ),
        child: Builder(builder: (context) {
          final nav = Navigator.of(context);

          return Scaffold(
            appBar: AppBar(
              title: new TextField(
                focusNode: _focusNode,
                onChanged: context.bloc<ProfileSearchCubit>().onSearchTermChange,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(hintText: "Search...", hintStyle: new TextStyle(color: Colors.white)),
              ),
            ),
            backgroundColor: Colors.white,
            body: BlocBuilder<ProfileSearchCubit, ProfileSearchState>(
              buildWhen: (prev, cur) => prev.isLoading != cur.isLoading,
              builder: (context, state) {
                const radius = 18.0;

                return Column(
                  children: [
                    if (state.isLoading)
                      Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.amber,
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.profiles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Avatar(
                              borderWidth: 0,
                              url: state.profiles[index].imageUrl,
                              name: state.profiles[index].name,
                              radius: radius,
                              elevation: 0,
                            ),
                            title: Text(state.profiles[index].name, style: theme.textTheme.headline3),
                            onTap: () {
                              nav.pop<int>(state.profiles[index].userId);
                            },
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
