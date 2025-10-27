import 'package:flutter/material.dart';

class UsersPageBody extends StatefulWidget {
  const UsersPageBody({Key? key}) : super(key: key);

  @override
  State<UsersPageBody> createState() => _UsersPageBodyState();
}

class _UsersPageBodyState extends State<UsersPageBody> {
  final List<UserData> users = [
    UserData(
      email: 'aliyildirm@gmail.com',
      firstName: 'Ali',
      lastName: 'Yıldırım',
      phone: '5659886544',
      isActive: true,
    ),
    UserData(
      email: 'aliyildirm@gmail.com',
      firstName: 'Ali',
      lastName: 'Yıldırım',
      phone: '5659886541',
      isActive: false,
    ),
    UserData(
      email: 'mehmet.kaya@gmail.com',
      firstName: 'Mehmet',
      lastName: 'Kaya',
      phone: '5555551234',
      isActive: true,
    ),
    UserData(
      email: 'ayse.demir@gmail.com',
      firstName: 'Ayşe',
      lastName: 'Demir',
      phone: '5555555678',
      isActive: true,
    ),
    UserData(
      email: 'fatma.ozkan@gmail.com',
      firstName: 'Fatma',
      lastName: 'Özkan',
      phone: '5555559876',
      isActive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Row(
            children: [
              Icon(Icons.home, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 16, color: Colors.grey[400]),
              const SizedBox(width: 4),
              Text(
                'Kullanıcılarım',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Header with title only
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kullanıcılarım',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Uygulamaları Kullanabilecek Kullanıcı Listeniz',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Users List
          _buildUsersList(),
        ],
      ),
    );
  }

  Widget _buildUsersList() {
    // Desktop view - Table
    if (MediaQuery.of(context).size.width > 768) {
      return _buildDesktopTable();
    }
    // Mobile view - Cards
    else {
      return _buildMobileCards();
    }
  }

  Widget _buildDesktopTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 60), // For action buttons
                Expanded(
                  flex: 3,
                  child: Text(
                    'MAİL',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'AD',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'SOYAD',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'TELEFON',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'DURUM',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Table Rows
          ...users.asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: index == users.length - 1
                        ? Colors.transparent
                        : Colors.grey[200]!,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Action buttons
                  SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        _buildEditButton(user),
                        const SizedBox(width: 4),
                        _buildDeleteButton(user),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      user.email,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      user.firstName,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      user.lastName,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      user.phone,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(flex: 1, child: _buildStatusBadge(user.isActive)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMobileCards() {
    return Column(children: users.map((user) => _buildUserCard(user)).toList());
  }

  Widget _buildUserCard(UserData user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name and status
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  backgroundColor: const Color(0xFF1976D2),
                  radius: 24,
                  child: Text(
                    '${user.firstName[0]}${user.lastName[0]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Name and email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // Status badge
                _buildStatusBadge(user.isActive),
              ],
            ),

            const SizedBox(height: 16),

            // Phone number
            Row(
              children: [
                Icon(Icons.phone_outlined, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  user.phone,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _editUser(user),
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: const Text(
                      'Düzenle',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1976D2),
                      side: const BorderSide(color: Color(0xFF1976D2)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _deleteUser(user),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text(
                      'Sil',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red[600],
                      side: BorderSide(color: Colors.red[600]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton(UserData user) {
    return InkWell(
      onTap: () => _editUser(user),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFF1976D2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.edit, size: 14, color: Colors.white),
      ),
    );
  }

  Widget _buildDeleteButton(UserData user) {
    return InkWell(
      onTap: () => _deleteUser(user),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.red[600],
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.delete, size: 14, color: Colors.white),
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? 'AKTİF' : 'PASİF',
        style: TextStyle(
          color: isActive ? Colors.green[700] : Colors.red[700],
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _editUser(UserData user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.edit, color: Colors.white),
            const SizedBox(width: 12),
            Text('${user.firstName} ${user.lastName} düzenleniyor...'),
          ],
        ),
        backgroundColor: const Color(0xFF1976D2),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteUser(UserData user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.delete, color: Colors.red[600]),
              const SizedBox(width: 12),
              const Text('Kullanıcı Sil'),
            ],
          ),
          content: Text(
            '${user.firstName} ${user.lastName} kullanıcısını silmek istediğinizden emin misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal', style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  users.remove(user);
                });
                _showDeleteSuccess(user);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteSuccess(UserData user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text('${user.firstName} ${user.lastName} başarıyla silindi!'),
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

class UserData {
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final bool isActive;

  UserData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.isActive,
  });
}
