import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_layout/cubit/cubit.dart';
import '../../home_layout/cubit/states.dart';
import '../../shared/components/components.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (context)=>ListView.separated(
                itemBuilder:(context,index )=> buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context,index,isOldPrice: true),
                separatorBuilder: (context,index )=>myDivider(),
                itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length
             ),
            fallback:(context)=> Center(child: CircularProgressIndicator()),
          );
        }
    );
  }

}
