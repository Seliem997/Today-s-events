import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:sizer/sizer.dart';

import 'cubit/cubit.dart';

void main() async {

  //  ******************* بيتاكد ان كل حاجه ف الميثود هنا خلصت من await وغيره وبعدين يرن(يفتح الابلكيشن)
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isDark, {Key? key,}) : super(key: key);

  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return BlocProvider(
            create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark),
            child: BlocConsumer<AppCubit, AppStates>(
              listener: (context, state){},
              builder: (context, state){
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      titleSpacing: 20,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white30,
                          statusBarIconBrightness: Brightness.dark,

                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      // backgroundColor: Colors.white,
                      elevation: 0.0,
                    ),
                    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20.0,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white,
                    ),
                    textTheme: const TextTheme(
                        bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.black,
                    ),
                    primarySwatch: Colors.deepOrange,
                  ),
                  darkTheme: ThemeData(
                    scaffoldBackgroundColor: const Color(0xFF333739),
                    appBarTheme: const AppBarTheme(
                      titleSpacing: 20,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xFF333739),
                        statusBarIconBrightness: Brightness.light,
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Color(0xFF333739),
                      elevation: 0.0,
                    ),

                    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                        selectedItemColor: Colors.deepOrange,
                        unselectedItemColor: Colors.grey,
                        elevation: 20.0,
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Color(0xFF333739)
                    ),
                    textTheme: const TextTheme(
                        bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        )
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    primarySwatch: Colors.deepOrange,
                  ),

                  themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                  home: const Directionality(
                    textDirection: TextDirection.ltr,
                    child: NewsLayout(),
                  ),
                );
              },
            ),

          );
        },
    );
  }
}
