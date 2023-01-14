import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/layout/cubit/states.dart';
import 'package:recipe_project/modules/Bookmark/bookmarks.dart';
import 'package:recipe_project/modules/Grocery/grocery.dart';
import 'package:recipe_project/modules/Search/search.dart';
import 'package:recipe_project/shared/network/end_points.dart';
import 'package:recipe_project/shared/network/remote/main_dio_helper.dart';

import '../../models/EdamamModels/searchModel.dart';
import '../../models/GroceryItemsModel/GroceryModel.dart';
import '../../shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super(AppInitialState());  //Initial State given to super

  static AppCubit get(context) =>BlocProvider.of(context);  //Get instance to access members.

  List<Widget> list= //List of the widgets each bottomNav item will open.
  [
    const SearchPage(),
    const BookmarksPage(),
    const GroceryPage(),
  ];

  int currentIndex=0;  //The Index of the BottomNavBar item.

  void changeBottom(int index) //Function will be called when the bottom navigation bar item has changed, which will change the index and emit the state.
  {
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  bool isGrocery()  //In order to show FloatingActionButton only in the Grocery Page, a check will happen on the index, if 2 then it's Grocery page, will return true.
  {
    if(currentIndex==2)
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  bool isDarkTheme=false; //Check if the theme is Dark.

  void changeTheme({bool? themeFromState})
  {
    if(themeFromState !=null)  //if a value is sent from main, then use it.. we didn't use CacheHelper because the value has already came from cache, then there is no need to..
        {
      isDarkTheme=themeFromState;
      emit(AppChangeThemeModeState());
    }
    else                      // else which means that the button of changing the theme has been pressed.
        {
      isDarkTheme= !isDarkTheme;
      CacheHelper.putBoolean(key: 'isDarkTheme', value: isDarkTheme).then((value)  //Put the data in the sharedPref and then emit the change.
      {
        emit(AppChangeThemeModeState());
      });
    }

  }


  //-----------------------------------------------//

//Grocery Items.
  static int groceryIds=0; //Basic groceryId

  static List<GroceryItem>? groceryItems=
  [
    // GroceryItem(id: 0, name: "French Fries", time: "7.20 PM", isChecked: false, details: "Buy fires from Walmart"), //Pre-Defined Item.
  ];  //Default List of groceryItems.

  //Add an Item to Grocery List
  void addGroceryItem({required String name, required String time, required String details, required bool isChecked})
  {
    emit(AppAddGroceryItemLoadingState());

    try
    {
      groceryItems?.add(GroceryItem(id: groceryIds+1, name: name, time: time, isChecked: isChecked, details: details));  //Adding item to groceryItems.
      emit(AppAddGroceryItemSuccessState());
    }
    catch(error)
    {
      print('Error While Adding to groceryItems, ${error.toString()}');
      emit(AppAddGroceryItemErrorState());
    }

  }


  void removeGroceryItem(int index)
  {
    emit(AppRemoveGroceryItemLoadingState());

    try
    {
      groceryItems?.forEach((element)
      {
        if(element.id==index)
          {
            groceryItems?.remove(element);
            emit(AppRemoveGroceryItemSuccessState());
          }
      });

    }
    catch(error)
    {
      print('error while removing item, ${error.toString()}');
      emit(AppRemoveGroceryItemErrorState());
    }
  }

  void checkingGroceryItem(int index)
  {
    emit(AppCheckGroceryItemLoadingState());
    try
    {
      groceryItems?.forEach((element)
      {
        print(element.id);
        if(element.id ==index)
          {
            if(element.isChecked ==true)
            {
              element.isChecked=false;
            }
            else
            {
              element.isChecked =true;
            }

            emit(AppCheckGroceryItemSuccessState());
          }
      });
    }
    catch(error)
    {
      print('Error while checking item, ${error.toString()}');
      emit(AppCheckGroceryItemErrorState());
    }

  }



  //API METHODS:

  static SearchModel? searchModel;

  void searchItem(String text)
  {
    print('in Searching for Items');
    searchModel=null;
    emit(AppSearchLoadingState());

    MainDioHelper.getData(
        url: search,
        query:
        {
          'q':text,
          'type':'any',
          'app_id': appId,
          'app_key': appKey,
        },
    ).then((value)
    {
      print('Got Data, ${value.data}');
      searchModel= SearchModel.fromJson(value.data);
      emit(AppSearchSuccessState());
    }).catchError((error)
    {
      print('Error while searching for data, ${error.toString()}');
      emit(AppSearchErrorState());
    });
  }


  //------------------------------//

  // User favourite List of Meals

  static List<HitsModel>? favouritesModel=[];

  void alterFavourites(RecipeModel recipe)
  {
    bool isAvailable=false;
    emit(AppEditFavouritesLoadingState());
    try
    {
      favouritesModel?.forEach((element)
      {
       if(element.recipe!.label == recipe.label) //Item exists.
         {
           print('Added,removing');

           favouritesModel?.remove(element); //Remove this item.

           isAvailable=true; //Already Added

           emit(AppEditFavouritesSuccessState());
         }
      });

      if(isAvailable ==false) //No Such Item is stored.
        {
          favouritesModel?.add(HitsModel(recipe: recipe, isFavourite: true)); //Adding the Item.
          emit(AppEditFavouritesSuccessState());
        }
    }
    catch(error)
    {
      print('Error while adding to favourites, ${error.toString()}');
      emit(AppEditFavouritesErrorState());
    }
  }


  bool isInFavourites(String label)
  {
    bool isFound=false;
    favouritesModel?.forEach((element)
    {
      if(element.recipe!.label ==label)
        {
          isFound=true;
          emit(AppIsInFavouritesState());
        }
    });

    return isFound;
  }


}