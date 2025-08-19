import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../helpers/constants.dart';
import '../../models/mdi/user_model.dart';
import '../../modelviews/login_view_model.dart';
import '../../providers/user_provider.dart';
import '../../services/authentication_service.dart';
import '../main/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      );
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticationService _api = AuthenticationService();
  bool isLoadingEmail = false;
  bool isLoadingGoole = false;
  bool isShowError = false;
  String strShowError = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onViewModelReady: (model) => {
        // model.getDataAll()
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: EnvisionColor.primaryColor,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topLeft,
              image: AssetImage("/images/mdi_logo.png"),
              fit: BoxFit.scaleDown,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8),
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 6),
                  child: SizedBox(
                    width: 320,
                    child: _formLogin(context, model),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _formLogin(BuildContext context, LoginViewModel model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Envision MDI',
                style: TextStyle(
                  fontSize: EnvisionSize.largeFontSize,
                  fontWeight: FontWeight.bold,
                  color: EnvisionColor.colorGreen,
                ),
              ),
              Text(
                'v 2.304',
                style: TextStyle(
                  fontSize: EnvisionSize.smallFontSize,
                  fontWeight: FontWeight.bold,
                  color: EnvisionColor.colorGreen.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: EnvisionSize.textPadding),
          const SizedBox(height: EnvisionSize.textPadding),
          TextField(
            onSubmitted: ((value) =>
                login(_emailController, _passwordController)),
            autofocus: true,
            controller: _emailController,
            // obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              hintText: 'Username',
              // suffixIcon: const Icon(
              //   Icons.visibility_off_outlined,
              //   color: Colors.grey,
              // ),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: EnvisionSize.smallFontSize),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: EnvisionSize.textPadding),
          TextField(
            onSubmitted: ((value) =>
                login(_emailController, _passwordController)),
            autofocus: true,
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key),
              hintText: 'Password',
              // suffixIcon: const Icon(
              //   Icons.visibility_off_outlined,
              //   color: Colors.grey,
              // ),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: EnvisionSize.smallFontSize),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          if (isShowError)
            Text(
              strShowError,
              style: TextStyle(
                  color: Colors.red[200], fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: EnvisionSize.textPadding),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              onPressed: () {
                login(_emailController, _passwordController);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: EnvisionColor.colorGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: SizedBox(
                  // width: double.infinity,
                  height: 50,
                  child: Center(
                      child: isLoadingEmail
                          ? const CircularProgressIndicator(
                              color: Color(0xFFc5d893),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: EnvisionSize.defaultFontSize,
                                color: Colors.white,
                              ),
                            ))),
            ),
          ),
        ],
      ),
    );
  }

  Future login(
    TextEditingController userController,
    TextEditingController passwordController,
  ) async {
    print('Login');
    UserProvider userprovider =
        Provider.of<UserProvider>(context, listen: false);
    setState(() {
      isLoadingEmail = true;
      isShowError = false;
    });
    if (userController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      isLoadingEmail = false;
      isShowError = true;
      strShowError = 'Please fill user and password.';
      return;
    }
    print('Login 2');
    // userController.text = '021122';
    // passwordController.text = '788489';
    await _api
        .login(userController.text.trim(), passwordController.text.trim())
        .then((value) async {
      User res;
      if (value == null) {
        setState(() {
          isLoadingEmail = false;
          isShowError = true;
          strShowError = 'No User Data.';
        });
      } else {
        res = value;
        // await _api.getOrganizationSelectView().then((value) {
        //   userprovider.setOrganization(value);
        // });
        userprovider.removeUser();
        userprovider.setUser(res);
        // UserPreferences().saveStmo(stmoValueSelected);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
        // locator<NavigationService>().navigateTo(homeRoute);
      }
    });
  }
}
