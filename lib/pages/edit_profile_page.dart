import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_text_field.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _positionController;
  late TextEditingController _locationController;

  String? _selectedDepartment;
  bool _isLoading = false;

  final List<String> _departments = [
    'Genel Müdürlük',
    'Bilgi İşlem',
    'Muhasebe',
    'Satış',
    'İnsan Kaynakları',
    'Pazarlama',
    'Operasyon',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _phoneController = TextEditingController(text: widget.userData['phone']);
    _positionController = TextEditingController(
      text: widget.userData['position'],
    );
    _locationController = TextEditingController(
      text: widget.userData['location'],
    );
    _selectedDepartment = widget.userData['department'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1976D2),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              _buildPageHeader(),
              Container(
                color: const Color(0xFFF8F9FA),
                child: _buildFormCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,

      title: const Text(
        'Profil Düzenle',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
    );
  }

  Widget _buildPageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      decoration: const BoxDecoration(color: Color(0xFF1976D2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profil Bilgilerini Düzenle',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Kişisel Bilgilerinizi Güncelleyin',
                      style: TextStyle(
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
                      child: const Text(
                        'Profil bilgilerinizi güncel tutun',
                        style: TextStyle(
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

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),

            // Profile Avatar Section
            _buildAvatarSection(),

            const SizedBox(height: 32),

            // Personal Information Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildSectionTitle('👤 Kişisel Bilgiler'),
            ),
            const SizedBox(height: 24),

            // Name field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextField(
                controller: _nameController,
                label: 'Ad Soyad',
                hint: 'Adınızı ve soyadınızı girin',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ad soyad zorunludur';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 24),

            // Email field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextField(
                controller: _emailController,
                label: 'E-posta',
                hint: 'E-posta adresinizi girin',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-posta zorunludur';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Geçerli bir e-posta adresi girin';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 24),

            // Phone field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextField(
                controller: _phoneController,
                label: 'Telefon',
                hint: 'Telefon numaranızı girin',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telefon numarası zorunludur';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 32),

            // Work Information Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildSectionTitle('🏢 İş Bilgileri'),
            ),
            const SizedBox(height: 24),

            // Position field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextField(
                controller: _positionController,
                label: 'Pozisyon',
                hint: 'İş pozisyonunuzu girin',
                icon: Icons.work_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pozisyon zorunludur';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 24),

            // Department dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DropdownButtonFormField<String>(
                value: _selectedDepartment,
                decoration: InputDecoration(
                  labelText: 'Departman',
                  hintText: 'Departmanınızı seçin',
                  prefixIcon: const Icon(Icons.business_center_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1976D2)),
                  ),
                ),
                items: _departments.map((department) {
                  return DropdownMenuItem(
                    value: department,
                    child: Text(department),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartment = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Departman seçimi zorunludur';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 24),

            // Location field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextField(
                controller: _locationController,
                label: 'Konum',
                hint: 'Bulunduğunuz şehri girin',
                icon: Icons.location_on_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konum zorunludur';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 40),

            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildActionButtons(),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF1976D2), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 47,
                  backgroundColor: Colors.grey[100],
                  child: widget.userData['avatar'] != null
                      ? ClipOval(
                          child: Image.network(
                            widget.userData['avatar'],
                            width: 94,
                            height: 94,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.person, size: 50, color: Colors.grey[400]),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: _changeProfilePicture,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _changeProfilePicture,
            child: const Text(
              'Profil Fotoğrafını Değiştir',
              style: TextStyle(
                color: Color(0xFF1976D2),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[400]!),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'İptal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              elevation: 4,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Kaydet',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ],
    );
  }

  void _changeProfilePicture() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.camera_alt, color: Colors.white),
            SizedBox(width: 12),
            Text('Profil fotoğrafı değiştirme özelliği eklenecek...'),
          ],
        ),
        backgroundColor: Color(0xFF1976D2),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Create updated user data
    final updatedUserData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'position': _positionController.text,
      'department': _selectedDepartment,
      'location': _locationController.text,
      'company': widget.userData['company'], // Keep existing
      'joinDate': widget.userData['joinDate'], // Keep existing
      'avatar': widget.userData['avatar'], // Keep existing
    };

    setState(() {
      _isLoading = false;
    });

    // Return updated data to previous screen
    Navigator.of(context).pop(updatedUserData);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Profil bilgileri başarıyla güncellendi!'),
          ],
        ),
        backgroundColor: Color(0xFF4CAF50),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
