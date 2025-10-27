import 'package:flutter/material.dart';

class CompaniesPageBody extends StatefulWidget {
  const CompaniesPageBody({Key? key}) : super(key: key);

  @override
  State<CompaniesPageBody> createState() => _CompaniesPageBodyState();
}

class _CompaniesPageBodyState extends State<CompaniesPageBody> {
  final List<CompanyData> companies = [
    CompanyData(
      name: 'Teknoloji A.Ş.',
      email: 'info@teknoloji.com',
      phone: '02121234567',
      address: 'İstanbul, Türkiye',
      taxNumber: '1234567890',
      sector: 'Teknoloji',
      isActive: true,
      employeeCount: 150,
      foundedYear: 2010,
    ),
    CompanyData(
      name: 'Perakende Ltd.',
      email: 'iletisim@perakende.com',
      phone: '02129876543',
      address: 'Ankara, Türkiye',
      taxNumber: '0987654321',
      sector: 'Perakende',
      isActive: true,
      employeeCount: 85,
      foundedYear: 2015,
    ),
    CompanyData(
      name: 'İnşaat İnc.',
      email: 'info@insaat.com',
      phone: '02125551234',
      address: 'İzmir, Türkiye',
      taxNumber: '5555555555',
      sector: 'İnşaat',
      isActive: false,
      employeeCount: 45,
      foundedYear: 2018,
    ),
    CompanyData(
      name: 'Gıda San. ve Tic.',
      email: 'bilgi@gida.com',
      phone: '02167778899',
      address: 'Bursa, Türkiye',
      taxNumber: '7777777777',
      sector: 'Gıda',
      isActive: true,
      employeeCount: 120,
      foundedYear: 2012,
    ),
    CompanyData(
      name: 'Lojistik A.Ş.',
      email: 'contact@lojistik.com',
      phone: '02123334455',
      address: 'Adana, Türkiye',
      taxNumber: '3333333333',
      sector: 'Lojistik',
      isActive: false,
      employeeCount: 75,
      foundedYear: 2020,
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
                'Firmalarım',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Header with title and stats
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Firmalarım',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sisteme Kayıtlı Firma Listeniz',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              _buildStatsCards(),
            ],
          ),

          const SizedBox(height: 32),

          // Companies List
          _buildCompaniesList(),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    final activeCompanies = companies.where((c) => c.isActive).length;
    final totalEmployees = companies.fold<int>(
      0,
      (sum, c) => sum + c.employeeCount,
    );
    final sectors = companies.map((c) => c.sector).toSet().length;

    // Mobile responsive layout
    if (MediaQuery.of(context).size.width < 768) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Toplam Firma',
                  companies.length.toString(),
                  Icons.business,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Aktif Firma',
                  activeCompanies.toString(),
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Toplam Çalışan',
                  totalEmployees.toString(),
                  Icons.people,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Sektör Sayısı',
                  sectors.toString(),
                  Icons.category,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Desktop layout
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Toplam Firma',
            companies.length.toString(),
            Icons.business,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Aktif Firma',
            activeCompanies.toString(),
            Icons.check_circle,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Toplam Çalışan',
            totalEmployees.toString(),
            Icons.people,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Sektör Sayısı',
            sectors.toString(),
            Icons.category,
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          // Value
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCompaniesList() {
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
                    'FİRMA ADI',
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
                    'SEKTÖR',
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
                  flex: 2,
                  child: Text(
                    'ÇALIŞAN',
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
          ...companies.asMap().entries.map((entry) {
            final index = entry.key;
            final company = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: index == companies.length - 1
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
                        _buildEditButton(company),
                        const SizedBox(width: 4),
                        _buildDeleteButton(company),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      company.name,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      company.sector,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      company.phone,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${company.employeeCount} kişi',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(flex: 1, child: _buildStatusBadge(company.isActive)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMobileCards() {
    return Column(
      children: companies.map((company) => _buildCompanyCard(company)).toList(),
    );
  }

  Widget _buildCompanyCard(CompanyData company) {
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
            // Header with company name and status
            Row(
              children: [
                // Company logo/avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF1976D2),
                        const Color(0xFF1976D2).withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.business, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                // Company name and sector
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1976D2).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              company.sector,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status badge
                _buildStatusBadge(company.isActive),
              ],
            ),

            const SizedBox(height: 16),

            // Company details
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.email_outlined,
                    'E-posta',
                    company.email,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    Icons.phone_outlined,
                    'Telefon',
                    company.phone,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.location_on_outlined,
                    'Adres',
                    company.address,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    Icons.receipt_long_outlined,
                    'Vergi No',
                    company.taxNumber,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    Icons.people_outline,
                    'Çalışan',
                    '${company.employeeCount} kişi',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    Icons.calendar_today_outlined,
                    'Kuruluş',
                    company.foundedYear.toString(),
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
                    onPressed: () => _editCompany(company),
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
                    onPressed: () => _deleteCompany(company),
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

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildEditButton(CompanyData company) {
    return InkWell(
      onTap: () => _editCompany(company),
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

  Widget _buildDeleteButton(CompanyData company) {
    return InkWell(
      onTap: () => _deleteCompany(company),
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

  void _editCompany(CompanyData company) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.edit, color: Colors.white),
            const SizedBox(width: 12),
            Text('${company.name} düzenleniyor...'),
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

  void _deleteCompany(CompanyData company) {
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
              const Text('Firma Sil'),
            ],
          ),
          content: Text(
            '${company.name} firmasını silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.',
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
                  companies.remove(company);
                });
                _showDeleteSuccess(company);
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

  void _showDeleteSuccess(CompanyData company) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text('${company.name} başarıyla silindi!'),
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

class CompanyData {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String taxNumber;
  final String sector;
  final bool isActive;
  final int employeeCount;
  final int foundedYear;

  CompanyData({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.taxNumber,
    required this.sector,
    required this.isActive,
    required this.employeeCount,
    required this.foundedYear,
  });
}
