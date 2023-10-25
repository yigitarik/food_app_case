import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_mood/core/constants/colors.dart';
import 'package:food_mood/core/extensions/context_extensions.dart';
import 'package:food_mood/main.dart';
import 'package:food_mood/models/foodModels/meal_list_model.dart';
import 'package:food_mood/views/meal_detail_view.dart';
import 'package:slideable/slideable.dart';

class MyFavoritesView extends StatefulWidget {
  const MyFavoritesView({super.key});

  @override
  State<MyFavoritesView> createState() => _MyFavoritesViewState();
}

class _MyFavoritesViewState extends State<MyFavoritesView> {
  MealListModel favoriteListModel = MealListModel(meals: []);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (preferencesService.containsKeyCheck(key: 'favorites')) {
      favoriteListModel = MealListModel.fromJson(
          jsonDecode(preferencesService.getStringValue(key: 'favorites')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          'Favorites',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: context.dynamicHeight(1),
        color: AppColors.bgColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'swipe on an item to delete',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              ListView.separated(
                  padding: const EdgeInsets.only(bottom: 100, top: 15),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: favoriteListModel.meals.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    int amount = 1;
                    return Slideable(
                      backgroundColor: Colors.transparent,
                      items: [
                        // ActionItems(
                        //   icon: Icon(
                        //       favoriteListModel.meals.any((element) =>
                        //               element.idMeal ==
                        //               favoriteListModel.meals[index].idMeal)
                        //           ? Icons.favorite
                        //           : Icons.favorite_border,
                        //       color: AppColors.primaryColor),
                        //   onPress: () {
                        //     setState(() {

                        //     });
                        //   },
                        //   backgroudColor: Colors.transparent,
                        // ),
                        ActionItems(
                          radius: BorderRadius.circular(30),
                          icon: const Icon(Icons.delete,
                              color: AppColors.primaryColor),
                          onPress: () {
                            setState(() {
                              favoriteListModel.meals.removeAt(index);

                              var jsonString =
                                  jsonEncode(favoriteListModel.toJson());
                              preferencesService.setStringValue(
                                  key: 'favorites', value: jsonString);
                            });
                          },
                          backgroudColor: Colors.transparent,
                        ),
                      ],
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MealDetailView(
                                    meal: favoriteListModel.meals[index]),
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.symmetric(
                              horizontal: context.dynamicWidth(0.04)),
                          height: context.dynamicHeight(0.15),
                          width: context.dynamicWidth(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: favoriteListModel
                                      .meals[index].strMealThumb
                                      .toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.scaleDown),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 30),
                                // height: 100,
                                width: 150,
                                child: ListTile(
                                  title: Text(
                                    favoriteListModel.meals[index].strMeal
                                        .toString(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    "\$${Random().nextInt(50).toString()}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  width: 52,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.cover,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (amount != 0) {
                                                  amount--;
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            )),
                                      ),
                                      Text(
                                        amount.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.cover,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                amount++;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
