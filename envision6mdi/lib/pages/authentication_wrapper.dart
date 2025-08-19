import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'login/login_page.dart';
import 'main/main_page.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    try {
      if (user.user.userId != null) {
        return const MainPage();
      }
    } catch (e) {
      return const LoginPage();
    }
    return const LoginPage();
  }
}
