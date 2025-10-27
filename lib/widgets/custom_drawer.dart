import 'package:flutter/material.dart';
import '../models/menu_models.dart';

class CustomDrawer extends StatefulWidget {
  final MenuItem selectedMenuItem;
  final Function(MenuItem) onMenuItemSelected;

  const CustomDrawer({
    Key? key,
    required this.selectedMenuItem,
    required this.onMenuItemSelected,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool expandedUserOperations = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1976D2),
                  const Color(0xFF1976D2).withOpacity(0.8),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'MY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'NSOFT',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Yönetim Paneli',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildMenuItem(MenuConfig.menuItems[0]), // Anasayfa
                _buildMenuItem(MenuConfig.menuItems[1]), // Uygulamalar

                const Divider(height: 24),

                // Kullanıcı İşlemleri Başlığı
                _buildExpandableSection(
                  title: 'KULLANICI İŞLEMLERİ',
                  isExpanded: expandedUserOperations,
                  onTap: () {
                    setState(() {
                      expandedUserOperations = !expandedUserOperations;
                    });
                  },
                ),

                if (expandedUserOperations) ...[
                  _buildMenuItem(MenuConfig.menuItems[2]), // Firmalarım
                  _buildMenuItem(MenuConfig.menuItems[3]), // Kullanıcılarım
                  _buildMenuItem(MenuConfig.menuItems[5]), // Aboneliklerim
                  _buildMenuItem(MenuConfig.menuItems[6]), // Talep ve Destek
                ],
              ],
            ),
          ),

          // Footer
          Column(
            children: [
              // Çıkış Yap Butonu
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red[600], size: 22),
                  title: Text(
                    'Çıkış Yap',
                    style: TextStyle(
                      color: Colors.red[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              // Versiyon Bilgisi
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Versiyon 1.0.0',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              size: 20,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(MenuData menuData) {
    final isSelected = widget.selectedMenuItem == menuData.menuItem;

    return Container(
      margin: EdgeInsets.only(
        left: menuData.isSubItem ? 24 : 8,
        right: 8,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1976D2).withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          menuData.icon,
          color: isSelected ? const Color(0xFF1976D2) : Colors.grey[700],
          size: 22,
        ),
        title: Text(
          menuData.title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF1976D2) : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 15,
          ),
        ),
        dense: true,
        contentPadding: EdgeInsets.only(
          left: menuData.isSubItem ? 12 : 16,
          right: 16,
        ),
        onTap: () {
          widget.onMenuItemSelected(menuData.menuItem);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.red[600], size: 24),
              const SizedBox(width: 12),
              const Text(
                'Çıkış Yap',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          content: const Text(
            'Uygulamadan çıkış yapmak istediğinizden emin misiniz?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              child: Text(
                'İptal',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
                Navigator.of(context).pop(); // Drawer'ı kapat
                // Burada çıkış işlemi yapılabilir
                // Örnek: Authentication service'e çıkış bilgisi gönder
                _performLogout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text(
                'Çıkış Yap',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    // Burada çıkış işlemleri yapılabilir:
    // - Kullanıcı oturumunu sonlandır
    // - Local storage'ı temizle
    // - API'ye logout request gönder
    // - Login sayfasına yönlendir

    // Şimdilik sadece bir snackbar göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Başarıyla çıkış yapıldı',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        backgroundColor: Colors.green[600],
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
