import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late TabController _tabController;
  
  // Profile data
  final Map<String, dynamic> _userProfile = {
    'name': 'ဦးအောင်မင်း',
    'phone': '+95 9 123 456 789',
    'email': 'aungmin@gmail.com',
    'memberSince': '2023-01-15',
    'totalBets': 156,
    'totalWins': 23,
    'winRate': '14.7%',
    'avatar': 'https://via.placeholder.com/100',
  };

  // Settings states
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _autoLockEnabled = false;
  String _language = 'မြန်မာ';
  String _currency = 'ကျပ်';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom header for inline display
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'ဆက်တင်များနှင့် ပရိုဖိုင်',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Tab bar
        Container(
          color: AppColors.primaryBackground,
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.brightGold,
            labelColor: AppColors.brightGold,
            unselectedLabelColor: AppColors.textGrey,
            tabs: const [
              Tab(text: 'ပရိုဖိုင်'),
              Tab(text: 'ဆက်တင်များ'),
            ],
          ),
        ),
        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildProfileTab(),
              _buildSettingsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.brightGold.withOpacity(0.2),
                  AppColors.accentGold.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.brightGold.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.brightGold.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Avatar and Name
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.brightGold.withOpacity(0.2),
                  backgroundImage: NetworkImage(_userProfile['avatar']),
                  child: _userProfile['avatar'].contains('placeholder')
                      ? Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.brightGold,
                        )
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  _userProfile['name'],
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'အဖွဲ့ဝင်: ${_userProfile['memberSince']} မှ',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'ထီထိုးမှု',
                        _userProfile['totalBets'].toString(),
                        Icons.sports_esports,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: AppColors.accentGold.withOpacity(0.3),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        'အနိုင်ရ',
                        _userProfile['totalWins'].toString(),
                        Icons.emoji_events,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: AppColors.accentGold.withOpacity(0.3),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        'အနိုင်ရနှုန်း',
                        _userProfile['winRate'],
                        Icons.trending_up,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Contact Information
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accentGold.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ဆက်သွယ်ရန်အချက်အလက်',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildContactItem(
                  Icons.phone,
                  'ဖုန်းနံပါတ်',
                  _userProfile['phone'],
                  () => _showContactDialog('phone'),
                ),
                const SizedBox(height: 12),
                _buildContactItem(
                  Icons.email,
                  'အီးမေးလ်',
                  _userProfile['email'],
                  () => _showContactDialog('email'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Account Actions
          Container(
            child: Column(
              children: [
                _buildActionButton(
                  'ပရိုဖိုင် ပြင်ဆင်ရန်',
                  Icons.edit,
                  AppColors.brightGold,
                  () => _showEditProfileDialog(),
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  'လျှို့ဝှက်ကုဒ် ပြောင်းရန်',
                  Icons.lock,
                  AppColors.accentGold,
                  () => _showChangePasswordDialog(),
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  'အကောင့်မှ ထွက်ရန်',
                  Icons.logout,
                  Colors.red,
                  () => _showLogoutDialog(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Notifications Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accentGold.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'အကြောင်းကြားချက်များ',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingItem(
                  'အကြောင်းကြားချက်များ',
                  'ထီထိုးရလဒ်များနှင့် အကြောင်းကြားချက်များ',
                  Icons.notifications,
                  Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: AppColors.brightGold,
                    activeTrackColor: AppColors.brightGold.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingItem(
                  'အသံ',
                  'အကြောင်းကြားချက်များအတွက် အသံဖွင့်ရန်',
                  Icons.volume_up,
                  Switch(
                    value: _soundEnabled,
                    onChanged: (value) {
                      setState(() {
                        _soundEnabled = value;
                      });
                    },
                    activeColor: AppColors.brightGold,
                    activeTrackColor: AppColors.brightGold.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingItem(
                  'တုန်ခါမှု',
                  'အကြောင်းကြားချက်များအတွက် တုန်ခါမှုဖွင့်ရန်',
                  Icons.vibration,
                  Switch(
                    value: _vibrationEnabled,
                    onChanged: (value) {
                      setState(() {
                        _vibrationEnabled = value;
                      });
                    },
                    activeColor: AppColors.brightGold,
                    activeTrackColor: AppColors.brightGold.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Security Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accentGold.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'လုံခြုံရေး',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingItem(
                  'ဇီဝမက်ထရစ်',
                  'လက်ဗွေနှင့် မျက်နှာမှတ်မိမှုဖြင့် ဝင်ရောက်ရန်',
                  Icons.fingerprint,
                  Switch(
                    value: _biometricEnabled,
                    onChanged: (value) {
                      setState(() {
                        _biometricEnabled = value;
                      });
                    },
                    activeColor: AppColors.brightGold,
                    activeTrackColor: AppColors.brightGold.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingItem(
                  'အလိုအလျောက် သော့ခတ်ခြင်း',
                  'အသုံးမပြုပါက အလိုအလျောက် သော့ခတ်ရန်',
                  Icons.lock_clock,
                  Switch(
                    value: _autoLockEnabled,
                    onChanged: (value) {
                      setState(() {
                        _autoLockEnabled = value;
                      });
                    },
                    activeColor: AppColors.brightGold,
                    activeTrackColor: AppColors.brightGold.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Appearance Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accentGold.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'အပြင်အဆင်',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingItem(
                  'အနက်ရောင်မုဒ်',
                  'အနက်ရောင်အပြင်အဆင်ကို အသုံးပြုရန်',
                  Icons.dark_mode,
                  Switch(
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                    activeColor: AppColors.brightGold,
                    activeTrackColor: AppColors.brightGold.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingItem(
                  'ဘာသာစကား',
                  'ဘာသာစကား ရွေးချယ်ရန်',
                  Icons.language,
                  _buildLanguageSelector(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Preferences Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accentGold.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'အကြိုက်များ',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingItem(
                  'ငွေကြေး',
                  'ငွေကြေး ရွေးချယ်ရန်',
                  Icons.attach_money,
                  _buildCurrencySelector(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // App Info Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accentGold.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'အက်ပ်အကြောင်းအရာ',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoItem('ဗားရှင်း', '1.0.0'),
                const SizedBox(height: 12),
                _buildInfoItem('ထုတ်ဝေသည့်ရက်', '2024-01-15'),
                const SizedBox(height: 12),
                _buildInfoItem('ဖွံ့ဖြိုးသူ', 'Myanmar Lottery Team'),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.brightGold,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: AppColors.brightGold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.accentGold.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.brightGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.brightGold, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.edit,
              color: AppColors.accentGold,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, String subtitle, IconData icon, Widget trailing) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.brightGold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.brightGold, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        trailing,
      ],
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: color.withOpacity(0.7),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return GestureDetector(
      onTap: () => _showLanguageDialog(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.brightGold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.brightGold.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _language,
              style: TextStyle(
                color: AppColors.brightGold,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_drop_down,
              color: AppColors.brightGold,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return GestureDetector(
      onTap: () => _showCurrencyDialog(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.brightGold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.brightGold.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _currency,
              style: TextStyle(
                color: AppColors.brightGold,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_drop_down,
              color: AppColors.brightGold,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackground,
          title: Text(
            'ပရိုဖိုင် ပြင်ဆင်ရန်',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'ပရိုဖိုင် ပြင်ဆင်မှုအတွက် အုပ်ချုပ်သူနှင့် ဆက်သွယ်ပါ',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ပိတ်ရန်',
                style: TextStyle(color: AppColors.textGrey),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showContactDialog(String type) {
    String title = '';
    String content = '';
    
    if (type == 'phone') {
      title = 'ဖုန်းနံပါတ် ပြင်ဆင်ရန်';
      content = 'ဖုန်းနံပါတ် ပြင်ဆင်မှုအတွက် အုပ်ချုပ်သူနှင့် ဆက်သွယ်ပါ';
    } else if (type == 'email') {
      title = 'အီးမေးလ် ပြင်ဆင်ရန်';
      content = 'အီးမေးလ် ပြင်ဆင်မှုအတွက် အုပ်ချုပ်သူနှင့် ဆက်သွယ်ပါ';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackground,
          title: Text(
            title,
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ပိတ်ရန်',
                style: TextStyle(color: AppColors.textGrey),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackground,
          title: Text(
            'လျှို့ဝှက်ကုဒ် ပြောင်းရန်',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'လျှို့ဝှက်ကုဒ် ပြောင်းမှုအတွက် အုပ်ချုပ်သူနှင့် ဆက်သွယ်ပါ',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ပိတ်ရန်',
                style: TextStyle(color: AppColors.textGrey),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackground,
          title: Text(
            'အကောင့်မှ ထွက်ရန်',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'သင်သည် အကောင့်မှ ထွက်ရန် သေချာပါသလား?',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ပယ်ဖျက်ရန်',
                style: TextStyle(color: AppColors.textGrey),
              ),
            ),
                          TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Implement logout functionality using AuthService
                  final authService = Provider.of<AuthService>(context, listen: false);
                  authService.logout();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('အကောင့်မှ ထွက်ပြီးပါပြီ'),
                      backgroundColor: AppColors.brightGold,
                    ),
                  );
                },
                child: Text(
                  'ထွက်ရန်',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackground,
          title: Text(
            'ဘာသာစကား ရွေးချယ်ရန်',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('မြန်မာ'),
              _buildLanguageOption('English'),
              _buildLanguageOption('ကရင်'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    return ListTile(
      title: Text(
        language,
        style: TextStyle(
          color: _language == language ? AppColors.brightGold : AppColors.textWhite,
          fontWeight: _language == language ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: _language == language
          ? Icon(Icons.check, color: AppColors.brightGold)
          : null,
      onTap: () {
        setState(() {
          _language = language;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackground,
          title: Text(
            'ငွေကြေး ရွေးချယ်ရန်',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCurrencyOption('ကျပ်'),
              _buildCurrencyOption('USD'),
              _buildCurrencyOption('THB'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrencyOption(String currency) {
    return ListTile(
      title: Text(
        currency,
        style: TextStyle(
          color: _currency == currency ? AppColors.brightGold : AppColors.textWhite,
          fontWeight: _currency == currency ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: _currency == currency
          ? Icon(Icons.check, color: AppColors.brightGold)
          : null,
      onTap: () {
        setState(() {
          _currency = currency;
        });
        Navigator.pop(context);
      },
    );
  }
}

