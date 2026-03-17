import 'package:flutter/material.dart';

class GiftScreen extends StatelessWidget {
  const GiftScreen({super.key});

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
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bán chạy nhất",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildGiftCard(
                            imagePath: 'assets/images/qt1.jpg',
                            title: "VÉ SUPER PLEX",
                            expiry: "Hạn sử dụng | 12 tháng",
                            price: "150.000 đ",
                          ),
                          const SizedBox(height: 16),
                          _buildGiftCard(
                            imagePath: 'assets/images/qt2.jpg',
                            title: "VÉ CHARLOTTE",
                            expiry: "Hạn sử dụng | 12 tháng",
                            price: "370.000 đ",
                          ),
                          const SizedBox(height: 16),
                          _buildGiftCard(
                            imagePath: 'assets/images/qt3.jpg',
                            title: "VÉ QUÀ TẶNG",
                            expiry: "Hạn sử dụng | 12 tháng",
                            price: "100.000 đ",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: const Color(0xFFE51937),
      padding: const EdgeInsets.only(top: 40, bottom: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Quà tặng",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildGiftCard({
    required String imagePath,
    required String title,
    required String expiry,
    required String price,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container with Padding
          Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              height: 140, // Fixed height for the image to make it look smaller
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 140,
                  color: Colors.grey[100],
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                );
              },
            ),
          ),
          // Info Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE51937),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  expiry,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
