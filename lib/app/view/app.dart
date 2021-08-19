// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:braval_ui/braval_ui.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Packages
import 'package:authentication_repository/authentication_repository.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:team_repository/team_repository.dart';

// App
import 'package:braval/app/app.dart';

// l10n
import 'package:braval/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required ProfileRepository profileRepository,
    required TeamRepository teamRepository,
  })  : _authenticationRepository = authenticationRepository,
        _profileRepository = profileRepository,
        _teamRepository = teamRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final ProfileRepository _profileRepository;
  final TeamRepository _teamRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _profileRepository),
        RepositoryProvider.value(value: _teamRepository),
      ],
      child: BlocProvider<AppBloc>(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
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
      supportedLocales: AppLocalizations.supportedLocales,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc appBloc) => appBloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
