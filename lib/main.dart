import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter_app/core/store.dart';
import 'package:first_flutter_app/pages/cart_page.dart';
import 'package:first_flutter_app/pages/login_screen.dart';
import 'package:first_flutter_app/pages/registration_screen.dart';
import 'package:first_flutter_app/utils/routes.dart';
import 'package:first_flutter_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    VxState(store: MyStore(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    // int days = 1;
    // String name = "Imad";
    // double value = 1.24;
    // bool isMale = true;
    // num temp = 33.4; // 'num' can take both 'int' and 'double' values

    // var day = "Sunday";
    // const PI = 3.14;

    return MaterialApp(
      // home: HomePage(),
      themeMode: ThemeMode.light,
      // themeMode: ThemeMode.dark,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      // routeInformationParser: VxInformationParser(),
      // routerDelegate: VxNavigator(routes: {
      //   "/": (_, __) => MaterialPage(child: LoginPage()),
      //   MyRoutes.homeRoute: (_, __) => MaterialPage(child: HomePage()),
      //   MyRoutes.homeDetailsRoute: (uri, _) {
      //     final catalog = (VxState.store as MyStore)
      //         .catalog
      //         .getById(int.parse(uri.queryParameters["i"].toString()));
      //     return MaterialPage(
      //         child: HomeDetailPage(
      //       catalog: catalog,
      //     ));
      //   },
      //   MyRoutes.loginRoute: (_, __) => MaterialPage(child: LoginPage()),
      //   MyRoutes.cartRoute: (_, __) => MaterialPage(child: CartPage()),
      // }),
      // initialRoute: MyRoutes.loginRoute,
      routes: {
      "/": (context) => const LoginScreen(),
      MyRoutes.loginRoute: (context) => const LoginScreen(),
      MyRoutes.signUpRoute: (context) => const RegistrationScreen(),
      MyRoutes.homeRoute: (context) => const HomePage(),
      MyRoutes.cartRoute: (context) => const CartPage(),
      }
    );
  }
}
