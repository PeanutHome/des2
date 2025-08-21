import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String _selectedFilter = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allTransactions = [
    {
      'id': '1',
      'type': 'deposit',
      'amount': 50000.0,
      'description': 'ဘဏ်မှ ငွေထည့်သွင်းမှု',
      'date': '2024-01-15 14:30',
      'status': 'completed',
      'bank': 'KBZ Bank',
      'reference': 'REF123456',
    },
    {
      'id': '2',
      'type': 'withdrawal',
      'amount': 25000.0,
      'description': 'ဘဏ်သို့ ငွေထုတ်ယူမှု',
      'date': '2024-01-14 10:15',
      'status': 'completed',
      'bank': 'AYA Bank',
      'reference': 'REF789012',
    },
    {
      'id': '3',
      'type': 'bet',
      'amount': 15000.0,
      'description': '2D ထီထိုးမှု',
      'date': '2024-01-13 11:00',
      'status': 'completed',
      'game': '2D Morning',
      'number': '12',
    },
    {
      'id': '4',
      'type': 'win',
      'amount': 75000.0,
      'description': 'ထီထိုးမှု အနိုင်ရရှိမှု',
      'date': '2024-01-12 12:01',
      'status': 'completed',
      'game': '2D Evening',
      'number': '45',
    },
    {
      'id': '5',
      'type': 'deposit',
      'amount': 100000.0,
      'description': 'ဘဏ်မှ ငွေထည့်သွင်းမှု',
      'date': '2024-01-10 09:45',
      'status': 'completed',
      'bank': 'CB Bank',
      'reference': 'REF345678',
    },
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    List<Map<String, dynamic>> filtered = _allTransactions;

    if (_selectedFilter != 'all') {
      filtered = filtered.where((transaction) => transaction['type'] == _selectedFilter).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((transaction) {
        return transaction['description'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
               transaction['date'].contains(_searchQuery);
      }).toList();
    }

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          'ငွေကြေးလွှဲပြောင်းမှု မှတ်တမ်း',
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
            // Search and Filter Section
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.accentGold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.accentGold.withOpacity(0.3)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      style: TextStyle(color: AppColors.textWhite),
                      decoration: InputDecoration(
                        hintText: 'ရှာဖွေရန်...',
                        hintStyle: TextStyle(color: AppColors.textGrey),
                        prefixIcon: Icon(Icons.search, color: AppColors.brightGold),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('အားလုံး', 'all'),
                        const SizedBox(width: 8),
                        _buildFilterChip('ငွေထည့်', 'deposit'),
                        const SizedBox(width: 8),
                        _buildFilterChip('ငွေထုတ်', 'withdrawal'),
                        const SizedBox(width: 8),
                        _buildFilterChip('ထီထိုး', 'bet'),
                        const SizedBox(width: 8),
                        _buildFilterChip('အနိုင်ရ', 'win'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Transaction Count
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'စုစုပေါင်း: ${_filteredTransactions.length} ခု',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'ငွေပမာဏ: ${_getTotalAmount()} ကျပ်',
                    style: TextStyle(
                      color: AppColors.brightGold,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Transactions List
            Expanded(
              child: _filteredTransactions.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = _filteredTransactions[index];
                        return _buildTransactionCard(transaction);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brightGold : AppColors.accentGold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.brightGold : AppColors.accentGold.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primaryBackground : AppColors.textWhite,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final isDeposit = transaction['type'] == 'deposit';
    final isWin = transaction['type'] == 'win';
    final isBet = transaction['type'] == 'bet';
    final isWithdrawal = transaction['type'] == 'withdrawal';

    Color amountColor = AppColors.textWhite;
    IconData icon = Icons.swap_horiz;
    String typeText = '';

    if (isDeposit || isWin) {
      amountColor = AppColors.brightGold;
      icon = isDeposit ? Icons.add_circle : Icons.emoji_events;
      typeText = isDeposit ? 'ထည့်သွင်း' : 'အနိုင်ရ';
    } else if (isWithdrawal || isBet) {
      amountColor = AppColors.accentGold;
      icon = isWithdrawal ? Icons.remove_circle : Icons.sports_esports;
      typeText = isWithdrawal ? 'ထုတ်ယူ' : 'ထီထိုး';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentGold.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentGold.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGold.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: amountColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: amountColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['description'],
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: amountColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        typeText,
                        style: TextStyle(
                          color: amountColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      transaction['date'],
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                if (transaction['bank'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'ဘဏ်: ${transaction['bank']}',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isDeposit || isWin ? '+' : '-'}${transaction['amount'].toStringAsFixed(0)} ကျပ်',
                style: TextStyle(
                  color: amountColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.brightGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'ပြီးမြောက်',
                  style: TextStyle(
                    color: AppColors.brightGold,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.textGrey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'ငွေကြေးလွှဲပြောင်းမှု မတွေ့ရပါ',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ရှာဖွေမှုစကားလုံး သို့မဟုတ် စစ်ထုတ်မှုကို ပြောင်းလဲကြည့်ရှုပါ',
            style: TextStyle(
              color: AppColors.textGrey.withOpacity(0.7),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getTotalAmount() {
    double total = 0;
    for (var transaction in _filteredTransactions) {
      if (transaction['type'] == 'deposit' || transaction['type'] == 'win') {
        total += transaction['amount'];
      } else {
        total -= transaction['amount'];
      }
    }
    return total.toStringAsFixed(0);
  }
}
