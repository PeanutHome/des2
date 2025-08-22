import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../constants/app_colors.dart';
import '../widgets/header_widget.dart';
import '../widgets/banner_widget.dart';
import '../widgets/blinking_numbers_widget.dart';
import '../widgets/quick_actions_widget.dart';
import '../widgets/today_schedule_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import 'two_d_morning.dart';
import 'two_d_evening.dart';
import 'three_d_betting.dart';
import 'wallet_page.dart';
import 'profile_page.dart';
import 'history_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;
  int _selectedIndex = 0;
  Timer? _apiTimer;
  
  // API Data
  Map<String, dynamic>? _apiData;
  String _current2D = '--';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _blinkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _blinkController,
      curve: Curves.easeInOut,
    ));
    _blinkController.repeat(reverse: true);
    
    // Fetch initial data and start timer
    _fetchApiData();
    _startApiTimer();
  }

  @override
  void dispose() {
    _blinkController.dispose();
    _apiTimer?.cancel();
    super.dispose();
  }

  void _startApiTimer() {
    _apiTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _fetchApiData();
    });
  }

  Future<void> _fetchApiData() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.thaistock2d.com/live'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _apiData = data;
          _current2D = data['live']['twod'] ?? '--';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching API data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
                child: Column(
          children: [
            // Only show header when NOT on history or settings tab
            if (_selectedIndex != 2 && _selectedIndex != 3)
              HeaderWidget(
                primaryBackground: AppColors.primaryBackground,
                accentGold: AppColors.accentGold,
                brightGold: AppColors.brightGold,
                textWhite: AppColors.textWhite,
                textGrey: AppColors.textGrey,
              ),
            Expanded(
              child: _selectedIndex == 2 
                  ? _buildHistoryContent()
                  : _selectedIndex == 3
                      ? _buildSettingsContent()
                      : SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          // BannerWidget(
                          //   brightGold: AppColors.brightGold,
                          //   accentGold: AppColors.accentGold,
                          //   textWhite: AppColors.textWhite,
                          // ),
                          BlinkingNumbersWidget(
                            accentGold: AppColors.accentGold,
                            brightGold: AppColors.brightGold,
                            textWhite: AppColors.textWhite,
                            textGrey: AppColors.textGrey,
                            current2D: _current2D,
                            isLoading: _isLoading,
                            blinkAnimation: _blinkAnimation,
                            apiData: _apiData,
                          ),
                          const SizedBox(height: 8),
                          QuickActionsWidget(
                            accentGold: AppColors.accentGold,
                            brightGold: AppColors.brightGold,
                            textWhite: AppColors.textWhite,
                            onBettingTap: _navigateToBetting,
                          ),
                          // Temporary test buttons for debugging
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('TEST: Direct navigation to Wallet');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const WalletPage(),
                                        ),
                                      );
                                    },
                                    child: Text('TEST Wallet'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('TEST: Direct navigation to Profile');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const ProfilePage(),
                                        ),
                                      );
                                    },
                                    child: Text('TEST Profile'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          TodayScheduleWidget(
                            accentGold: AppColors.accentGold,
                            brightGold: AppColors.brightGold,
                            primaryBackground: AppColors.primaryBackground,
                            textWhite: AppColors.textWhite,
                            textGrey: AppColors.textGrey,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
            ),
            BottomNavigationWidget(
              primaryBackground: AppColors.primaryBackground,
              accentGold: AppColors.accentGold,
              brightGold: AppColors.brightGold,
              textGrey: AppColors.textGrey,
              selectedIndex: _selectedIndex,
              onNavigationTap: _handleNavigation,
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildHistoryContent() {
    return const HistoryPage();
  }

  Widget _buildSettingsContent() {
    return const SettingsPage();
  }

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    switch (index) {
      case 1:
        _navigateToBetting('2D');
        break;
      case 2:
        // History tab - content will be shown inline
        break;
      case 3:
        _navigateToSettings();
        break;
    }
  }

  void _navigateToBetting(String type) {
    print('=== NAVIGATION DEBUG ===');
    print('Navigation requested for: $type');
    print('Context: $context');
    
    if (type == '2D') {
      print('Showing 2D time selection dialog');
      // Show time selection dialog
      _showTimeSelectionDialog();
    } else if (type == '3D') {
      print('Navigating to 3D betting page');
      // Navigate directly to 3D betting page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ThreeDBettingPage(),
        ),
      );
    } else if (type == 'Wallet') {
      print('Navigating to Wallet page...');
      // Navigate to wallet page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WalletPage(),
        ),
      );
    } else if (type == 'Profile') {
      print('Navigating to Profile page...');
      // Navigate to profile page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ),
      );
    } else {
      print('Unknown type: $type');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$type စာမျက်နှာသို့ သွားမည်'),
          backgroundColor: AppColors.brightGold,
        ),
      );
    }
    print('=== END NAVIGATION DEBUG ===');
  }

  void _showTimeSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackground,
          title: Text(
            'အချိန်ရွေးချယ်ပါ',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.wb_sunny, color: AppColors.brightGold),
                title: Text(
                  'နံနက် 11:00',
                  style: TextStyle(color: AppColors.textWhite),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TwoDMorningPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.nightlight, color: AppColors.brightGold),
                title: Text(
                  'ညနေ 12:01',
                  style: TextStyle(color: AppColors.textWhite),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TwoDEveningPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ပယ်ဖျက်ရန်',
                style: TextStyle(color: AppColors.textGrey),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToResults() {
    // TODO: Navigate to results page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('ထီရလဒ်များ စာမျက်နှာသို့ သွားမည်'),
        backgroundColor: AppColors.brightGold,
      ),
    );
  }

  void _navigateToHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryPage(),
      ),
    );
  }

  void _navigateToSettings() {
    // TODO: Navigate to settings page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('ဆက်တင်များ စာမျက်နှာသို့ သွားမည်'),
        backgroundColor: AppColors.brightGold,
      ),
    );
  }
}
