import 'package:flutter/material.dart';

class CinemaScreen extends StatefulWidget {
  final Map<String, dynamic>? movie;
  const CinemaScreen({super.key, this.movie});

  @override
  State<CinemaScreen> createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  // --- CONSTANTS ---
  final Color primaryRed = const Color(0xFFE51937);
  final Color textSecondary = Colors.black38;
  final Color textPrimary = Colors.black;

  // --- MOCK DATA ---
  final Map<String, List<Map<String, dynamic>>> cinemasByRegion = {
    "Miền Bắc": [
      {"cinemaName": "TT Cinema Hà Đông"},
      {"cinemaName": "TT Cinema Cầu Giấy"},
      {"cinemaName": "TT Cinema Văn Quán"},
      {"cinemaName": "TT Cinema Phạm Ngọc Thạch"},
    ],
    "Miền Trung": [
      {"cinemaName": "TT Cinema Sơn Trà"},
      {"cinemaName": "TT Cinema Vinh"},
    ],
    "Miền Nam": [
      {"cinemaName": "TT Cinema Gò Vấp"},
      {"cinemaName": "TT Cinema Quận 7"},
      {"cinemaName": "TT Cinema Thủ Đức"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBarLocal(),
                Expanded(
                  child: _buildCinemaList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarLocal() {
    return Container(
      color: primaryRed,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    "Rạp",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCinemaList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      children: cinemasByRegion.entries.map((entry) {
        final regionName = entry.key;
        final cinemas = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Region Header
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: Text(
                regionName.toUpperCase(),
                style: TextStyle(
                  color: primaryRed,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            // Cinema names in this region
            ...cinemas.map((cinema) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                ),
                child: Text(
                  cinema["cinemaName"].toString().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }
}
