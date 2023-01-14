import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/models/GroceryItemsModel/GroceryModel.dart';
import 'package:recipe_project/shared/components/components.dart';
import 'package:recipe_project/shared/styles/colors.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class GroceryPage extends StatelessWidget {
  const GroceryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var itemKey= GlobalKey();
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},

      builder: (context,state)
      {
        var cubit= AppCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ConditionalBuilder(
              condition: AppCubit.groceryItems!.isNotEmpty,
              fallback: (context)=> const Center(child: Text('Wow, Such Empty!')),
              builder: (context)
              {
                return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=> itemBuilder(cubit, AppCubit.groceryItems![index], itemKey), //AppCubit.groceryItems![index]
                    separatorBuilder: (context,index)=> myDivider(),
                    itemCount: AppCubit.groceryItems!.length
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget itemBuilder(AppCubit cubit, GroceryItem item, Key key)
  {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      highlightColor: Colors.black.withOpacity(0.1),
      onTap: ()
      {
        print(item.id);
      },
      onDoubleTap: ()
      {
        cubit.removeGroceryItem(item.id);
      },
      child: Column(
        children: [
          const SizedBox(height: 10,),

          Container(
              width: double.infinity,
              height: 90,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [

                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 6.0, top: 6.0, end: 6.0),
                    child: Row(
                      children:
                      [
                        Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),

                        const Spacer(),

                        IconButton(
                            onPressed: ()
                            {
                              print('Current Item id: ${item.id}');
                              cubit.checkingGroceryItem(item.id);
                            },
                            icon: Icon(
                              item.isChecked? Icons.check_box_outlined:Icons.check_box_outline_blank_outlined,
                              size: 25,
                              color: cubit.isDarkTheme? defaultDarkColor : defaultColor,
                            ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 6.0, bottom: 6.0, end: 6.0),
                    child: Row(
                      children:
                      [
                        Text(
                          item.details,
                          style: const TextStyle(
                            fontSize: 16
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),

                        const Spacer(),

                        Text(
                          item.time,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
          ),

          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
