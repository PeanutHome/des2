import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ပရိုဖိုင်',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.brightGold),
            onPressed: () => _showEditProfileDialog(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                margin: const EdgeInsets.all(16),
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

              // Contact Information
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
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

              // Settings Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      'ဆက်တင်များ',
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
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Account Actions
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
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

              const SizedBox(height: 30),
            ],
          ),
        ),
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
                // TODO: Implement logout functionality
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
}
