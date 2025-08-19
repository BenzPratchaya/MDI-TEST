import 'package:envision6mdi/controllers/mdi_insert_controller.dart';
import 'package:envision6mdi/widgets/three_in_out.dart';
import 'package:envision6mdi/routing/router.dart';
import 'package:envision6mdi/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import 'controllers/menu_controller.dart';
import 'helpers/constants.dart';
import 'helpers/customScrollBehavior.dart';
import 'locator.dart';
import 'models/user_login_model.dart';
import 'modelviews/mdi_view_model.dart';
import 'pages/login/login_page.dart';
import 'providers/user_provider.dart';
import 'services/user_preferences.dart';

import 'package:google_fonts/google_fonts.dart';

void main() async {
  final String pathName = html.window.location.pathname!;
  // final String pathName = web.window.location.pathname;
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  setupLocator();
  runApp(MyApp(pathName: pathName));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  final String pathName;
  const MyApp({
    super.key,
    required this.pathName,
  });

  // get pathName => '/signin';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<UserLogin> getUserData(String path) => UserPreferences().getUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuDrawerController(),
        ),
        ChangeNotifierProvider(create: (context) => MdiInsertController()),
        ChangeNotifierProvider(create: (context) => MdiViewModel()),
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        onUnknownRoute: (_) => LoginPage.route(),
        onGenerateRoute: generateRoute,
        initialRoute: pathName,
        title: 'Envision MDI ',
        scrollBehavior: CustomScrollBehavior(),
        theme: ThemeData(
          disabledColor: const Color.fromARGB(255, 205, 204, 204),
          primarySwatch: Colors.blueGrey,
          splashColor: EnvisionColor.primaryColor,
          scaffoldBackgroundColor: EnvisionColor.primaryColor,
          dividerColor: const Color.fromARGB(255, 208, 208, 208),
          canvasColor: EnvisionColor.colorGrey,
          // fontFamily: 'sarabun',
          fontFamily: GoogleFonts.sarabun().fontFamily,
          brightness: Brightness.light,
          // scaffoldBackgroundColor: const Color(0xFFF6F6F6),
          // canvasColor: const Color(0xFFF6F6F6),
          cardColor: const Color(0xFFEFEFEF),
          colorScheme: const ColorScheme.light().copyWith(
            primary: const Color(0xFF22B88A),
            secondary: const Color.fromARGB(255, 196, 193, 193),
            tertiary: const Color(0xFFFFFFFF),
            error: const Color(0xFFCD555E),
            tertiaryContainer: const Color(0xFFD9D9D9),
            surfaceTint: Colors.transparent,
          ),

          // Controls
          switchTheme: const SwitchThemeData(
            // thumbColor: MaterialStateColor.resolveWith(
            // (states) => const Color(0xFF22B88A)),
            // trackColor: MaterialStateColor.resolveWith(
            //     (states) => const Color(0xFF20705E)),
            // trackOutlineColor: WidgetStateColor.resolveWith(
            //   (states) => const Color(0xFF22B88A),
            // ),
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
          checkboxTheme: const CheckboxThemeData(
              // fillColor: MaterialStateColor.resolveWith(
              //     (states) => const Color(0xFF22B88A)),
              // checkColor: WidgetStateColor.resolveWith(
              //     (states) => const Color(0xFF22B88A)),
              ),
          // dividerColor: const Color(0xFFEFEFEF),
          dataTableTheme: const DataTableThemeData(
            headingRowHeight: 50,
            columnSpacing: 2,
            dividerThickness: 1,
            // headingRowColor: WidgetStateColor.resolveWith(
            //   (states) => const Color(0xFFEFEFEF),
            // ),
          ),
          // dialogTheme: const DialogTheme(
          //   backgroundColor: Color(0xFFE8E8E8),
          // ),
          cardTheme: CardTheme(
            color: const Color(0xFFEFEFEF),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          // radioTheme: RadioThemeData(
          //   fillColor: WidgetStateColor.resolveWith(
          //       (states) => const Color(0xFF22B88A)),
          // ),
          textTheme: const TextTheme(
            // titleMedium: TextStyle(fontSize: 12),
            headlineMedium: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF140035),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Color(0xFFE8E8E8),
            backgroundColor: Color(0xFF22B88A),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF22B88A),
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.only(left: 30),
            fillColor: const Color(0xFFE8E8E8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 1, color: Color(0xFF22B88A)),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFFFFEFE),
              backgroundColor: const Color(0xFF22B88A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Color(0xFF1D202D),
          ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
              linearTrackColor:
                  const Color.fromARGB(255, 157, 201, 188).withOpacity(0.1),
              color: Color(0xFF22B88A)),
        ),
        home: FutureBuilder(
            future: getUserData(pathName),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const SpinKitThreeInOut(
                      color: EnvisionColor.primaryColor);
                default:
                  // final loginData = snapshot.data as UserLogin;
                  // if (loginData.user?.userFName == null) {
                  return const LoginPage();
                // } else {
                // Provider.of<UserProvider>(context, listen: false)
                //     .removeUser();
                // Provider.of<UserProvider>(context, listen: false)
                //     .setUser(loginData.user as User);
                // return HomePage();
                // return const MainPage();
                // }
              }
            }),
      ),
    );
  }
}
