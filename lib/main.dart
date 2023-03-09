import 'package:blog_club/constants/colors.dart';
import 'package:blog_club/constants/list.dart';
import 'package:blog_club/models/story_model.dart';
import 'package:blog_club/utilities/size_config.dart';
import 'package:blog_club/widgets/carousel/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('fa')],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: ((context, orientation) {
              SizeConfig().init(constraints, orientation);
              return const MyApp();
            }),
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Avenir';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Club Blog',
      theme: ThemeData(
        fontFamily: defaultFontFamily,
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline3: TextStyle(
            fontSize: SizeConfig.setSizeHorizontally(14),
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w500,
          ),
          headline5: TextStyle(
            fontFamily: defaultFontFamily,
            fontSize: SizeConfig.setSizeHorizontally(22),
            fontWeight: FontWeight.w600,
          ),
          bodyText1: TextStyle(
            fontSize: SizeConfig.setSizeHorizontally(13),
          ),
          bodyText2: TextStyle(
            fontSize: SizeConfig.setSizeHorizontally(18),
            fontWeight: FontWeight.w500,
            color: kwhiteColor,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                SizeConfig.setSizeHorizontally(25),
                SizeConfig.setSizeVertically(60),
                SizeConfig.setSizeHorizontally(25),
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Amir Mohsen',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        "Explore today's",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: SizeConfig.setSizeHorizontally(30),
                    height: SizeConfig.setSizeVertically(32),
                    child: Image.asset(
                      'assets/img/icons/notification.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            StoriesHorizontalWidgetList(stories: stories),
            CarouselSlider.builder(
              itemCount: posts.length,
              itemBuilder: (context, index, realIndex) => PostsHorizontalWidget(
                index: index,
                posts: posts,
                left: index == 0 ? 25 : 8,
                right: index == posts.length - 1 ? 25 : 8,
              ),
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                aspectRatio: 1.25,
                viewportFraction: 0.8,
                disableCenter: true,
                initialPage: 0,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                autoPlay: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostsHorizontalWidget extends StatelessWidget {
  const PostsHorizontalWidget({
    Key? key,
    required this.index,
    required this.posts,
    required this.left,
    required this.right,
  }) : super(key: key);

  final int index;
  final List<Map<String, dynamic>> posts;
  final double left;
  final double right;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          Positioned.fill(
            top: 100,
            right: 56,
            left: 56,
            bottom: 14,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kblackColor,
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.only(
                bottom: SizeConfig.setSizeVertically(16),
              ),
              foregroundDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(248, 22, 22, 49),
                    Color.fromARGB(205, 22, 22, 49),
                    Color.fromARGB(118, 34, 34, 74),
                    Color.fromARGB(34, 21, 21, 23),
                    Color.fromARGB(19, 21, 21, 23),
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  posts[index]['image'],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            bottom: SizeConfig.setSizeVertically(50),
            child: Text(
              posts[index]['text'],
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}

class StoriesHorizontalWidgetList extends StatelessWidget {
  const StoriesHorizontalWidgetList({
    Key? key,
    required this.stories,
  }) : super(key: key);
  final List<StoryModel> stories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.setSizeVertically(150),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0
                  ? SizeConfig.setSizeHorizontally(25)
                  : SizeConfig.setSizeHorizontally(10),
              SizeConfig.setSizeHorizontally(20),
              index == stories.length - 1
                  ? SizeConfig.setSizeHorizontally(25)
                  : 0,
              SizeConfig.setSizeHorizontally(10),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: SizeConfig.setSizeHorizontally(68),
                      height: SizeConfig.setSizeVertically(68),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff376AEd),
                            Color(0xff49B0E2),
                            Color(0xff9CECFB),
                          ],
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: Image.asset(
                            stories[index].getImage(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        stories[index].getIconFilePath(),
                        scale: 1.8,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.setSizeVertically(8),
                ),
                Text(
                  stories[index].getName(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
