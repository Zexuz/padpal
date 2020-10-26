import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/components/avatar/avatar.dart';
import 'package:social_repository/social_repository.dart';

import 'profile_page.dart';

class ProfileSearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileSearchCubit(
        socialRepository: RepositoryProvider.of<SocialRepository>(context),
      ),
      child: Builder(builder: (context) {
        final nav = Navigator.of(context);

        return Scaffold(
          appBar: AppBar(
            title: new TextField(
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
              const radius = 24.0;

              return Column(
                children: [
                  if (state.isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amber,
                      ),
                    ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.profiles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Avatar(
                            borderWidth: 0,
                            url: state.profiles[index].imageUrl,
                            name: state.profiles[index].name,
                            radius: radius,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text(state.profiles[index].name),
                          subtitle: Text('My new post'),
                          onTap: () {
                            nav.push(ProfilePage.route(context, state.profiles[index]));
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                  )
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
