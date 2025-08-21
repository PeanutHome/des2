import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TwoDMorningPage extends StatefulWidget {
  const TwoDMorningPage({super.key});

  @override
  State<TwoDMorningPage> createState() => _TwoDMorningPageState();
}

class _TwoDMorningPageState extends State<TwoDMorningPage> {
  final List<String> _selectedNumbers = [];
  final TextEditingController _amountController = TextEditingController();
  String _selectedQuickSelect = '';
  bool _isLoading = false;

  final List<String> _quickSelectOptions = [
    'အပေါ်ဆုံး 10 လုံး',
    'အောက်ဆုံး 10 လုံး',
    'အလယ်က 10 လုံး',
    'အပေါ်ဆုံး 20 လုံး',
    'အောက်ဆုံး 20 လုံး',
    'အားလုံး ရွေးချယ်',
    'ရွေးချယ်မှုများ ဖျက်ရန်',
  ];

  @override
  void initState() {
    super.initState();
    _amountController.text = '1000';
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _toggleNumber(String number) {
    setState(() {
      if (_selectedNumbers.contains(number)) {
        _selectedNumbers.remove(number);
      } else {
        _selectedNumbers.add(number);
      }
    });
  }

  void _handleQuickSelect(String option) {
    setState(() {
      _selectedQuickSelect = option;
      _selectedNumbers.clear();
      
      switch (option) {
        case 'အပေါ်ဆုံး 10 လုံး':
          _selectedNumbers.addAll(['00', '01', '02', '03', '04', '05', '06', '07', '08', '09']);
          break;
        case 'အောက်ဆုံး 10 လုံး':
          _selectedNumbers.addAll(['90', '91', '92', '93', '94', '95', '96', '97', '98', '99']);
          break;
        case 'အလယ်က 10 လုံး':
          _selectedNumbers.addAll(['45', '46', '47', '48', '49', '50', '51', '52', '53', '54']);
          break;
        case 'အပေါ်ဆုံး 20 လုံး':
          for (int i = 0; i <= 19; i++) {
            _selectedNumbers.add(i.toString().padLeft(2, '0'));
          }
          break;
        case 'အောက်ဆုံး 20 လုံး':
          for (int i = 80; i <= 99; i++) {
            _selectedNumbers.add(i.toString().padLeft(2, '0'));
          }
          break;
        case 'အားလုံး ရွေးချယ်':
          for (int i = 0; i <= 99; i++) {
            _selectedNumbers.add(i.toString().padLeft(2, '0'));
          }
          break;
        case 'ရွေးချယ်မှုများ ဖျက်ရန်':
          _selectedNumbers.clear();
          break;
      }
    });
  }

  void _placeBet() async {
    if (_selectedNumbers.isEmpty) {
      _showSnackBar('ကျေးဇူးပြု၍ နံပါတ်များ ရွေးချယ်ပါ', false);
      return;
    }

    if (_amountController.text.isEmpty || int.tryParse(_amountController.text) == null) {
      _showSnackBar('ကျေးဇူးပြု၍ ငွေပမာဏ ထည့်သွင်းပါ', false);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    _showSnackBar('ထီထိုးမှု အောင်မြင်ပါသည်!', true);
    
    // Navigate back after successful bet
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  Widget _buildDropdownButton(String title, List<String> options) {
    return PopupMenuButton<String>(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.accentGold.withOpacity(0.2),
              AppColors.brightGold.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.brightGold.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.brightGold.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.tune,
              color: AppColors.brightGold,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textWhite,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      color: AppColors.primaryBackground,
      itemBuilder: (context) => options.map((option) {
        return PopupMenuItem<String>(
          value: option,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _selectedQuickSelect == option 
                  ? AppColors.brightGold.withOpacity(0.1)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(
                  _getIconForOption(option),
                  color: _selectedQuickSelect == option 
                      ? AppColors.brightGold 
                      : AppColors.textGrey,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: _selectedQuickSelect == option 
                          ? AppColors.brightGold 
                          : AppColors.textWhite,
                      fontSize: 14,
                      fontWeight: _selectedQuickSelect == option 
                          ? FontWeight.w600 
                          : FontWeight.w500,
                    ),
                  ),
                ),
                if (_selectedQuickSelect == option)
                  Icon(
                    Icons.check_circle,
                    color: AppColors.brightGold,
                    size: 18,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
      onSelected: (value) => _handleQuickSelect(value),
    );
  }

  IconData _getIconForOption(String option) {
    switch (option) {
      case 'အပေါ်ဆုံး 10 လုံး':
      case 'အပေါ်ဆုံး 20 လုံး':
        return Icons.keyboard_arrow_up;
      case 'အောက်ဆုံး 10 လုံး':
      case 'အောက်ဆုံး 20 လုံး':
        return Icons.keyboard_arrow_down;
      case 'အလယ်က 10 လုံး':
        return Icons.center_focus_strong;
      case 'အားလုံး ရွေးချယ်':
        return Icons.select_all;
      case 'ရွေးချယ်မှုများ ဖျက်ရန်':
        return Icons.clear_all;
      default:
        return Icons.tune;
    }
  }

  void _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? AppColors.brightGold : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

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
          '2D ထီထိုး - နံနက် 11:00',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Time Info Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.brightGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.brightGold.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'နံနက် 11:00 ထီထိုး',
                        style: TextStyle(
                          color: AppColors.brightGold,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ထီထိုးချိန်: နံနက် 11:00',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.access_time,
                    color: AppColors.brightGold,
                    size: 24,
                  ),
                ],
              ),
            ),



            // Number Grid Section
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'နံပါတ်များ ရွေးချယ်ပါ',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'ရွေးချယ်ထားသော: ${_selectedNumbers.length}',
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 10,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: 1,
                        ),
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          final number = index.toString().padLeft(2, '0');
                          final isSelected = _selectedNumbers.contains(number);
                          
                          return GestureDetector(
                            onTap: () => _toggleNumber(number),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.brightGold : AppColors.accentGold.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected ? AppColors.brightGold : AppColors.accentGold.withOpacity(0.3),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  number,
                                  style: TextStyle(
                                    color: isSelected ? AppColors.primaryBackground : AppColors.textWhite,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Betting Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.accentGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.accentGold.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ငွေပမာဏ',
                              style: TextStyle(
                                color: AppColors.textWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: AppColors.textWhite),
                              decoration: InputDecoration(
                                hintText: 'ငွေပမာဏ ထည့်သွင်းပါ',
                                hintStyle: TextStyle(color: AppColors.textGrey),
                                filled: true,
                                fillColor: AppColors.primaryBackground,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: AppColors.accentGold.withOpacity(0.3)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: AppColors.accentGold.withOpacity(0.3)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: AppColors.brightGold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'စုစုပေါင်း',
                              style: TextStyle(
                                color: AppColors.textWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBackground,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.accentGold.withOpacity(0.3)),
                              ),
                              child: Text(
                                '${_selectedNumbers.length * (int.tryParse(_amountController.text) ?? 0)}',
                                style: TextStyle(
                                  color: AppColors.brightGold,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Quick Select Dropdown
                  SizedBox(
                    width: double.infinity,
                    child: _buildDropdownButton('အမြန်ရွေးချယ်မှုများ ရွေးချယ်ပါ', [
                      'အပေါ်ဆုံး 10 လုံး',
                      'အပေါ်ဆုံး 20 လုံး',
                      'အောက်ဆုံး 10 လုံး',
                      'အောက်ဆုံး 20 လုံး',
                      'အလယ်က 10 လုံး',
                      'အားလုံး ရွေးချယ်',
                      'ရွေးချယ်မှုများ ဖျက်ရန်',
                    ]),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _placeBet,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brightGold,
                        foregroundColor: AppColors.primaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBackground),
                              ),
                            )
                          : Text(
                              'ထီထိုးမည်',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
