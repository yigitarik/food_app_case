# food_mood

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Framework Choice

I chose Flutter as the platform on which I will develop the application. The reason for this is that Flutter is faster and more comfortable than other cross-platforms. For example, the hot reload feature or the child-parent feature that allows us to code designs more easily. If we look at native languages, like every cross-platform technology, Flutter is inadequate at some points. The most important of these is the work we do on hardware. For example, unlike Native technologies, cross-platform technologies put various connections in the middle layer to communicate with the hardware, so at some points we may need to do Native development in order for the module or code we will develop to work. In this context, the direct communication of Native languages with the hardware also affects the running speed of the application to some extent. According to my research, the response times of buttons in native languages vary between 10-20 milliseconds, while in cross-platform technologies this figure is almost always above 150 milliseconds. Based on this information, I chose to use Flutter.


Within the application, we can navigate between three different pages with the navigation bar.

Views:

-Home
-Favorite Meals
-My Cart

The basic data of the images and foods on the pages comes from the API whose link is shared below. However, since some data did not come from the API, static or random data was used.

Static and Random data:

-Price information
-Product Description

Although the designs of Favorite Meals and My Cart are almost the same, they meet the features stated in the document.

Provider package was used as the State Management selection. Provider was preferred because it is easier and does not require detailed installation compared to other State Management packages. According to the research, it has been concluded that Provider is a good choice if a comprehensive application is not being developed.

The API used includes YouTube videos of the products. It is possible to watch these videos with the YouTube icon on the product detail page. The urlLauncher package was used to open these videos.

Shared Preferences package was preferred as Local Storage selection. Since the data does not directly require a database, the Shared Preferences package was considered suitable.

The CachedNetworkImage package, which is frequently used in Flutter, was used to display product images. This package provides benefits with the features it includes, such as error builder or placeholder builder.

Last used API connection link: https://www.themealdb.com/api.php
