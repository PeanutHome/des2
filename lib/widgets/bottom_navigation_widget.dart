import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  final Color primaryBackground;
  final Color accentGold;
  final Color brightGold;
  final Color textGrey;
  final int selectedIndex;
  final Function(int) onNavigationTap;

  const BottomNavigationWidget({
    super.key,
    required this.primaryBackground,
    required this.accentGold,
    required this.brightGold,
    required this.textGrey,
    required this.selectedIndex,
    required this.onNavigationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: primaryBackground,
        border: Border(
          top: BorderSide(color: accentGold.withOpacity(0.3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'ပင်မစာမျက်နှာ', 0),
          _buildNavItem(Icons.casino, 'ထီထိုး', 1),
          _buildNavItem(Icons.history, 'မှတ်တမ်း', 2),
          _buildNavItem(Icons.settings, 'ဆက်တင်များ', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onNavigationTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? brightGold : textGrey,
            size: 22,
          ),
          const SizedBox(height: 3),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? brightGold : textGrey,
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
