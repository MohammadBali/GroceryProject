import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/layout/cubit/cubit.dart';
import 'package:recipe_project/layout/cubit/states.dart';
import 'package:recipe_project/models/EdamamModels/searchModel.dart';
import 'package:recipe_project/shared/styles/colors.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/styles.dart';

class ShowItem extends StatelessWidget {

  final HitsModel model;

  const ShowItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},

      builder: (context,state)
      {
        var cubit= AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions:
            [
              IconButton(onPressed: (){AppCubit.get(context).changeTheme();}, icon: const Icon(Icons.sunny)),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children:
                [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      model.recipe!.label!,
                      style: defaultHeadlineTextStyle,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Text(
                      '${model.recipe!.totalTime!} Minutes to Cook',
                      style: TextStyle(
                        color: cubit.isDarkTheme? defaultDarkColor : defaultColor,
                        fontSize: 16
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20,),
                  
                  GestureDetector(
                    onTap: ()
                    {
                      print(model.recipe!.url!);
                      defaultLaunchUrl(model.recipe!.url!);
                    },
                    child: Image(
                      image: NetworkImage(model.recipe!.image!,),
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context,error,stackTrace)
                      {
                        print('Error while getting photo, showing default image, Error is: ${error.toString()}');
                        return Image.asset('assets/images/defaultImage.png');
                      },
                    ),
                  ),

                  const SizedBox(height: 30,),

                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Ingredients:',
                      style: goldenHeadlineTextStyle,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Text(
                    model.recipe!.ingredientLines!.join(', '),
                    style: const TextStyle(
                      fontSize: 15
                    ),
                  ),

                  const SizedBox(height: 30,),

                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Calories: ${model.recipe!.calories!.toString().substring(0,6)}',
                      style: defaultHeadlineTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
