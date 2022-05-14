
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_layout/cubit/cubit.dart';
import 'home_layout/shop_layout.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  bool? isDark=CacheHelper.getData(key: 'isDark');
  Widget? widget;
  bool? onBoarding=CacheHelper.getData(key: 'onBoarding');
  String? token=CacheHelper.getData(key: 'token');
  if(onBoarding!=null){
    if(token!=null)widget=ShopLayout();
     else widget=ShopLoginScreen();
  }else widget=OnBoardingScreen();

  BlocOverrides.runZoned(
          ()=>runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      )),
      blocObserver: MyBlocObserver()
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark,this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changeAppMode(fromShared:isDark)),
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesModel()..getFavoritesModel()..getUserData()..getCartModel()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: AppCubit.get(context).isDark?ThemeMode.light:ThemeMode.light,
            home: startWidget,
          );
        },

      ),
    );
  }
}
