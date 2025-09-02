import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_app/application/cubit/auth/auth_cubit.dart';
import 'package:scooter_app/application/cubit/scooters_cubit.dart';
import 'package:scooter_app/bottom_navigation.dart';
import 'package:scooter_app/data/datasources/firebase_auth_datasource.dart';
import 'package:scooter_app/data/datasources/scooter_local_data.dart';
import 'package:scooter_app/data/repository/auth_repository_impl.dart';
import 'package:scooter_app/domain/repository/auth_repository.dart';
import 'package:scooter_app/presentation/pages/home_screen.dart';
import 'package:scooter_app/presentation/pages/sign_in_screen.dart';
import 'package:scooter_app/presentation/pages/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final ds =
      FirebaseAuthDataSource(FirebaseAuth.instance, FirebaseFirestore.instance);
  final repo = AuthRepositoryImpl(ds);

  runApp( MyApp(authRepository:repo ,));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  const MyApp({super.key, required this.authRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AuthCubit(authRepository)..checkAuthStatus()),
        BlocProvider(
            create: (_) => ScooterCubit(ScootersLocalData())..fetchScooters()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BottomNav(),
      ),
    );
  }
}
