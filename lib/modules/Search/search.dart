import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var searchController= TextEditingController();
    var formKey= GlobalKey<FormState>();

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},

      builder: (context,state)
      {
        var cubit= AppCubit.get(context);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children:
                [
                  defaultFormField(
                      controller: searchController,
                      keyboard: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search,
                      borderRadius: 10,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'Enter Data';
                        }
                        return null;
                      },
                      onSubmit: (String text)
                      {
                        if(formKey.currentState?.validate() ==true)
                          {
                           cubit.searchItem(searchController.value.text);
                          }
                      }
                  ),

                  const SizedBox(height: 20,),

                  if(AppCubit.searchModel !=null && state is! AppSearchLoadingState)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index)=> mainItemBuilder(context, AppCubit.searchModel!.hits![index], cubit),
                        separatorBuilder: (context,index)=> myDivider(),
                        itemCount: AppCubit.searchModel!.hits!.length,
                    ),
                  ),

                  if(state is AppSearchLoadingState)
                    const Center(child: CircularProgressIndicator(),)
                ],

              ),
            ),
          ),
        );
      },
    );
  }


}
