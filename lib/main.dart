import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user_generator/cubit/user_cubit.dart';
import 'package:random_user_generator/repositories/dio_settings.dart';
import 'package:random_user_generator/repositories/user_repo.dart';
import 'package:random_user_generator/screens/user_screen.dart';

import 'repositories/dio_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => UserRepo(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        )
      ],
      child: BlocProvider(
        create: (context) => UserCubit(userRepo: RepositoryProvider.of(context))
          ..getRandomUser(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: UserScreen(),
        ),
      ),
    );
  }
}
