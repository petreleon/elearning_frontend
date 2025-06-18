import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'main_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'content_page.dart';
import 'organizations_page.dart';
import 'organization_detail_page.dart';
import 'profile_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/content':
        return MaterialPageRoute(builder: (_) => const ContentPage());
      case '/organizations':
        return MaterialPageRoute(builder: (_) => const OrganizationsPage());
      case '/organization-detail':
        return MaterialPageRoute(
            builder: (_) => const OrganizationDetailPage(), settings: settings);
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Unknown route'),
            ),
          ),
        );
    }
  }
}
