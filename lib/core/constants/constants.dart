import 'package:flutter/material.dart';

class Constants {
  static const String apiUrl = "http://127.0.0.1:8000/api/v1/";
  static const String refreshTokenUrl = "${apiUrl}token/refresh/";
  static const String accountsUrl = "${apiUrl}accounts/";
  static const String followUrl = "${apiUrl}follow/";
  static const String musicUrl = "${apiUrl}music/";
  static const String searchUrl = "${apiUrl}search/";
  static const String playlistUrl = "${apiUrl}playlist/";
  static const String studioUrl = "${apiUrl}studio/";
  static const String podcastsUrl = "${apiUrl}podcasts/";

  //Storage
  static const String recordingDirectory = "Sonic/recordings/";

  //Characters
  static const String kEllipsis = ' . . .';
  static const String kLineSeparator = '\u2028';

  //Icons
  static const IconData settingsIcon = Icons.settings;
  static const IconData drawerIcon = Icons.toc_rounded;
  static const IconData searchIcon = Icons.search;

  //Error Messages
  static const String notEnoughPermission = "You don't have enough permission.";
  static const String loginRequired =
      "You Need to Login to complete this action.";
  static const String podcastCreated = "Podcast Created Successfully";
  static const String podcastDeleted = "Podcast Deleted Successfully";
  static const String connectionError = "A Network Problem Occurred";

  //SnackBar Duration

  static const Duration shortDuration = Duration(seconds: 3);
  static const Duration normalDuration = Duration(seconds: 4);
  static const Duration longDuration = Duration(seconds: 5);


  //Recording Constants
  static const double decibleLimit = -30;
  static const amplitudeCaptureRateInMilliSeconds = 100;

}
