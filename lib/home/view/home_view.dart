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
    final name = context.read<ProfileBloc>().state.profile.name;
    final surname = context.read<ProfileBloc>().state.profile.surname;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$name $surname'),
            Text('Fútbol infantil', style: BravalTextStyle.overline),
          ],
        ),
        actions: const [
          Icon(Icons.notifications),
        ],
      ),
    );
  }
}
