import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/shared/network/remote/main_dio_helper.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/home_layout.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/styles/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); //Makes sure that all the await and initializer get done before runApp

  Bloc.observer = MyBlocObserver(); //Running Bloc Observer which prints change in states and errors etc...  in console

  await CacheHelper.init(); //Starting CacheHelper, await for it since there is async,await in .init().

  MainDioHelper.init(); //Initializing Dio

  bool? isDark = CacheHelper.getData(key: 'isDarkTheme'); //Getting the last Cached ThemeMode
  isDark ??= false;

  runApp( MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  const MyApp({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context) => AppCubit()..changeTheme(themeFromState: isDark) ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},

        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme(context),
            darkTheme: darkTheme(context),
            themeMode: AppCubit.get(context).isDarkTheme   //If the boolean says last used is dark (from Cache Helper) => Then load dark theme
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const HomeLayout(),
          );
        },
      )
    );
  }
}
