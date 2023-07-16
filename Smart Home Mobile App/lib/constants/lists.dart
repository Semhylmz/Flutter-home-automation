import '../model/sensor_model.dart';
import 'package:flutter/material.dart';

List ledAnimationName = [
  'Rainbow ',
  'RainbowCycle ',
  'ColorWipe ',
  'TheaterChase ',
  'TheaterChaseRainbow '
];

List<SensorModel> smartDevices = <SensorModel>[
  SensorModel(
      title: 'Neopixel Led',
      path: 'Icons.lightbulb_outline_rounded',
      icon: Icons.blur_on_outlined),
  SensorModel(
      title: 'Temperature',
      path: 'Icons.thermostat_outlined',
      icon: Icons.thermostat_outlined),
  SensorModel(
      title: 'Lamp',
      path: 'Icons.graphic_eq_outlined',
      icon: Icons.lightbulb_outline_rounded),
  SensorModel(
      title: 'Motion Sensor',
      path: 'Icons.directions_walk_outlined',
      icon: Icons.directions_walk_outlined),
];
