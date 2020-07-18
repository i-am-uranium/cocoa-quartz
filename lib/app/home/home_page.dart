import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  static const String route = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.mainBG,
      ),
    );
  }
}
