import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/news_layout.dart';
import 'network/bloc_observer.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  // وعشان ال main  بقا async  ال widget  دي بتضمن لي ان الحاجات الل عليها await هيا الل تتنفذ الاول وبعدين يعمل runApp
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  //   هنا  await عشان ال الكاش هيلبر هناك عليه async في class
  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));

}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..changeAppMode(
        fromShared: isDark,
      ) ..getBusiness()..getSports()..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            color: Colors.green,
            home: NewsLayout(),
            // دا التحوييييييييييييييييييييييييييييييييل الخاص بالمووود

            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              // ال theme  اللي هيمشي علي AppBar بس
              appBarTheme: AppBarTheme(
                  // ال theme  اللي هيمشي علي Icon بس
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  // ال theme  اللي هيمشي علي text بس
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              // ال theme  اللي هيمشي علي BNB بس
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 90.0,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
            ),

            // ال theme  اللي هيمشي علي التطبيق كله
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              // ال theme  اللي هيمشي علي AppBar بس
              appBarTheme: AppBarTheme(
                  // ال theme  اللي هيمشي علي Icon بس
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  // ال theme  اللي هيمشي علي text بس
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              // ال theme  اللي هيمشي علي BNB بس
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 90.0,
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),

            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.light
                : ThemeMode.dark,
          );
        },
      ),
    );
  }
}
