import 'package:codex/bloces/Login_blocs/login_bloc.dart';
import 'package:codex/bloces/productdetalis_bloc/productdetalis_bloc.dart';
import 'package:codex/bloces/viewdetalis_bloc/viewdetalis_bloc.dart';
import 'package:codex/widgets/NavigationServies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'View/loginpage.dart';

const String basePath = "https://prethewram.pythonanywhere.com/api/";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>LoginBloc()),
        BlocProvider(create: (context)=>ProductdetalisBloc()),
        BlocProvider(create: (context)=>ViewdetalisBloc())
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        home: const Loginin(),
      ),
    );
  }
}
