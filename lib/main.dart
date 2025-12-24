import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/bloc/auth_bloc.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  final httpClient = http.Client();

  // Data layer
  final authRemoteDataSource = AuthRemoteDataSourceImpl(
    client: httpClient,
    baseUrl: 'https://api.example.com', // Replace with your API URL
  );

  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    sharedPreferences: sharedPreferences,
  );

  // Domain layer
  final loginUsecase = LoginUsecase(authRepository);

  // Presentation layer
  final authBloc = AuthBloc(
    loginUsecase: loginUsecase,
    authRepository: authRepository,
  );

  runApp(MyApp(authBloc: authBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;

  const MyApp({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authBloc,
      child: MaterialApp(
        title: 'Aplikasi LMS',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
