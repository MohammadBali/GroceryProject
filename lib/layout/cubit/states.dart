abstract class AppStates{}


//MAIN STATES
class AppInitialState extends AppStates{}

class AppChangeThemeModeState extends AppStates{}

class AppChangeBottomNavBarState extends AppStates{}


// GROCERY ITEMS:

// GROCERY ADD ITEM:

class AppAddGroceryItemLoadingState extends AppStates{}

class AppAddGroceryItemSuccessState extends AppStates{}

class AppAddGroceryItemErrorState extends AppStates{}


// GROCERY REMOVE ITEM:

class AppRemoveGroceryItemLoadingState extends AppStates{}

class AppRemoveGroceryItemSuccessState extends AppStates{}

class AppRemoveGroceryItemErrorState extends AppStates{}

// GROCERY CHECK ITEM:

class AppCheckGroceryItemLoadingState extends AppStates{}

class AppCheckGroceryItemSuccessState extends AppStates{}

class AppCheckGroceryItemErrorState extends AppStates{}


// SEARCH FOR ITEM:

class AppSearchLoadingState extends AppStates{}

class AppSearchSuccessState extends AppStates{}

class AppSearchErrorState extends AppStates{}


// ADD TO FAVOURITES:

class AppEditFavouritesLoadingState extends AppStates{}

class AppEditFavouritesSuccessState extends AppStates{}

class AppEditFavouritesErrorState extends AppStates{}


// REMOVE FROM FAVOURITES:

class AppIsInFavouritesState extends AppStates{}
