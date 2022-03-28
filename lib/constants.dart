import 'package:flutter/material.dart';
import 'package:redditech/reddit_auth.dart';

const PrimaryColor = Color(0xFF0068C2);
const PrimaryLightColor = Color(0xFFFFFFFF);
const PrimaryBlack = Color(0xFF2D2D2D);

const Map<String, String> configAuthPierre =
{
  'redirectUri':    'reedditech://callback',
  'callbackScheme': 'reedditech',
  'userAgent':      'ReedditechApp',
  'clientId':       '_8uKpzEGXUYu6k8TAKyPNw',
};

const Map<String, String> configAuthMartin =
{
  'redirectUri': 'https://www.epitech.eu/',
  'userAgent':   'ReedditechApp',
  'clientId':    'nmj6ImA2zw2PUmXGpaVVSQ',
};

final RedditAuth redditAuth = new RedditAuth();

late Map<dynamic, dynamic>?  displayedSubJson;