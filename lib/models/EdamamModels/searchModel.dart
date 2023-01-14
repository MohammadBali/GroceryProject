class SearchModel
{
  int? from;
  int? to;
  List<HitsModel>? hits=[];  //Number of hits

  SearchModel.fromJson(Map<String,dynamic>json)
  {
    from= json['from'];
    to= json['to'];

    if(json['hits']!=null)
      {
        json['hits'].forEach((element)
        {
          hits?.add(HitsModel.fromJson(element));
        });
      }
  }
}

class HitsModel
{
  RecipeModel? recipe;
  bool? isFavourite=false;  //Will Not Come From the API but it will be for Bookmarking

  HitsModel.fromJson(Map<String,dynamic>json)
  {
    if(json['recipe']!=null)
      {
        recipe= RecipeModel.fromJson(json['recipe']);
      }
  }

  HitsModel({required this.recipe, this.isFavourite});
}

class RecipeModel
{
  String? url; //Recipe URL
  String? label; //Recipe Name
  String? image; //Recipe Image
  List<String>? ingredientLines=[]; //Recipe Ingredients
  List<String>? mealType=[]; //Recipe Meal Type
  double? calories; //Recipe Calories
  double? totalTime; //Recipe Total Time to prepare

  RecipeModel.fromJson(Map<String,dynamic>json)
  {
    url= json['url'];
    label= json['label'];
    image= json['image'];

    if(json['ingredientLines'] !=null)
      {
        json['ingredientLines'].forEach((element)
        {
          ingredientLines?.add(element);
        });
      }

    if(json['mealType'] !=null)
    {
      json['mealType'].forEach((element)
      {
        mealType?.add(element);
      });
    }
    calories= json['calories'];
    totalTime= json['totalTime'];

  }
}