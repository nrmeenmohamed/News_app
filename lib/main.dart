import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/cubit/bloc_observer.dart';
import 'layout/cubit/state.dart';
import 'layout/news_layout.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

    bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark ?? false));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..changeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: NewsLayout(),
            theme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: Colors.white,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                unselectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                elevation: 30.0,
              ),
              textTheme: TextTheme(
                titleMedium: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.black
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.grey[600],
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: Colors.grey[600],
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.grey[600],
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                unselectedItemColor: Colors.white,
                backgroundColor: Colors.grey[600],
                type: BottomNavigationBarType.fixed,
                elevation: 30.0,
              ),
              textTheme: TextTheme(
                titleMedium: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),

            ),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );

        },
      ),
    );
  }
}
