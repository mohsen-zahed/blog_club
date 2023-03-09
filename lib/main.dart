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
                  Image.asset(
                    'assets/img/icons/notification.png',
                    scale: 4,
                  ),
                ],
              ),
            ),
            HorizontalWidgetList(stories: stories),
          ],
        ),
      ),
    );
  }
}

class HorizontalWidgetList extends StatelessWidget {
  const HorizontalWidgetList({
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
                        padding: EdgeInsets.all(3),
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
