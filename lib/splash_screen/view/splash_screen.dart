import 'dart:developer';

import 'package:braval/home/home.dart';
import 'package:braval/splash_screen/bloc/splash_screen_bloc.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<SplashScreenBloc>(
          create: (context) => SplashScreenBloc()..add(SplashScreenRequested()),
          child: BlocListener<SplashScreenBloc, SplashScreenState>(
            listener: (context, state) {
              if (state.status == SplashScreenStatus.loaded) {
                Navigator.of(context).pushReplacement(HomePage.route());
              } else {
                log('asdasdasd');
              }
            },
            child: const SplashScreenView(),
          ),
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
          BravalSpaces.elementsSeparator,
          Text('Cargando datos', style: BravalTextStyle.caption),
        ],
      ),
    );
  }
}
