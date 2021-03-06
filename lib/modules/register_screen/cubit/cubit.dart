import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/modules/register_screen/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStatus>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userRegister({required String email, required String password,required String name, required String phone}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:{
          'name': name,
          'password':password,
          'email':email,
          'phone':phone,
        }
    ).then((value) {
      print(value.data);
      loginModel= ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  IconData suffix =Icons.visibility_outlined;
  bool isPassword=true;
  void  changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }


}