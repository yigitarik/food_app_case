import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_mood/controllers/category_controller.dart';
import 'package:food_mood/core/constants/colors.dart';
import 'package:food_mood/core/extensions/context_extensions.dart';
import 'package:food_mood/main.dart';
import 'package:food_mood/models/foodModels/meal_list_model.dart';
import 'package:food_mood/models/foodModels/meal_model.dart';
import 'package:food_mood/views/my_cart_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class MealDetailView extends StatefulWidget {
  Meals? meal;
  MealDetailView({super.key, this.meal});

  @override
  State<MealDetailView> createState() => _MealDetailViewState();
}

class _MealDetailViewState extends State<MealDetailView> {
  MealListModel mealListModel = MealListModel(meals: []);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<CategoryController>()
        .getMealVideo(context: context, mealId: widget.meal!.idMeal!);
    if (preferencesService.containsKeyCheck(key: 'favorites')) {
      mealListModel = MealListModel.fromJson(
          jsonDecode(preferencesService.getStringValue(key: 'favorites')));
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CategoryController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            controller.mealVideoLink = null;
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (preferencesService.containsKeyCheck(key: 'favorites')) {
                  if (mealListModel.meals.any(
                      (element) => element.idMeal == widget.meal!.idMeal)) {
                    mealListModel.meals.removeWhere(
                        (element) => element.idMeal == widget.meal!.idMeal);
                  } else {
                    mealListModel.meals.add(widget.meal!);
                  }
                } else {
                  mealListModel.meals.add(widget.meal!);
                  var jsonString = jsonEncode(mealListModel.toJson());
                  preferencesService.setStringValue(
                      key: 'favorites', value: jsonString);
                }
              });
            },
            icon: Icon(
                mealListModel.meals
                        .any((element) => element.idMeal == widget.meal!.idMeal)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: mealListModel.meals
                        .any((element) => element.idMeal == widget.meal!.idMeal)
                    ? Colors.red
                    : Colors.black),
          ),
          IconButton(
              onPressed: () {
                if (controller.mealVideoLink != null) {
                  print('object');
                  launchUrl(Uri.parse(controller.mealVideoLink!));
                }
              },
              icon: FaIcon(
                FontAwesomeIcons.youtube,
                color:
                    controller.mealVideoLink == null ? Colors.grey : Colors.red,
              )),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.04)),
        width: context.dynamicWidth(1),
        height: context.dynamicHeight(1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: context.dynamicHeight(0.4),
                width: context.dynamicWidth(0.4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 15,
                        blurRadius: 17,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: widget.meal!.strMealThumb!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.scaleDown),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                widget.meal!.strMeal!,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              Text(
                "\$${Random().nextInt(50).toString()}",
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "About",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          //  setState(() {
          //       if (preferencesService.containsKeyCheck(key: 'mycart')) {
          //         if (mealListModel.meals.any(
          //             (element) => element.idMeal == widget.meal!.idMeal)) {
          //           mealListModel.meals.removeWhere(
          //               (element) => element.idMeal == widget.meal!.idMeal);
          //         } else {
          //           mealListModel.meals.add(widget.meal!);
          //         }
          //       } else {
          //         mealListModel.meals.add(widget.meal!);
          //         var jsonString = jsonEncode(mealListModel.toJson());
          //         preferencesService.setStringValue(
          //             key: 'favorites', value: jsonString);
          //       }
          //     });
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyCartView(
                  meal: widget.meal,
                ),
              ));
        },
        child: Container(
          width: context.dynamicWidth(0.3),
          height: context.dynamicHeight(0.07),
          margin: EdgeInsets.symmetric(
              vertical: context.dynamicWidth(0.04),
              horizontal: context.dynamicWidth(0.15)),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(30)),
          child: const Center(
            child: Text(
              'Add To Basket',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
