import 'package:flutter/material.dart';
import 'package:melody/utils.dart';

class TabData {
  const TabData({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.delayKey,
    required this.selected,
  });
  final String id;
  final String title;
  final String icon;
  final Color color;
  final String delayKey;
  final bool selected;

  copyWith({required bool selected}) {
    return TabData(
      id: id,
      title: title,
      icon: icon,
      color: color,
      delayKey: delayKey,
      selected: selected,
    );
  }
}

List<TabData> tabsData = [
  TabData(
    id: '1',
    title: 'Focus',
    icon: 'assets/icons/focus.svg',
    color: ColorLib.secondary,
    delayKey: 'tab1',
    selected: true,
  ),
  TabData(
    id: '2',
    title: 'Relax',
    icon: 'assets/icons/relax.svg',
    color: ColorLib.secondary,
    delayKey: 'tab2',
    selected: false,
  ),
  TabData(
    id: '3',
    title: 'Sleep',
    icon: 'assets/icons/sleep.svg',
    color: ColorLib.secondary,
    delayKey: 'tab3',
    selected: false,
  ),
];
