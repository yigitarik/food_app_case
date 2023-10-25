import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_mood/controllers/category_controller.dart';
import 'package:food_mood/core/constants/colors.dart';
import 'package:food_mood/core/extensions/context_extensions.dart';
import 'package:food_mood/models/foodModels/meal_model.dart';
import 'package:food_mood/views/meal_detail_view.dart';
import 'package:food_mood/views/my_cart_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<CategoryController>()
        .getAllCategories(context: context, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var categoryController = Provider.of<CategoryController>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyCartView(),
                    ));
              },
              icon: const Icon(Icons.shopping_basket_outlined))
        ],
      ),
      body: categoryController.tabController == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: context.dynamicHeight(0.2),
                    excludeHeaderSemantics: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        padding:
                            EdgeInsets.only(left: context.dynamicWidth(0.04)),
                        height: context.dynamicHeight(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Delicious\nfood for you',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 34),
                            ),
                            TabBar(
                                labelStyle: const TextStyle(fontSize: 11),
                                labelColor: Colors.black,
                                labelPadding: const EdgeInsets.all(0),
                                isScrollable: true,
                                controller: categoryController.tabController,
                                tabs: List.generate(
                                    categoryController
                                        .categoryListModel.categories!.length,
                                    (index) => Tab(
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              categoryController
                                                  .categoryListModel
                                                  .categories![index]
                                                  .strCategory!,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: categoryController
                                                              .tabController!
                                                              .index ==
                                                          index
                                                      ? AppColors.primaryColor
                                                      : const Color.fromRGBO(
                                                          154, 154, 157, 1)),
                                            ),
                                          ),
                                        )))
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                  controller: categoryController.tabController,
                  children: List.generate(
                    categoryController.categoryListModel.categories!.length,
                    (index) => categoryController.mealListModel.meals == null
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 9 / 12,
                                    crossAxisCount: 2),
                            itemCount:
                                categoryController.mealListModel.meals.length,
                            itemBuilder: (context, index) {
                              return categoryController
                                      .mealListModel.meals.isEmpty
                                  ? SizedBox(
                                      width: 200.0,
                                      height: 100.0,
                                      child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          enabled: true,
                                          child: Container(
                                            margin: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 10,
                                                    blurRadius: 12,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ]),
                                          )),
                                    )
                                  : _buildMealCard(categoryController
                                      .mealListModel.meals[index]);
                            }),
                  ))),
    );
  }

  _buildMealCard(Meals meal) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailView(meal: meal),
            ));
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 10,
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 22),
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                // color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: meal.strMealThumb.toString(),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              meal.strMeal.toString(),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              "\$${Random().nextInt(50).toString()}",
              style: const TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
