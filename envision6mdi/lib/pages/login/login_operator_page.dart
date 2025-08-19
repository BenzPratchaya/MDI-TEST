import 'package:envision6mdi/controllers/mdi_insert_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../helpers/constants.dart';
import '../../modelviews/login_view_model.dart';
import '../mdi/mdi_insert_page/mdi_insert_page.dart';

class LoginOperatorPage extends StatefulWidget {
  final String? modalityUid;
  const LoginOperatorPage({super.key, this.modalityUid});

  @override
  State<LoginOperatorPage> createState() => _LoginOperatorPageState();
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (BuildContext context) => const LoginOperatorPage(),
      );
}

class _LoginOperatorPageState extends State<LoginOperatorPage> {
  bool isLoadingEmail = false;
  String strShowError = '';

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.modalityUid != null) {
        await context
            .read<MdiInsertController>()
            .getOrganizationAndModalityByModalityUid(widget.modalityUid!);
      }
    });
  }

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
            onSubmitted: ((value) => login(_emailController)),
            autofocus: true,
            controller: _emailController,
            // obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              hintText: 'Operatoe ID',
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
          // const SizedBox(height: EnvisionSize.textPadding),
          // TextField(
          //   onSubmitted: ((value) =>
          //       login(_emailController, _passwordController)),
          //   autofocus: true,
          //   controller: _passwordController,
          //   obscureText: true,
          //   decoration: InputDecoration(
          //     prefixIcon: const Icon(Icons.key),
          //     hintText: 'Password',
          //     // suffixIcon: const Icon(
          //     //   Icons.visibility_off_outlined,
          //     //   color: Colors.grey,
          //     // ),
          //     filled: true,
          //     fillColor: Colors.blueGrey[50],
          //     labelStyle: const TextStyle(fontSize: EnvisionSize.smallFontSize),
          //     contentPadding: const EdgeInsets.only(left: 30),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.blueGrey[50]!),
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.blueGrey[50]!),
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //   ),
          // ),

          Text(
            context.watch<MdiInsertController>().loginMessage ?? strShowError,
            style:
                TextStyle(color: Colors.red[200], fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: EnvisionSize.textPadding),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              onPressed: () {
                login(_emailController);
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

  login(TextEditingController userController) {
    MdiInsertController prod =
        Provider.of<MdiInsertController>(context, listen: false);
    if (prod.loginMessage != null) {
      return;
    }
    if (userController.text.trim().isEmpty) {
      isLoadingEmail = false;
      strShowError = 'Please fill user.';
      return;
    }
    prod.setUser(userController.text.trim());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MdiInsertPage()),
    );
  }
}
