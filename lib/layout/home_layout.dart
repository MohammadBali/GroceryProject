import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/layout/cubit/cubit.dart';
import 'package:recipe_project/layout/cubit/states.dart';
import 'package:recipe_project/shared/styles/colors.dart';

import '../modules/Grocery/AddItem/add_grocery.dart';
import '../shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},

      builder: (context,state)
      {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            title: Text(
              'Grocery',
              style: TextStyle(
                color: cubit.isDarkTheme? defaultDarkColor : defaultColor
              ),
            ),

            actions:
            [
              IconButton(onPressed: (){AppCubit.get(context).changeTheme();}, icon: const Icon(Icons.sunny)),
            ],
          ),

          body:cubit.list[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(

            currentIndex: cubit.currentIndex,

            onTap: (index)
            {
              cubit.changeBottom(index);
            },

            items:
            const [
              BottomNavigationBarItem(label: 'Search' , icon: Icon(Icons.search_outlined)),

              BottomNavigationBarItem(label: 'Bookmarks' , icon: Icon(Icons.bookmark_outlined)),

              BottomNavigationBarItem(label: 'Grocery Items' , icon: Icon(Icons.local_grocery_store_outlined)),
            ],

          ),

          floatingActionButton: Visibility(
            visible: cubit.isGrocery(),
            child: FloatingActionButton(
              onPressed: ()
              {
                navigateTo(context,const AddGroceryPage());
              },
              child: const Icon(Icons.add,),
            ),
          ),
        );
      },
    );
  }
}
