import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise/ui/authentication.dart';
import 'package:practise/ui/home_view.dart';

class DesicionTree extends StatefulWidget {
  const DesicionTree({Key? key}) : super(key: key);

  @override
  _DesicionTreeState createState() => _DesicionTreeState();
}

class _DesicionTreeState extends State<DesicionTree> {
  User? user;

  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return const Authentication();
    }
    return const HomeView();
  }
}
