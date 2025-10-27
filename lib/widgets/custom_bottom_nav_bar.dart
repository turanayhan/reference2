import 'package:flutter/material.dart';
import '../models/menu_models.dart';

class CustomBottomNavBar extends StatelessWidget {
  final MenuItem selectedMenuItem;
  final Function(MenuItem) onMenuItemSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenuItem,
    required this.onMenuItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainNavItems = MenuConfig.mainNavItems;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: mainNavItems.asMap().entries.map((entry) {
              final index = entry.key;
              final menuData = entry.value;
              return _buildNavItem(menuData: menuData, index: index);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required MenuData menuData, required int index}) {
    final isSelected = selectedMenuItem == menuData.menuItem;

    return Expanded(
      child: InkWell(
        onTap: () {
          onMenuItemSelected(menuData.menuItem);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1976D2).withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isSelected ? menuData.selectedIcon : menuData.icon,
                      color: isSelected
                          ? const Color(0xFF1976D2)
                          : Colors.grey[600],
                      size: 26,
                    ),
                  ),
                  if (isSelected && menuData.menuItem == MenuItem.anasayfa)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1976D2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF1976D2)
                      : Colors.grey[600],
                ),
                child: Text(
                  menuData.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
