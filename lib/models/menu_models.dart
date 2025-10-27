import 'package:flutter/material.dart';

enum MenuItem {
  anasayfa,
  uygulamalar,
  firmalarim,
  kullanicilarim,
  profil,
  aboneliklerim,
  talepDestek,
}

class MenuData {
  final MenuItem menuItem;
  final IconData icon;
  final IconData selectedIcon;
  final String title;
  final String id;
  final bool isMainNavItem;
  final bool isSubItem;

  const MenuData({
    required this.menuItem,
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.id,
    this.isMainNavItem = false,
    this.isSubItem = false,
  });
}

class MenuConfig {
  static const List<MenuData> menuItems = [
    MenuData(
      menuItem: MenuItem.anasayfa,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      title: 'Anasayfa',
      id: 'anasayfa',
      isMainNavItem: true,
    ),
    MenuData(
      menuItem: MenuItem.uygulamalar,
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view,
      title: 'Uygulamalar',
      id: 'uygulamalar',
      isMainNavItem: true,
    ),
    MenuData(
      menuItem: MenuItem.firmalarim,
      icon: Icons.business_outlined,
      selectedIcon: Icons.business,
      title: 'Firmalarım',
      id: 'firmalarim',
      isMainNavItem: true,
      isSubItem: true,
    ),
    MenuData(
      menuItem: MenuItem.kullanicilarim,
      icon: Icons.people_outline,
      selectedIcon: Icons.people,
      title: 'Kullanıcılarım',
      id: 'kullanicilarim',
      isMainNavItem: true,
      isSubItem: true,
    ),
    MenuData(
      menuItem: MenuItem.profil,
      icon: Icons.account_circle_outlined,
      selectedIcon: Icons.account_circle,
      title: 'Profil',
      id: 'profil',
      isMainNavItem: true,
    ),
    MenuData(
      menuItem: MenuItem.aboneliklerim,
      icon: Icons.account_circle_outlined,
      selectedIcon: Icons.account_circle,
      title: 'Aboneliklerim',
      id: 'aboneliklerim',
      isSubItem: true,
    ),
    MenuData(
      menuItem: MenuItem.talepDestek,
      icon: Icons.headset_mic_outlined,
      selectedIcon: Icons.headset_mic,
      title: 'Talep ve Destek',
      id: 'talep-destek',
      isSubItem: true,
    ),
  ];

  static List<MenuData> get mainNavItems =>
      menuItems.where((item) => item.isMainNavItem).toList();

  static List<MenuData> get drawerItems => menuItems;

  static List<MenuData> get subItems =>
      menuItems.where((item) => item.isSubItem).toList();

  static MenuData? getMenuDataById(String id) {
    return menuItems.cast<MenuData?>().firstWhere(
      (item) => item?.id == id,
      orElse: () => null,
    );
  }

  static MenuItem? getMenuItemById(String id) {
    final menuData = getMenuDataById(id);
    return menuData?.menuItem;
  }
}
