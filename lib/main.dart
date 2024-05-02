import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistic/route/route_generate.dart';
import 'package:logistic/route/route_list.dart';
import 'package:logistic/ui/login_page.dart';

import 'business_logic/bloc/login/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: RouteList.loginPage,
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home:
            // const MyHomePage(title: "Flutter App",),
            BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(), child: const LoginPage()));
  }
}
