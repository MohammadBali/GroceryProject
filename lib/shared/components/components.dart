import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/EdamamModels/searchModel.dart';
import '../../modules/Search/showItem.dart';

//a default text Button
Widget defaultTextButton({required void Function()? onPressed, required String text, TextStyle? style})
=>TextButton(
    onPressed: onPressed,
    child: Text(
      text.toUpperCase(),
      style: style,
    )
);


//--------------------------------------------------------------------------------------------------\\

//DefaultToast message

Future<bool?> defaultToast({
  required String msg,
  ToastStates state=ToastStates.defaultType,
  ToastGravity position = ToastGravity.BOTTOM,
  Color color = Colors.grey,
  Color textColor= Colors.white,
  Toast length = Toast.LENGTH_SHORT,
  int time = 1,
}) =>
    Fluttertoast.showToast(

      msg: msg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time,
      toastLength: length,
      backgroundColor: chooseToastColor(state),
      textColor: textColor,
    );

enum ToastStates{success,error,warning, defaultType}

Color chooseToastColor(ToastStates state) {
  switch (state)
  {
    case ToastStates.success:
      return Colors.green;
  // break;

    case ToastStates.error:
      return Colors.red;
  // break;

    case ToastStates.defaultType:
      return Colors.grey;

    case ToastStates.warning:
      return Colors.amber;
  // break;


  }
}

//--------------------------------------------------------------------------------------------------\\


// Navigate to a screen, it takes context and a widget to go to.

void navigateTo( BuildContext context, Widget widget) =>Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>widget),
);


//--------------------------------------------------------------------------------------------------\\


//Default Divider for ListViews ...
Widget myDivider({Color? c=Colors.grey, double padding=0}) => Container(height: 1, width: double.infinity , color:c, padding: EdgeInsets.symmetric(horizontal: padding),);

//--------------------------------------------------------------------------------------------------\\

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboard,
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,
  IconData? suffix,
  bool isObscure = false,
  bool isClickable = true,
  void Function(String)? onSubmit,
  void Function()? onPressedSuffixIcon,
  void Function()? onTap,
  void Function(String)? onChanged,
  void Function(String?)? onSaved,
  InputBorder? focusedBorderStyle,
  InputBorder? borderStyle,
  TextStyle? labelStyle,
  Color? prefixIconColor,
  Color? suffixIconColor,
  TextInputAction? inputAction,
  double borderRadius=0,
  bool readOnly=false,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboard,
      onFieldSubmitted: onSubmit,
      textInputAction: inputAction,
      validator: validate,
      enabled: isClickable,
      readOnly: readOnly,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: focusedBorderStyle,
        enabledBorder: borderStyle,
        labelStyle: labelStyle,
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Icon(prefix, color: prefixIconColor,),
        suffixIcon: IconButton(
          onPressed: onPressedSuffixIcon,
          icon: Icon(
            suffix,
            color: suffixIconColor,
          ),
        ),
      ),
    );


//----------------------------------------------------------------\\

Widget defaultButton({
  double width = double.infinity,
  Color background =  Colors.blue,
  bool isUpper = true,
  double radius = 5.0,  //was 10
  double height = 45.0, // was 40
  double elevation=2,
  bool shadow=false,
  required void Function()? function,
  required String text,
}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: shadow? [BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 4,
          blurRadius: 10,
          offset: const Offset(0, 3),
        )] : null,
      ),

      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        elevation: elevation,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );



//------------------------------------------------------------------------\\

Widget mainItemBuilder(BuildContext context, HitsModel model, AppCubit cubit)
{
  return GestureDetector(
    onTap: ()
    {
      navigateTo(context, ShowItem(model: model,));
    },
    child: Column(
      children: [
        const SizedBox(height: 20,),

        Container(
          width: double.infinity,
          height: 100,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(model.recipe!.image!),  //model.recipe!.image!
              fit: BoxFit.fitWidth,
              opacity: 0.2,
              onError:(error,stacktrace)
              {
                print('Error in getting image, ${error.toString()}');
              },
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              const Spacer(),

              Align(
                alignment: Alignment.center,
                child: Text(
                  model.recipe!.label!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              const Spacer(),

              Row(
                children:
                [
                  IconButton(
                      onPressed: ()
                      {
                        cubit.alterFavourites(model.recipe!);
                      },
                      icon: Icon(
                        cubit.isInFavourites(model.recipe!.label!)? Icons.star :Icons.star_outline,
                        size: 25,
                      )
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        model.recipe!.mealType!.join(','),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20,),
      ],
    ),
  );
}


//-------------------------------------------------------------------------\\

//Default URL Launcher, it takes the link to be opened.
Future<void> defaultLaunchUrl(String ur) async
{
  final Uri url = Uri.parse(ur);
  if (!await launchUrl(url))
  {
    throw 'Could not launch $url';
  }
}