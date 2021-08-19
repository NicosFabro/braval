import 'package:flutter/widgets.dart';
import 'package:braval/app/app.dart';
import 'package:braval/home/home.dart';
import 'package:braval/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
