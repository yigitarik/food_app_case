import 'package:flutter/material.dart';
import 'package:food_mood/controllers/category_controller.dart';
import 'package:food_mood/core/constants/colors.dart';
import 'package:food_mood/core/extensions/context_extensions.dart';
import 'package:food_mood/core/services/shared_preferences_services.dart';
import 'package:food_mood/views/home_view.dart';
import 'package:provider/provider.dart';

final SharedPreferencesService preferencesService = SharedPreferencesService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await preferencesService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryController())
      ],
      child: MaterialApp(
        title: 'Food Mood',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: preferencesService.containsKeyCheck(key: 'firstLogin')
            ? const HomeView()
            : const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/foodappsplash.png'),
                fit: BoxFit.cover)),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          preferencesService.setStringValue(key: 'firstLogin', value: 'false');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ));
        },
        child: Container(
          width: context.dynamicWidth(0.3),
          height: context.dynamicHeight(0.07),
          margin: EdgeInsets.symmetric(
              vertical: context.dynamicWidth(0.04),
              horizontal: context.dynamicWidth(0.15)),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: const Center(
            child: Text(
              'Get Started',
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
