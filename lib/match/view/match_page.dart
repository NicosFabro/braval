import 'package:flutter/material.dart';
import 'package:calendar_repository/calendar_repository.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key, required this.match}) : super(key: key);

  final Match match;

  static Route<MatchPage> route({required Match match}) =>
      MaterialPageRoute<MatchPage>(builder: (_) => MatchPage(match: match));

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(),
        ),
      ),
    );
  }
}
