import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import '../utils/form_utils.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String? _selectedRole;
  String? _selectedDepartment;
  String? _selectedStatus;
  bool _sendWelcomeEmail = true;
  bool _isLoading = false;

  final List<String> _roles = [
    'Yönetici',
    'Muhasebeci',
    'Satış Temsilcisi',
    'İnsan Kaynakları',
    'IT Uzmanı',
    'Genel Kullanıcı',
  ];

  final List<String> _departments = [
    'Genel Müdürlük',
    'Muhasebe',
    'Satış',
    'İnsan Kaynakları',
    'Bilgi İşlem',
    'Pazarlama',
    'Operasyon',
  ];

  final List<String> _statuses = ['Aktif', 'Pasif', 'Beklemede'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _buildAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            child: Column(children: [_buildPageHeader(), _buildFormCard()]),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 18,
          ),
        ),
      ),
      title: const Text(
        'Yeni Kullanıcı Ekle',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildPageHeader() {
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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Yeni Kullanıcı Oluştur',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sisteminize yeni bir kullanıcı ekleyin',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
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
    return Transform.translate(
      offset: const Offset(0, -24),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionTitle('👤 Kişisel Bilgiler'),
              ),
              const SizedBox(height: 24),

              // First name field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _firstNameController,
                  label: 'Ad',
                  hint: 'Kullanıcının adını girin',
                  icon: Icons.person_outline,
                  validator: (value) =>
                      FormValidators.validateName(value, 'Ad'),
                ),
              ),

              const SizedBox(height: 24),

              // Last name field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _lastNameController,
                  label: 'Soyad',
                  hint: 'Kullanıcının soyadını girin',
                  icon: Icons.person_outline,
                  validator: (value) =>
                      FormValidators.validateName(value, 'Soyad'),
                ),
              ),

              const SizedBox(height: 24),

              // Email field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _emailController,
                  label: 'E-posta Adresi',
                  hint: 'ornek@email.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.validateEmail,
                ),
              ),

              const SizedBox(height: 24),

              // Phone field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _phoneController,
                  label: 'Telefon Numarası',
                  hint: '0 (5XX) XXX XX XX',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                    PhoneNumberFormatter(),
                  ],
                  validator: FormValidators.validatePhone,
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionTitle('🏢 Organizasyon Bilgileri'),
              ),
              const SizedBox(height: 24),

              // Role dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomDropdown(
                  value: _selectedRole,
                  label: 'Rol',
                  hint: 'Kullanıcı rolü seçin',
                  icon: Icons.work_outline,
                  items: _roles,
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'Rol'),
                ),
              ),

              const SizedBox(height: 24),

              // Department dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomDropdown(
                  value: _selectedDepartment,
                  label: 'Departman',
                  hint: 'Departman seçin',
                  icon: Icons.business_outlined,
                  items: _departments,
                  onChanged: (value) {
                    setState(() {
                      _selectedDepartment = value;
                    });
                  },
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'Departman'),
                ),
              ),

              const SizedBox(height: 24),

              // Status dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomDropdown(
                  value: _selectedStatus,
                  label: 'Durum',
                  hint: 'Kullanıcı durumu seçin',
                  icon: Icons.toggle_on_outlined,
                  items: _statuses,
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'Durum'),
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionTitle('🔒 Güvenlik Bilgileri'),
              ),
              const SizedBox(height: 24),

              // Password fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomPasswordField(
                  controller: _passwordController,
                  label: 'Şifre',
                  hint: 'Güçlü bir şifre oluşturun',
                  validator: FormValidators.validatePassword,
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomPasswordField(
                  controller: _confirmPasswordController,
                  label: 'Şifre Tekrarı',
                  hint: 'Şifreyi tekrar girin',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre tekrarı zorunludur';
                    }
                    if (value != _passwordController.text) {
                      return 'Şifreler eşleşmiyor';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionTitle('⚙️ Ek Ayarlar'),
              ),
              const SizedBox(height: 16),

              // Welcome email switch
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomSwitchTile(
                  title: 'Hoş Geldin E-postası Gönder',
                  subtitle:
                      'Kullanıcıya hesap bilgilerini içeren e-posta gönderilsin',
                  value: _sendWelcomeEmail,
                  onChanged: (value) {
                    setState(() {
                      _sendWelcomeEmail = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 40),

              // Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildActionButtons(),
              ),

              const SizedBox(height: 40), // Bottom spacing
            ],
          ),
        ),
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
            onPressed: _isLoading ? null : _saveUser,
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
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Kullanıcı Ekle',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  '${_firstNameController.text} ${_lastNameController.text} başarıyla eklendi!',
                ),
              ],
            ),
            backgroundColor: Colors.green[600],
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(16),
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Navigate back
        Navigator.of(context).pop(true);
      }
    }
  }
}

// Custom phone number formatter
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    String formatted = '';
    if (text.isNotEmpty) {
      if (text.length >= 1) {
        formatted += text.substring(0, 1);
      }
      if (text.length >= 4) {
        formatted += ' (${text.substring(1, 4)})';
      } else if (text.length > 1) {
        formatted += ' (${text.substring(1)}';
      }
      if (text.length >= 7) {
        formatted += ' ${text.substring(4, 7)}';
      } else if (text.length > 4) {
        formatted += ' ${text.substring(4)}';
      }
      if (text.length >= 9) {
        formatted += ' ${text.substring(7, 9)}';
      } else if (text.length > 7) {
        formatted += ' ${text.substring(7)}';
      }
      if (text.length >= 11) {
        formatted += ' ${text.substring(9, 11)}';
      } else if (text.length > 9) {
        formatted += ' ${text.substring(9)}';
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
