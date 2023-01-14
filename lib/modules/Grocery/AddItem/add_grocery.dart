import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/layout/cubit/cubit.dart';
import 'package:recipe_project/layout/cubit/states.dart';
import 'package:recipe_project/shared/components/components.dart';

import '../../../shared/styles/styles.dart';

class AddGroceryPage extends StatelessWidget {
  const AddGroceryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var nameController= TextEditingController();

    var timeController= TextEditingController();
    var detailsController= TextEditingController();

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state)
      {
        if(state is AppAddGroceryItemSuccessState)
          {
            defaultToast(msg: 'Successfully Added');
            Navigator.pop(context);
          }

        if(state is AppAddGroceryItemLoadingState)
          {
            defaultToast(msg: 'Adding...');
          }

        if(state is AppAddGroceryItemErrorState)
          {
            defaultToast(msg: 'Error While Adding');
          }
      },

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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text(
                      'Add Item',
                      style: defaultHeadlineTextStyle,
                    ),

                    const SizedBox(height: 50,),

                    defaultFormField(
                        controller: nameController,
                        keyboard: TextInputType.text,
                        label: 'Grocery Name',
                        prefix: Icons.list_outlined,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                            {
                              return 'Enter Name';
                            }
                          return null;
                        },
                    ),

                    const SizedBox(height: 40,),

                    defaultFormField(
                      controller: timeController,
                      keyboard: TextInputType.text,
                      label: 'Grocery Time',
                      prefix: Icons.access_time_outlined,
                      readOnly: true, //User cannot type in
                      onTap: ()
                      {
                        showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                        ).then((value)
                        {
                          timeController.text= value!.format(context);
                        }).catchError((error)
                        {
                          print('error caught in TimePicker, ${error.toString()}');
                        });
                      },
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'Enter Time';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 40,),

                    defaultFormField(
                      controller: detailsController,
                      keyboard: TextInputType.text,
                      label: 'Grocery Details',
                      prefix: Icons.description_outlined,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'Enter Details';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 40,),

                    defaultButton(
                        function:()
                        {
                          if(formKey.currentState!.validate())
                            {
                              cubit.addGroceryItem(
                                  name: nameController.value.text,
                                  time: timeController.value.text,
                                  details: detailsController.value.text,
                                  isChecked: false, //Can't be Checked if has just been added.
                              );
                            }
                        },
                        text: 'submit'
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
