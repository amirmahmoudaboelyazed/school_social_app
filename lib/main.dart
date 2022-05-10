import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/comment/comment_cubit/bloc_event.dart';

import 'Helper/observer.dart';
import 'comment/comment.dart';
import 'comment/comment_cubit/comment_bloc.dart';
import 'home/home_cubit/bloc_event.dart';
import 'home/home_cubit/post_bloc.dart';
import 'home/home_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home:PostsList(),
            );
      },
    );
  }
}
