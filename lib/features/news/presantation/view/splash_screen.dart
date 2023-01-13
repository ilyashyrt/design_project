import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:design_project/features/news/presantation/view/cubit/theme_cubit.dart';
import 'package:design_project/features/news/presantation/view/news_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedSplashScreen(
            backgroundColor: Colors.orange.shade800,
            splash: LottieBuilder.asset('assets/animations/splash.json'),
            splashIconSize: 400,
            duration: 1000,
            splashTransition: SplashTransition.fadeTransition,
            animationDuration: const Duration(seconds: 1),
            nextScreen: const SplashTwo()),
      ),
    );
  }
}

class SplashTwo extends StatelessWidget {
  const SplashTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedSplashScreen(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          splash:
              LottieBuilder.asset('assets/animations/orange_animation.json'),
          splashIconSize: 400,
          duration: 100,
          splashTransition: SplashTransition.fadeTransition,
          animationDuration: const Duration(seconds: 4),
          nextScreen: BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
            child: BlocBuilder<ThemeCubit, bool>(
              builder: (context, state) {
                return MaterialApp(
                  themeMode: state ? ThemeMode.dark : ThemeMode.light,
                  darkTheme: ThemeData.dark(),
                  theme: ThemeData(
                    brightness: state ? Brightness.dark : Brightness.light,
                  ),
                  debugShowCheckedModeBanner: false,
                  home: const NewsPage(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
