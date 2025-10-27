import 'package:flutter/material.dart';
import 'models/menu_models.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'pages/home_page.dart';
import 'pages/applications_page.dart';
import 'pages/users_page.dart';
import 'pages/add_user_page.dart';
import 'pages/companies_page.dart';
import 'pages/add_company_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const MyNSoftApp());
}

class MyNSoftApp extends StatelessWidget {
  const MyNSoftApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MYNSOFT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1976D2),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
          primary: const Color(0xFF1976D2),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  MenuItem selectedMenuItem = MenuItem.anasayfa;

  void _selectMenuItem(MenuItem menuItem) {
    setState(() {
      selectedMenuItem = menuItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedMenuItem == MenuItem.anasayfa,
      onPopInvoked: (didPop) {
        // Eğer anasayfa değilse, anasayfaya dön
        if (!didPop && selectedMenuItem != MenuItem.anasayfa) {
          setState(() {
            selectedMenuItem = MenuItem.anasayfa;
          });
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: CustomDrawer(
          selectedMenuItem: selectedMenuItem,
          onMenuItemSelected: _selectMenuItem,
        ),
        body: _getBodyWidget(),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenuItem: selectedMenuItem,
          onMenuItemSelected: _selectMenuItem,
        ),
        floatingActionButton: _getFloatingActionButton(),
      ),
    );
  }

  Widget _getBodyWidget() {
    switch (selectedMenuItem) {
      case MenuItem.anasayfa:
        return HomePage(selectedMenuItem: selectedMenuItem);
      case MenuItem.uygulamalar:
        return const ApplicationsPage();
      case MenuItem.firmalarim:
        return const CompaniesPageBody();
      case MenuItem.kullanicilarim:
        return const UsersPageBody();
      case MenuItem.profil:
        return const ProfilePage();
      default:
        return HomePage(selectedMenuItem: selectedMenuItem);
    }
  }

  Widget? _getFloatingActionButton() {
    if (selectedMenuItem == MenuItem.kullanicilarim) {
      return FloatingActionButton.extended(
        onPressed: _navigateToAddUser,
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.person_add, size: 24),
        label: const Text(
          'Yeni Kullanıcı',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      );
    } else if (selectedMenuItem == MenuItem.firmalarim) {
      return FloatingActionButton.extended(
        onPressed: _navigateToAddCompany,
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.business_center, size: 24),
        label: const Text(
          'Yeni Firma',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      );
    }
    return null;
  }

  void _navigateToAddUser() async {
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const AddUserPage()));

    // If user was added successfully, show a message or refresh data
    if (result == true) {
      // You can add refresh logic here if needed
    }
  }

  void _navigateToAddCompany() async {
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const AddCompanyPage()));

    // If company was added successfully, show a message or refresh data
    if (result == true) {
      // You can add refresh logic here if needed
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Row(
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'MY',
                  style: TextStyle(
                    color: Color(0xFF1976D2),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'NSOFT',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 8, minHeight: 8),
                ),
              ),
            ],
          ),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF1976D2),
            radius: 18,
            child: const Text(
              'U',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey[200], height: 1),
      ),
    );
  }
}
