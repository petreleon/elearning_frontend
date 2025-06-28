import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'app_router.dart';
import 'user.dart';
import 'session_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print(await getApplicationDocumentsDirectory());
  // await HiveHelper
  //     .deleteAllData(); // Delete all Hive data on startup (for debug/dev only)
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
  final currentUser = await SessionManager.getCurrentUser();
  runApp(MyApp(currentUser: currentUser));
}

class MyApp extends StatelessWidget {
  final String? currentUser;
  const MyApp({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Routing Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // Change background color
          foregroundColor: Colors.white, // Change text/icon color
          elevation: 4.0, // Add shadow effect to separate from background
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute:
          currentUser != null ? '/content' : '/', // Start with the main page
    );
  }
}
