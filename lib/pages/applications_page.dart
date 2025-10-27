import 'package:flutter/material.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({Key? key}) : super(key: key);

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  final List<ApplicationData> applications = [
    ApplicationData(
      name: 'BIHESAP',
      subtitle: 'HERKES İÇİN',
      description: 'Ön Muhasebe Yazılımı',
      isNew: true,
      logoPath: 'assets/logos/bihesap.png', // Placeholder
      isFavorite: false,
    ),
    ApplicationData(
      name: 'BIFATURA',
      subtitle: 'HERKES İÇİN',
      description: 'e-Fatura ve e-Arşiv Fatura Yazılımı',
      isNew: true,
      logoPath: 'assets/logos/bifatura.png',
      isFavorite: false,
    ),
    ApplicationData(
      name: 'BİTİCARET',
      subtitle: 'E-TİCARET FİRMALARI İÇİN',
      description: 'Pazaryeri ve e-Ticaret Entegrasyon Yazılımı',
      isNew: true,
      logoPath: 'assets/logos/biticaret.png',
      isFavorite: false,
    ),
    ApplicationData(
      name: 'BİHR',
      subtitle: 'HERKES İÇİN',
      description: 'İnsan Kaynakları Yazılımı',
      isNew: true,
      logoPath: 'assets/logos/bihr.png',
      isFavorite: false,
    ),
    ApplicationData(
      name: 'BİCRM',
      subtitle: 'HERKES İÇİN',
      description: 'Müşteri Yönetim Yazılımı',
      isNew: true,
      logoPath: 'assets/logos/bicrm.png',
      isFavorite: false,
    ),
    ApplicationData(
      name: 'BİARŞİVFATURA',
      subtitle: 'GİB e-ARŞİV FİRMALARI İÇİN',
      description: 'Gib e-Arşiv Portal Yazılımı',
      isNew: true,
      logoPath: 'assets/logos/biarsivfatura.png',
      isFavorite: false,
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
                'Uygulamalar',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Page Title
          const Text(
            'Uygulamalar',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'İşinizi Kolaylaştıran Uygulamalarımızla Daha İleriye',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),

          const SizedBox(height: 32),

          // Applications Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 3;
              if (constraints.maxWidth < 900) crossAxisCount = 2;
              if (constraints.maxWidth < 600) crossAxisCount = 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.85,
                ),
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  return _buildApplicationCard(applications[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationCard(ApplicationData app) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with logo and favorite
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo placeholder
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Center(
                    child: Text(
                      app.name.substring(0, 2),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // New Badge
                if (app.isNew)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Yeni',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                // Favorite icon
                InkWell(
                  onTap: () {
                    setState(() {
                      app.isFavorite = !app.isFavorite;
                    });
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      app.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: app.isFavorite ? Colors.red : Colors.grey[400],
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App name
                  Text(
                    app.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Subtitle
                  Text(
                    app.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    app.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Subscribe button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showSubscriptionDialog(app);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 16),
                        const SizedBox(width: 8),
                        const Text(
                          'Aboneliği Satınal',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Try button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      _tryApplication(app);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow, size: 16),
                        const SizedBox(width: 8),
                        const Text(
                          'Hemen Dene',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSubscriptionDialog(ApplicationData app) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.green[600]),
              const SizedBox(width: 12),
              Text('${app.name} Aboneliği'),
            ],
          ),
          content: Text(
            '${app.name} uygulaması için abonelik satın almak istediğinizden emin misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal', style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _processPurchase(app);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Satın Al'),
            ),
          ],
        );
      },
    );
  }

  void _tryApplication(ApplicationData app) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.play_arrow, color: Colors.white),
            const SizedBox(width: 12),
            Text('${app.name} deneme sürümü başlatılıyor...'),
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

  void _processPurchase(ApplicationData app) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text('${app.name} aboneliği başarıyla satın alındı!'),
          ],
        ),
        backgroundColor: Colors.green[600],
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class ApplicationData {
  final String name;
  final String subtitle;
  final String description;
  final bool isNew;
  final String logoPath;
  bool isFavorite;

  ApplicationData({
    required this.name,
    required this.subtitle,
    required this.description,
    required this.isNew,
    required this.logoPath,
    required this.isFavorite,
  });
}
