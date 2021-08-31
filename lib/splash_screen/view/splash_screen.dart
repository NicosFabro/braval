import 'dart:developer';

import 'package:braval/app/app.dart';
import 'package:braval/home/home.dart';
import 'package:braval/profile/bloc/profile_bloc.dart';
import 'package:braval/team/team.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AppBloc>().state.user.id;
    context.read<ProfileBloc>().add(ProfileFetchRequested(userId));
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.status == ProfileStatus.success) {
              context
                  .read<TeamBloc>()
                  .add(TeamFetchRequested(state.profile.currentTeam));
              Navigator.of(context).pushReplacement(HomePage.route());
            } else if (state.status == ProfileStatus.failure) {
              log('failure');
            }
          },
          child: const SplashScreenView(),
        ),
      ),
    );
  }
}

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Braval Logo
          const BravalCircularProgressIndicator(),
          Text('Cargando datos', style: BravalTextStyle.caption),
        ],
      ),
    );
  }
}
