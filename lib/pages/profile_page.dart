import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // User data - normalde API'den gelir
  Map<String, dynamic> userData = {
    'name': 'Ahmet Yılmaz',
    'email': 'ahmet.yilmaz@example.com',
    'phone': '+90 532 123 45 67',
    'position': 'Sistem Yöneticisi',
    'department': 'Bilgi İşlem',
    'company': 'Teknoloji A.Ş.',
    'joinDate': '15 Mart 2020',
    'location': 'İstanbul, Türkiye',
    'avatar': null, // Profile picture URL
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [_buildProfileHeader(), _buildProfileContent()],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.white,
                  child: userData['avatar'] != null
                      ? ClipOval(
                          child: Image.network(
                            userData['avatar'],
                            width: 74,
                            height: 74,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.person, size: 40, color: Colors.grey[400]),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profil Bilgileri',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userData['name'],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${userData['position']} • ${userData['company']}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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

  Widget _buildProfileContent() {
    return Transform.translate(
      offset: const Offset(0, -24),
      child: Container(
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 32),
            _buildStatsSection(),
            _buildDivider(),
            _buildInfoSection(),
            _buildDivider(),
            _buildActionSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Kayıt Tarihi',
              userData['joinDate'],
              Icons.calendar_today,
              const Color(0xFF4CAF50),
            ),
          ),
          Container(width: 1, height: 60, color: Colors.grey[200]),
          Expanded(
            child: _buildStatItem(
              'Departman',
              userData['department'],
              Icons.business_center,
              const Color(0xFF2196F3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'İletişim Bilgileri',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoItem(
            Icons.email_outlined,
            'E-posta',
            userData['email'],
            const Color(0xFF1976D2),
          ),
          const SizedBox(height: 20),
          _buildInfoItem(
            Icons.phone_outlined,
            'Telefon',
            userData['phone'],
            const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 20),
          _buildInfoItem(
            Icons.location_on_outlined,
            'Konum',
            userData['location'],
            const Color(0xFFFF9800),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          _buildActionButton(
            'Profili Düzenle',
            Icons.edit_outlined,
            const Color(0xFF1976D2),
            _showEditProfile,
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            'Şifre Değiştir',
            Icons.lock_outline,
            const Color(0xFF4CAF50),
            _showChangePassword,
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            'Bildirim Ayarları',
            Icons.notifications_outlined,
            const Color(0xFFFF9800),
            _showNotificationSettings,
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            'Çıkış Yap',
            Icons.logout,
            const Color(0xFFE57373),
            _showLogoutDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      height: 1,
      color: Colors.grey[200],
    );
  }

  void _showEditProfile() async {
    final updatedUserData = await Navigator.of(context)
        .push<Map<String, dynamic>>(
          MaterialPageRoute(
            builder: (context) => EditProfilePage(userData: userData),
          ),
        );

    // If user data was updated, refresh the profile page
    if (updatedUserData != null) {
      setState(() {
        userData.addAll(updatedUserData);
      });
    }
  }

  void _showChangePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.lock, color: Colors.white),
            SizedBox(width: 12),
            Text('Şifre değiştirme sayfası açılacak...'),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showNotificationSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.notifications, color: Colors.white),
            SizedBox(width: 12),
            Text('Bildirim ayarları sayfası açılacak...'),
          ],
        ),
        backgroundColor: const Color(0xFFFF9800),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.logout, color: Color(0xFFE57373)),
              SizedBox(width: 12),
              Text('Çıkış Yap'),
            ],
          ),
          content: const Text(
            'Hesabınızdan çıkış yapmak istediğinizden emin misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal', style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE57373),
                foregroundColor: Colors.white,
              ),
              child: const Text('Çıkış Yap'),
            ),
          ],
        );
      },
    );
  }

  void _performLogout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Başarıyla çıkış yapıldı!'),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
    // Here you would typically navigate to login page
    // Navigator.of(context).pushReplacementNamed('/login');
  }
}
