import 'package:flutter/material.dart';
import '../models/menu_models.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        //deneme
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Row(
            children: [
              Icon(Icons.home, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 16, color: Colors.grey[400]),
              const SizedBox(width: 4),
              
            ],
          ),

          const SizedBox(height: 24),

         

          const SizedBox(height: 16),

          _buildDashboardCard(
            title: '30 Gün İçerisinde Süresi Sona Erecek Abonelikler',
            linkText: 'Tüm Abonelikleri İncele',
          ),

          const SizedBox(height: 16),

          _buildDashboardCard(
            title: 'Aktif Destek Talepleriniz',
            linkText: 'Tüm Destek Talepleri',
          ),

          const SizedBox(height: 24),

          // Responsive Row for Cards
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildDashboardCard(
                        title: 'Duyurular',
                        linkText: 'Tümünü Gör',
                        fixedHeight: 250,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDashboardCard(
                        title: 'Kampanyalar',
                        linkText: 'Tümünü Gör',
                        fixedHeight: 250,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildDashboardCard(
                      title: 'Duyurular',
                      linkText: 'Tümünü Gör',
                      fixedHeight: 250,
                    ),
                    const SizedBox(height: 16),
                    _buildDashboardCard(
                      title: 'Kampanyalar',
                      linkText: 'Tümünü Gör',
                      fixedHeight: 250,
                    ),
                  ],
                );
              }
            },
          ),

          // Extra padding at bottom for navbar
          const SizedBox(height: 24),
        ],
      ),
    );
  }

 



  Widget _buildDashboardCard({
    required String title,
    required String linkText,
    double? fixedHeight,
  }) {
    return Container(
      height: fixedHeight ?? 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  linkText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1976D2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 12),
                  Text(
                    'Henüz veri bulunmuyor',
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
