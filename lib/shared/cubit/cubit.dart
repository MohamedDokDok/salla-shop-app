import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/shared/cubit/states.dart';

import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;


  List title = ['New Tasks', 'Done Tasks', 'Archive Tasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }


  void changeBottomSheetState({
      required bool isShow,
      required IconData icon,

    }){
        isBottomSheetShown=isShow;
        fabIcon=icon;
        emit(AppChangeBottomSheetState());
      }
  bool isDark=false;
  void changeAppMode({bool? fromShared}){
    if(fromShared!=null){
      emit(AppChangeModeState());
      isDark=fromShared;
    }
    else{isDark=!isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    });}

  }
}
