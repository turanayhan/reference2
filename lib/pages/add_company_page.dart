import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import '../utils/form_utils.dart';

class AddCompanyPage extends StatefulWidget {
  const AddCompanyPage({Key? key}) : super(key: key);

  @override
  State<AddCompanyPage> createState() => _AddCompanyPageState();
}

class _AddCompanyPageState extends State<AddCompanyPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _companyNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _websiteController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _foundedYearController = TextEditingController();
  final _employeeCountController = TextEditingController();

  // Animation controllers
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Form state
  String? _selectedSector;
  String? _selectedCompanyType;
  String? _selectedCity;
  String? _selectedCountry;
  bool _isActive = true;
  bool _isLoading = false;

  final List<String> _sectors = [
    'Teknoloji',
    'Perakende',
    'İnşaat',
    'Gıda',
    'Lojistik',
    'Otomotiv',
    'Tekstil',
    'Sağlık',
    'Eğitim',
    'Finans',
    'Turizm',
    'Medya',
    'Enerji',
    'Tarım',
    'Diğer',
  ];

  final List<String> _companyTypes = [
    'Anonim Şirket (A.Ş.)',
    'Limited Şirket (Ltd. Şti.)',
    'Kollektif Şirket',
    'Komandit Şirket',
    'Sermayesi Paylara Bölünmüş Komandit Şirket',
    'Kooperatif',
    'Şahıs Şirketi',
    'Şube',
    'İrtibat Bürosu',
  ];

  final List<String> _cities = [
    'İstanbul',
    'Ankara',
    'İzmir',
    'Bursa',
    'Antalya',
    'Adana',
    'Konya',
    'Gaziantep',
    'Mersin',
    'Diyarbakır',
    'Kayseri',
    'Eskişehir',
    'Samsun',
    'Denizli',
    'Şanlıurfa',
    'Adapazarı',
    'Malatya',
    'Kahramanmaraş',
    'Erzurum',
    'Van',
  ];

  final List<String> _countries = [
    'Türkiye',
    'Almanya',
    'Amerika Birleşik Devletleri',
    'İngiltere',
    'Fransa',
    'İtalya',
    'Hollanda',
    'Belçika',
    'İspanya',
    'Avusturya',
    'İsviçre',
    'Kanada',
    'Avustralya',
    'Japonya',
    'Güney Kore',
    'Singapur',
    'Birleşik Arap Emirlikleri',
    'Suudi Arabistan',
  ];

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

    // Set default values
    _selectedCountry = 'Türkiye';
  }

  @override
  void dispose() {
    _animationController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _taxNumberController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    _foundedYearController.dispose();
    _employeeCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                child: Column(children: [_buildPageHeader(), _buildFormCard()]),
              ),
            ),
          );
        },
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
        'Yeni Firma Ekle',
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
                  Icons.business_center,
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
                      'Yeni Firma Oluştur',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sisteminize yeni bir firma ekleyin',
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
                child: _buildSectionTitle('🏢 Temel Bilgiler'),
              ),
              const SizedBox(height: 24),

              // Company name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _companyNameController,
                  label: 'Firma Adı',
                  hint: 'Firma adını girin',
                  icon: Icons.business_outlined,
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'Firma adı'),
                ),
              ),

              const SizedBox(height: 24),

              // Email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _emailController,
                  label: 'E-posta',
                  hint: 'info@firma.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.validateEmail,
                ),
              ),

              const SizedBox(height: 24),

              // Phone
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _phoneController,
                  label: 'Telefon',
                  hint: '0212 555 0000',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [PhoneNumberFormatter()],
                  validator: FormValidators.validatePhone,
                ),
              ),

              const SizedBox(height: 24),

              // Sector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomDropdown(
                  value: _selectedSector,
                  label: 'Sektör',
                  hint: 'Firma sektörü seçin',
                  icon: Icons.category_outlined,
                  items: _sectors,
                  onChanged: (value) {
                    setState(() {
                      _selectedSector = value;
                    });
                  },
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'Sektör'),
                ),
              ),

              const SizedBox(height: 24),

              // Company type
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomDropdown(
                  value: _selectedCompanyType,
                  label: 'Şirket Türü',
                  hint: 'Şirket türü seçin',
                  icon: Icons.account_balance_outlined,
                  items: _companyTypes,
                  onChanged: (value) {
                    setState(() {
                      _selectedCompanyType = value;
                    });
                  },
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'Şirket türü'),
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionTitle('📍 Adres Bilgileri'),
              ),
              const SizedBox(height: 24),

              // Country
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomDropdown(
                  value: _selectedCountry,
                  label: 'Ülke',
                  hint: 'Ülke seçin',
                  icon: Icons.public_outlined,
                  items: _countries,
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value;
                    });
                  },
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'Ülke'),
                ),
              ),

              const SizedBox(height: 24),

              // City
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomDropdown(
                  value: _selectedCity,
                  label: 'Şehir',
                  hint: 'Şehir seçin',
                  icon: Icons.location_city_outlined,
                  items: _cities,
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  },
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'Şehir'),
                ),
              ),

              const SizedBox(height: 24),

              // Address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _addressController,
                  label: 'Adres',
                  hint: 'Detaylı adres bilgisi',
                  icon: Icons.location_on_outlined,
                  maxLines: 3,
                  validator: (value) =>
                      FormValidators.validateRequired(value, 'Adres'),
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionTitle('📄 Yasal Bilgiler'),
              ),
              const SizedBox(height: 24),

              // Tax number
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _taxNumberController,
                  label: 'Vergi Numarası',
                  hint: '1234567890',
                  icon: Icons.receipt_long_outlined,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vergi numarası zorunludur';
                    }
                    if (value.length != 10) {
                      return 'Vergi numarası 10 haneli olmalıdır';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Website
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _websiteController,
                  label: 'Website (Opsiyonel)',
                  hint: 'www.firma.com',
                  icon: Icons.language_outlined,
                  keyboardType: TextInputType.url,
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionTitle('📊 Firma Detayları'),
              ),
              const SizedBox(height: 24),

              // Founded year
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _foundedYearController,
                  label: 'Kuruluş Yılı',
                  hint: '2020',
                  icon: Icons.calendar_today_outlined,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kuruluş yılı zorunludur';
                    }
                    final year = int.tryParse(value);
                    if (year == null) {
                      return 'Geçerli bir yıl girin';
                    }
                    final currentYear = DateTime.now().year;
                    if (year < 1800 || year > currentYear) {
                      return 'Geçerli bir yıl aralığı girin';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Employee count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _employeeCountController,
                  label: 'Çalışan Sayısı',
                  hint: '50',
                  icon: Icons.people_outline,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Çalışan sayısı zorunludur';
                    }
                    final count = int.tryParse(value);
                    if (count == null || count < 1) {
                      return 'Geçerli bir çalışan sayısı girin';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _descriptionController,
                  label: 'Firma Açıklaması (Opsiyonel)',
                  hint: 'Firma hakkında kısa açıklama',
                  icon: Icons.description_outlined,
                  maxLines: 4,
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionTitle('⚙️ Firma Durumu'),
              ),
              const SizedBox(height: 16),

              // Status switch
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomSwitchTile(
                  title: 'Firma Aktif',
                  subtitle:
                      'Bu firmanın sistemde aktif olarak görünmesini istiyorsanız bu seçeneği açın',
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 40),

              // Action buttons
              Padding(
                padding: const EdgeInsets.all(24),
                child: _buildActionButtons(),
              ),
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
        fontSize: 20,
        fontWeight: FontWeight.bold,
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
            onPressed: _isLoading ? null : _saveCompany,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
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
                : const Text(
                    'Firma Oluştur',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ],
    );
  }

  void _saveCompany() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 12),
              Text('Lütfen tüm gerekli alanları doldurun'),
            ],
          ),
          backgroundColor: Colors.red[600],
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(Icons.check, color: Colors.green[600], size: 48),
              ),
              const SizedBox(height: 24),
              const Text(
                'Firma Başarıyla Oluşturuldu!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                '${_companyNameController.text} firması sisteme başarıyla eklendi.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(); // Go back to companies page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Firma Listesine Dön',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
