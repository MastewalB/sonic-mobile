import 'package:flutter/material.dart';

class Constants {
  static const String apiUrl = "http://localhost:8000/api/v1/";
  static const String refreshTokenUrl = "${apiUrl}token/refresh/";
  static const String accountsUrl = "${apiUrl}accounts/";
  static const String signupUrl = "${accountsUrl}signup/";
  static const String loginUrl = "${accountsUrl}login/";
  static const String followUrl = "${apiUrl}follow/";
  static const String musicUrl = "${apiUrl}music/";
  static const String searchUrl = "${apiUrl}search/";
  static const String playlistUrl = "${apiUrl}playlist/";
  static const String studioUrl = "${apiUrl}studio/";
  static const String studioPodcastsUrl = "${apiUrl}studio/podcasts/";

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
  static const String emailVerificationRequired =
      "You need to verify your account.";
  static const String notFound = "Not Found";
  static const String serverError = "The Server Caught Fire";
  static const String podcastCreated = "Podcast Created Successfully";
  static const String podcastDeleted = "Podcast Deleted Successfully";
  static const String connectionError = "A Network Problem Occurred";
  static const String invalidEmailOrPassword = "You entered invalid email or password";


  //Hive Box Names
  static const String userProfileBoxName = "User";

  //SnackBar Duration

  static const Duration shortDuration = Duration(seconds: 3);
  static const Duration normalDuration = Duration(seconds: 4);
  static const Duration longDuration = Duration(seconds: 5);

  //Recording Constants
  static const double decibleLimit = -30;
  static const amplitudeCaptureRateInMilliSeconds = 100;

  //Color Constants
  static const primaryColor = Color(0xFF2697FF);
static const secondaryColor = Color(0xFF2A2D3E);
static const bgColor = Color(0xFF212332);
static const followerColor = Color.fromARGB(255, 104, 109, 112);
static const defaultPadding = 16.0;
}
