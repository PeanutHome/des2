import 'package:flutter/material.dart';

class BlinkingNumbersWidget extends StatelessWidget {
  final Color accentGold;
  final Color brightGold;
  final Color textWhite;
  final Color textGrey;
  final String current2D;
  final bool isLoading;
  final Animation<double> blinkAnimation;
  final Map<String, dynamic>? apiData;

  const BlinkingNumbersWidget({
    super.key,
    required this.accentGold,
    required this.brightGold,
    required this.textWhite,
    required this.textGrey,
    required this.current2D,
    required this.isLoading,
    required this.blinkAnimation,
    this.apiData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'လက်ရှိ ထီနံပါတ်များ',
                  style: TextStyle(
                    color: textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isLoading)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(brightGold),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: _buildBlinking2DNumber(),
          ),
          if (apiData != null) ...[
            const SizedBox(height: 16),
            _buildLiveDataGrid(),
          ],
        ],
      ),
    );
  }

  Widget _buildBlinking2DNumber() {
    return Column(
      children: [
        Text(
          '2D',
          style: TextStyle(
            color: textGrey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        AnimatedBuilder(
          animation: blinkAnimation,
          builder: (context, child) {
            // Create flickering effect - numbers appear/disappear rapidly
            final isVisible = blinkAnimation.value > 0.1;
            
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              decoration: BoxDecoration(
                color: brightGold.withValues(alpha: 0.1 + (blinkAnimation.value * 0.3)),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: brightGold.withValues(alpha: 0.3 + (blinkAnimation.value * 0.5)),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: brightGold.withValues(alpha: 0.4 * blinkAnimation.value),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Opacity(
                opacity: isVisible ? 1.0 : 0.0,
                child: Text(
                  current2D,
                  style: TextStyle(
                    color: brightGold,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: brightGold.withValues(alpha: 0.8),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLiveDataGrid() {
    if (apiData == null || apiData!['live'] == null) return const SizedBox.shrink();
    
    final live = apiData!['live'];
    
    return Row(
      children: [
        Expanded(
          child: _buildLiveDataCard('SET', live['set'] ?? '--', Icons.trending_up),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildLiveDataCard('Value', live['value'] ?? '--', Icons.attach_money),
        ),
      ],
    );
  }

  Widget _buildLiveDataCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accentGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentGold.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: brightGold.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              color: brightGold,
              size: 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                AnimatedBuilder(
                  animation: blinkAnimation,
                  builder: (context, child) {
                    // Create flickering effect - numbers appear/disappear rapidly
                    final isVisible = blinkAnimation.value > 0.1;
                    
                    return Opacity(
                      opacity: isVisible ? 1.0 : 0.0,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: brightGold,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: brightGold.withValues(alpha: 0.8),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
