import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:travel_hour/blocs/ads_bloc.dart';
import 'package:travel_hour/blocs/notification_bloc.dart';
import 'package:travel_hour/pages/blogs.dart';
import 'package:travel_hour/pages/bookmark.dart';
import 'package:travel_hour/pages/explore.dart';
import 'package:travel_hour/pages/profile.dart';
import 'package:provider/provider.dart';
import 'package:travel_hour/pages/states.dart';
import 'package:travel_hour/services/app_service.dart';
import 'package:travel_hour/utils/snacbar.dart';
import 'package:easy_localization/easy_localization.dart';

import '../services/notification_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  PageController _pageController = PageController();

  List<IconData> iconList = [
    Feather.home,
    Feather.grid,
    Feather.list,
    Feather.bookmark,
    Feather.user
  ];


  void onTabTapped(int index) {
    setState(()=> _currentIndex = index);
   _pageController.animateToPage(index,
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 300)
    );
   
  }


  Future configureAds ()async{
    await context.read<AdsBloc>().initiateAdsOnApp();
    context.read<AdsBloc>().loadAds();
  }


  Future _initNotifications () async{
    await NotificationService().initFirebasePushNotification(context)
    .then((value)=> context.read<NotificationBloc>().checkPermission());
  }



 @override
  void initState() {
    super.initState();
    _initNotifications();
    AppService().checkInternet().then((hasInternet) {
      if (hasInternet == false) {
       openSnacbar(context, 'no internet'.tr());
      }
    });

    Future.delayed(Duration(milliseconds: 0))
    .then((_) async{
      await context.read<AdsBloc>().checkAdsEnable().then((isEnabled)async{
        if(isEnabled != null && isEnabled == true){
          debugPrint('ads enabled true');
          configureAds();      /* enable this line to enable ads on the app */
          
        }else{
          debugPrint('ads enabled false');
        }
      });

    });
  }
  


  @override
  void dispose() {
    _pageController.dispose();
    //context.read<AdsBloc>().dispose();
    super.dispose();
  }


  Future _onWillPop () async{
    if(_currentIndex != 0){
      setState (()=> _currentIndex = 0);
      _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }else{
      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', true);
    }
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _onWillPop(),
      child: Scaffold(
        appBar: AppBar(elevation: 0, toolbarHeight: 0),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeColor: Theme.of(context).primaryColor,
          gapLocation: GapLocation.none,
          activeIndex: _currentIndex,
          inactiveColor: Colors.grey[500],
          splashColor: Theme.of(context).primaryColor,
          //blurEffect: true,
          iconSize: 22,
          onTap: (index) => onTabTapped(index),
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),  
          children: <Widget>[
            Explore(),
            StatesPage(),
            BlogPage(),
            BookmarkPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
