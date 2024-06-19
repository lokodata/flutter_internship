import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_app_bloc/pages/home_page.dart';
import 'package:to_do_app_bloc/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_bloc/to_do_bloc/to_do_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(const ToDoAppBloc());
}

class ToDoAppBloc extends StatelessWidget {
  const ToDoAppBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc ToDo App',
      theme: ThemeData.from(colorScheme: lightColorScheme),
      home: BlocProvider<ToDoBloc>(
        create: (context) => ToDoBloc()..add(ToDoStarted()),
        child: const HomePage(),
      ),
    );
  }
}
