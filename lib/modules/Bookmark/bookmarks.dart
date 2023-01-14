import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/shared/components/components.dart';
import 'package:recipe_project/shared/styles/styles.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},

      builder: (context,state)
      {
        var cubit= AppCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ConditionalBuilder(
                condition: AppCubit.favouritesModel !=null,
                fallback: (context)=> const Center(child: Text('Wow, Such Empty!'),),
                builder: (context)
                {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),

                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            'Bookmarked Items',
                            style: defaultHeadlineTextStyle,
                          ),
                        ),

                        const SizedBox(height: 20,),

                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,index)=>mainItemBuilder(context,  AppCubit.favouritesModel![index], cubit),
                            separatorBuilder: (context,index)=>myDivider(),
                            itemCount: AppCubit.favouritesModel!.length
                        ),
                      ],
                    ),
                  );
                },
            ),
          ),
        );
      },
    );
  }
}
