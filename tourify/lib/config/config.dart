import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Config {

  final String appName = 'Tourify'; 
  final String mapAPIKey = 'AIzaSyCROa8LxAHmRY2k1lahWj5ESFvJjzRs_v4';
  final String countryName = 'World';
  final String splashIcon = 'assets/images/splash.png';
  final String supportEmail = 'phanghongwei@gmail.com';
  final String privacyPolicyUrl = 'https://www.mrb-lab.com/privacy-policy-of-travel-hour';
  final String iOSAppId = '000000';

  
  final String yourWebsiteUrl = 'https://github.com/hongwei169';
  final String facebookPageUrl = 'https://www.facebook.com/phang.hongwei.1';
  final String youtubeChannelUrl = 'https://www.youtube.com/channel/UCY6n5oB-bApIp0RCn5QViGg';

  
  // app theme color - primary color
  static final Color appThemeColor = Colors.blueAccent;

  //special two states name that has been already upload from the admin panel
  final String specialState1 = 'Central Denmark Region';
  final String specialState2 = 'Capital Region of Denmark';


  //relplace by your country lattitude & longitude
  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(23.777176,90.399452), //here
    zoom: 10,
  );

  
  //google maps marker icons
  final String hotelIcon = 'assets/images/hotel.png';
  final String restaurantIcon = 'assets/images/restaurant.png';
  final String hotelPinIcon = 'assets/images/hotel_pin.png';
  final String restaurantPinIcon = 'assets/images/restaurant_pin.png';
  final String drivingMarkerIcon = 'assets/images/driving_pin.png';
  final String destinationMarkerIcon = 'assets/images/destination_map_marker.png';

  
  
  //Intro images
  final String introImage1 = 'assets/images/travel6.png';
  final String introImage2 = 'assets/images/travel1.png';
  final String introImage3 = 'assets/images/travel5.png';

  
  //Language Setup
  final List<String> languages = [
    'English',
    'Spanish',
    'Chinese'
  ];

  static const String emptyImage = 'https://innov8tiv.com/wp-content/uploads/2017/10/blank-screen-google-play-store-1280x720.png';


}