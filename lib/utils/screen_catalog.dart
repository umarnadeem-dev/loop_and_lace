import 'package:flutter/material.dart';

enum AppRole { customer, vendor, admin }

class ScreenInfo {
  final int number;
  final String title;
  final String roleText;
  final AppRole role;
  final String description;
  final Widget Function(BuildContext) builder;

  ScreenInfo({
    required this.number,
    required this.title,
    required this.roleText,
    required this.role,
    required this.description,
    required this.builder,
  });
}
