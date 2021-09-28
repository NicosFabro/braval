// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:braval/team/team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Packages
import 'package:authentication_repository/authentication_repository.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:team_repository/team_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:braval_ui/braval_ui.dart';

// App
import 'package:braval/app/app.dart';

// SplashScreen
import 'package:braval/splash_screen/splash_screen.dart';

// Login
import 'package:braval/login/login.dart';

// BloC
import 'package:braval/calendar/events_bloc/events_bloc.dart';
import 'package:braval/profile/bloc/profile_bloc.dart';

// l10n
import 'package:braval/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required ProfileRepository profileRepository,
    required TeamRepository teamRepository,
    required CalendarRepository calendarRepository,
  })  : _authenticationRepository = authenticationRepository,
        _profileRepository = profileRepository,
        _teamRepository = teamRepository,
        _calendarRepository = calendarRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final ProfileRepository _profileRepository;
  final TeamRepository _teamRepository;
  final CalendarRepository _calendarRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _profileRepository),
        RepositoryProvider.value(value: _teamRepository),
        RepositoryProvider.value(value: _calendarRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(
              profileRepository: _profileRepository,
            ),
          ),
          BlocProvider<TeamBloc>(
            create: (_) => TeamBloc(
              teamRepository: _teamRepository,
            ),
          ),
          BlocProvider<EventsBloc>(
            create: (_) => EventsBloc(
              calendarRepository: _calendarRepository,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: BravalTheme.standard,
      darkTheme: BravalTheme.standard,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es')],
      home: context.read<AppBloc>().state.status == AppStatus.authenticated
          ? const SplashScreen()
          : const LoginPage(),
    );
  }
}
