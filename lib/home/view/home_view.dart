import 'package:braval/team/team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Packages
import 'package:braval_ui/braval_ui.dart';

// Bloc
import 'package:braval/profile/bloc/profile_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Text('${state.profile.name} ${state.profile.surname}');
              },
            ),
            BlocBuilder<TeamBloc, TeamState>(
              builder: (context, state) {
                final sport =
                    state.team.sport == 'football' ? 'Fútbol' : 'Basket';
                final category = state.team.category.toLowerCase();
                return Text(
                  '$sport $category',
                  style: BravalTextStyle.overline,
                );
              },
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
    );
  }
}
