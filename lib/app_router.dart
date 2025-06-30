import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/main_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/content_page.dart';
import 'pages/organizations_page.dart';
import 'pages/organization_detail_page.dart';
import 'pages/profile_page.dart';

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
