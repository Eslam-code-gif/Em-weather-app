import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_weather_app/pages/splash.dart';
import 'package:provider/provider.dart';
import 'package:minimal_weather_app/theme/theme_provider.dart';
import 'package:minimal_weather_app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 950),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeProvider.themeMode,
        );
      },
      child: const SplashScreen(),
    );
  }
}