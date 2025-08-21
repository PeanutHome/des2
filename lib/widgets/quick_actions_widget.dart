import 'package:flutter/material.dart';

class QuickActionsWidget extends StatelessWidget {
  final Color accentGold;
  final Color brightGold;
  final Color textWhite;
  final Function(String) onBettingTap;

  const QuickActionsWidget({
    super.key,
    required this.accentGold,
    required this.brightGold,
    required this.textWhite,
    required this.onBettingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'အမြန်လုပ်ဆောင်ချက်များ',
            style: TextStyle(
              color: textWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  '2D ထီထိုး',
                  Icons.casino,
                  brightGold,
                  () => onBettingTap('2D'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(
                  '3D ထီထိုး',
                  Icons.casino_outlined,
                  accentGold,
                  () => onBettingTap('3D'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'ပိုက်ဆံအိတ်',
                  Icons.account_balance_wallet,
                  brightGold,
                  () {
                    print('=== WALLET BUTTON TAPPED ===');
                    print('Calling onBettingTap with: Wallet');
                    onBettingTap('Wallet');
                    print('=== END WALLET BUTTON ===');
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(
                  'ပရိုဖိုင်',
                  Icons.person,
                  accentGold,
                  () {
                    print('=== PROFILE BUTTON TAPPED ===');
                    print('Calling onBettingTap with: Profile');
                    onBettingTap('Profile');
                    print('=== END PROFILE BUTTON ===');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: textWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
