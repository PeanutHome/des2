import 'package:flutter/material.dart';

class TodayScheduleWidget extends StatelessWidget {
  final Color accentGold;
  final Color brightGold;
  final Color primaryBackground;
  final Color textWhite;
  final Color textGrey;

  const TodayScheduleWidget({
    super.key,
    required this.accentGold,
    required this.brightGold,
    required this.primaryBackground,
    required this.textWhite,
    required this.textGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentGold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'ဒီနေ့ ထီထုတ်ချိန်များ',
                  style: TextStyle(
                    color: textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: brightGold,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'ဒီနေ့',
                  style: TextStyle(
                    color: textWhite,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildScheduleGrid(),
          const SizedBox(height: 12),
          _buildInfoSection(),
        ],
      ),
    );
  }

  Widget _buildScheduleGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 2.4,
      children: [
        _buildScheduleCard('11:00', 'ထီထုတ်', '2D, 3D', Icons.schedule),
        _buildScheduleCard('12:00', 'ထီထုတ်', '2D, 3D', Icons.schedule),
        _buildScheduleCard('15:00', 'ထီထုတ်', '2D, 3D', Icons.schedule),
        _buildScheduleCard('16:30', 'ထီထုတ်', '2D, 3D', Icons.schedule),
      ],
    );
  }

  Widget _buildScheduleCard(String time, String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentGold.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: brightGold,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                time,
                style: TextStyle(
                  color: brightGold,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: textWhite,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: textGrey,
              fontSize: 10,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: brightGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: brightGold.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: brightGold,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.info_outline,
              color: textWhite,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ထီထုတ်ချိန်များ',
                  style: TextStyle(
                    color: textWhite,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'ထီထုတ်ချိန်များကို သတိထားပြီး ထီထိုးပါ',
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
