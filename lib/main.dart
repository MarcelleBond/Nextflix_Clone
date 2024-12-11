import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_theme.dart';
import 'providers/account.dart';
import 'providers/movie.dart';
import 'providers/watchlist.dart';
import 'screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => MovieProvider()),
        ChangeNotifierProvider(create: (context) => WhatchlistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      onGenerateRoute: _generateRoute,
      themeMode: ThemeMode.dark,
      home: FutureBuilder(
        future: context.read<AccountProvider>().isValid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          return context.watch<AccountProvider>().session != null
              ? const HomeScreen()
              : const OnboardingScreen();
        },
      ),
    );
  }

  Route? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SplashScreen(),
        );
      case OnboardingScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const OnboardingScreen(),
        );
      case HomeScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => context.watch<AccountProvider>().session == null
              ? const OnboardingScreen()
              : const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => context.watch<AccountProvider>().session == null
              ? const OnboardingScreen()
              : const HomeScreen(),
        );
    }
  }
}
