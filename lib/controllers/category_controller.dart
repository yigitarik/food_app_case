import 'package:flutter/material.dart';
import 'package:food_mood/core/constants/api_constants.dart';
import 'package:food_mood/core/constants/api_headers.dart';
import 'package:food_mood/core/services/api_get_service.dart';
import 'package:food_mood/models/categoryModels/category_list_model.dart';
import 'package:food_mood/models/foodModels/meal_list_model.dart';

class CategoryController with ChangeNotifier {
  CategoryListModel categoryListModel = CategoryListModel();
  TabController? tabController;
  MealListModel mealListModel = MealListModel(meals: []);

  String? mealVideoLink;

  getAllCategories(
      {required BuildContext context, TickerProvider? vsync}) async {
    ApiGetService apiGetService = ApiGetService(
      context: context,
      headers: HeaderConstants.headersWithoutToken,
      baseUrl: ApiConstants.baseUrl,
      endPoint: ApiConstants.category,
    );
    var responseData = await apiGetService.sendRequest();

    categoryListModel = CategoryListModel.fromJson(responseData);
    tabController = TabController(
        length: categoryListModel.categories!.length, vsync: vsync!);

    // ignore: use_build_context_synchronously
    getMealByCategory(
        context: context,
        category:
            categoryListModel.categories![tabController!.index].strCategory!);
    tabController!.addListener(() {
      getMealByCategory(
          context: context,
          category:
              categoryListModel.categories![tabController!.index].strCategory!);
      notifyListeners();
    });
    notifyListeners();
  }

// filter.php?c=
  getMealByCategory(
      {required BuildContext context, required String category}) async {
    mealListModel = MealListModel(meals: []);
    notifyListeners();
    ApiGetService apiGetService = ApiGetService(
        context: context,
        headers: HeaderConstants.headersWithoutToken,
        baseUrl: ApiConstants.baseUrl,
        endPoint: "filter.php?c=$category");
    var responseData = await apiGetService.sendRequest();
    mealListModel = MealListModel.fromJson(responseData);
    notifyListeners();
  }

  getMealVideo({required BuildContext context, required String mealId}) async {
    mealVideoLink = null;
    ApiGetService apiGetService = ApiGetService(
        context: context,
        headers: HeaderConstants.headersWithoutToken,
        baseUrl: ApiConstants.baseUrl,
        endPoint: "lookup.php?i=$mealId");
    var responseData = await apiGetService.sendRequest();
    mealVideoLink = responseData['meals'][0]['strYoutube'];
    notifyListeners();
  }
}
