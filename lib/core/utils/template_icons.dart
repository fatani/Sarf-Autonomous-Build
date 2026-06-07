import 'package:flutter/material.dart';

IconData templateIcon(String iconName) {
  return switch (iconName) {
    'movie' => Icons.movie_outlined,
    'music_note' => Icons.music_note_outlined,
    'phone_iphone' => Icons.phone_iphone_outlined,
    'signal_cellular_alt' => Icons.signal_cellular_alt,
    'wifi' => Icons.wifi,
    'bolt' => Icons.bolt_outlined,
    'water_drop' => Icons.water_drop_outlined,
    'home' => Icons.home_outlined,
    'directions_car' => Icons.directions_car_outlined,
    'fitness_center' => Icons.fitness_center_outlined,
    'cloud' => Icons.cloud_outlined,
    'play_circle' => Icons.play_circle_outline,
    'shield' => Icons.shield_outlined,
    'router' => Icons.router_outlined,
    'school' => Icons.school_outlined,
    'work' => Icons.work_outline,
    'receipt_long' => Icons.receipt_long_outlined,
    _ => Icons.receipt_long_outlined,
  };
}
