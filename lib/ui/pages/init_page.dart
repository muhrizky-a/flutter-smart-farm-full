import 'package:flutter/material.dart';

// import '../../utils/welcome_utils.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, "/main");
    });
    // WelcomeUtils.checkUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
