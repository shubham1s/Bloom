import 'package:BLOOM_BETA/example/lib/presentation/pages/custom_drawer.dart';
import 'package:BLOOM_BETA/example/lib/presentation/shared/app_colors.dart';
import 'package:BLOOM_BETA/features/user.dart';
import 'package:BLOOM_BETA/fitness_app/models/tabIcon_data.dart';
import 'package:BLOOM_BETA/fitness_app/traning/training_screen.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fintness_app_theme.dart';
import 'my_diary/my_diary_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );
  ScrollController _scrollController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isExpanded = true;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _isExpanded = _scrollController.hasClients &&
              _scrollController.offset < (200.0 - kToolbarHeight - 20);
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        drawerScrimColor: AppColors.primaryColor,
        key: scaffoldKey,
        appBar: new AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          brightness: Brightness.light,
          leading: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            icon: Icon(
              Icons.menu,
              color: _isExpanded ? Colors.black : Colors.black,
            ),
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
        drawer: CustomDrawer(),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    ));
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ProfileView();
                });
              });
            }
          },
        ),
      ],
    );
  }
}
