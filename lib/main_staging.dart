// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:braval/app/app_bloc_observer.dart';
import 'package:braval/app/view/app.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:stats_repository/stats_repository.dart';
import 'package:team_repository/team_repository.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final authenticationRepository = AuthenticationRepository();
  final profileRepository = ProfileRepository();
  final teamRepository = TeamRepository();
  final calendarRepository = CalendarRepository();
  final statsRepository = StatsRepository();

  await authenticationRepository.user.first;

  runZonedGuarded(
    () => runApp(
      App(
        authenticationRepository: authenticationRepository,
        profileRepository: profileRepository,
        teamRepository: teamRepository,
        calendarRepository: calendarRepository,
        statsRepository: statsRepository,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
