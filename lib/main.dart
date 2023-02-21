import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiprovider/bloc/Bottom_bloc.dart';
import 'package:multiprovider/bloc/top_bloc.dart';
import 'package:multiprovider/models/constants.dart';
import 'package:multiprovider/views/app_bloc_view.dart';

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("multiprovider")),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<TopBloc>(
                  create: (_) => TopBloc(
                      waitBeforeLoading: Duration(seconds: 2), urls: images)),
              BlocProvider<BottomBloc>(
                  create: (_) => BottomBloc(
                      waitBeforeLoading: Duration(seconds: 2), urls: images))
            ],
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [AppBlocView<TopBloc>(), AppBlocView<BottomBloc>()],
            ),
          ),
        ));
  }
}
