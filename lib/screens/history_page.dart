import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with TickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late TabController _tabController;
  String _selectedFilter = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Dummy data for betting history
  final List<Map<String, dynamic>> _bettingHistory = [
    {
      'id': '1',
      'game': '2D Morning',
      'number': '12',
      'amount': 15000.0,
      'date': '2024-01-15 10:30',
      'status': 'won',
      'result': '12',
      'winAmount': 75000.0,
    },
    {
      'id': '2',
      'game': '2D Evening',
      'number': '45',
      'amount': 20000.0,
      'date': '2024-01-14 12:00',
      'status': 'won',
      'result': '45',
      'winAmount': 100000.0,
    },
    {
      'id': '3',
      'game': '3D',
      'number': '789',
      'amount': 25000.0,
      'date': '2024-01-13 15:30',
      'status': 'lost',
      'result': '456',
      'winAmount': 0.0,
    },
    {
      'id': '4',
      'game': '2D Morning',
      'number': '89',
      'amount': 18000.0,
      'date': '2024-01-12 10:15',
      'status': 'won',
      'result': '89',
      'winAmount': 90000.0,
    },
    {
      'id': '5',
      'game': '2D Evening',
      'number': '23',
      'amount': 12000.0,
      'date': '2024-01-11 12:30',
      'status': 'lost',
      'result': '67',
      'winAmount': 0.0,
    },
    {
      'id': '6',
      'game': '2D Morning',
      'number': '56',
      'amount': 22000.0,
      'date': '2024-01-10 10:45',
      'status': 'won',
      'result': '56',
      'winAmount': 110000.0,
    },
  ];

  // Dummy data for winning history
  final List<Map<String, dynamic>> _winningHistory = [
    {
      'id': '1',
      'game': '2D Morning',
      'number': '12',
      'winAmount': 75000.0,
      'date': '2024-01-15 11:00',
      'multiplier': '5x',
    },
    {
      'id': '2',
      'game': '2D Evening',
      'number': '45',
      'winAmount': 100000.0,
      'date': '2024-01-14 12:01',
      'multiplier': '5x',
    },
    {
      'id': '3',
      'game': '2D Morning',
      'number': '89',
      'winAmount': 90000.0,
      'date': '2024-01-12 11:00',
      'multiplier': '5x',
    },
    {
      'id': '4',
      'game': '2D Evening',
      'number': '56',
      'winAmount': 110000.0,
      'date': '2024-01-10 11:00',
      'multiplier': '5x',
    },
  ];

  // Dummy data for game statistics
  final Map<String, dynamic> _gameStats = {
    'totalBets': 112000.0,
    'totalWins': 375000.0,
    'netProfit': 263000.0,
    'winRate': 66.7,
    'totalGames': 6,
    'gamesWon': 4,
    'gamesLost': 2,
    'favoriteNumber': '12',
    'favoriteGame': '2D Morning',
    'biggestWin': 110000.0,
    'biggestWinDate': '2024-01-10',
    'currentStreak': 2,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredBettingHistory {
    List<Map<String, dynamic>> filtered = _bettingHistory;

    if (_selectedFilter != 'all') {
      filtered = filtered.where((bet) => bet['status'] == _selectedFilter).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((bet) {
        return bet['game'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
               bet['number'].toString().contains(_searchQuery) ||
               bet['date'].contains(_searchQuery);
      }).toList();
    }

    return filtered;
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
                'မှတ်တမ်း',
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
              Tab(text: 'ထီထိုးမှတ်တမ်း'),
              Tab(text: 'အနိုင်ရမှတ်တမ်း'),
              Tab(text: 'စာရင်းဇယား'),
            ],
          ),
        ),
        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildBettingHistoryTab(),
              _buildWinningHistoryTab(),
              _buildStatisticsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBettingHistoryTab() {
    return Column(
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
                    _buildFilterChip('အနိုင်ရ', 'won'),
                    const SizedBox(width: 8),
                    _buildFilterChip('ရှုံးနိမ့်', 'lost'),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Betting History List
        Expanded(
          child: _filteredBettingHistory.isEmpty
              ? _buildEmptyState('ထီထိုးမှတ်တမ်း မတွေ့ရပါ')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredBettingHistory.length,
                  itemBuilder: (context, index) {
                    final bet = _filteredBettingHistory[index];
                    return _buildBettingHistoryCard(bet);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildWinningHistoryTab() {
    return Column(
      children: [
        // Header with total winnings
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.brightGold.withOpacity(0.2),
                AppColors.accentGold.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.brightGold.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Text(
                'စုစုပေါင်း အနိုင်ရငွေ',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${_gameStats['totalWins'].toStringAsFixed(0)} ကျပ်',
                style: TextStyle(
                  color: AppColors.brightGold,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Winning History List
        Expanded(
          child: _winningHistory.isEmpty
              ? _buildEmptyState('အနိုင်ရမှတ်တမ်း မတွေ့ရပါ')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _winningHistory.length,
                  itemBuilder: (context, index) {
                    final win = _winningHistory[index];
                    return _buildWinningHistoryCard(win);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildStatisticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Overall Statistics
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.brightGold.withOpacity(0.2),
                  AppColors.accentGold.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.brightGold.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(
                  'စုစုပေါင်း စာရင်းဇယား',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'ထီထိုးငွေ',
                        '${_gameStats['totalBets'].toStringAsFixed(0)} ကျပ်',
                        Icons.attach_money,
                        AppColors.accentGold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatItem(
                        'အနိုင်ရငွေ',
                        '${_gameStats['totalWins'].toStringAsFixed(0)} ကျပ်',
                        Icons.emoji_events,
                        AppColors.brightGold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'အမြတ်',
                        '${_gameStats['netProfit'].toStringAsFixed(0)} ကျပ်',
                        Icons.trending_up,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatItem(
                        'အနိုင်နှုန်း',
                        '${_gameStats['winRate']}%',
                        Icons.percent,
                        AppColors.brightGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Detailed Statistics
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accentGold.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'အသေးစိတ် စာရင်းဇယား',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailStatRow('စုစုပေါင်း ဂိမ်း', '${_gameStats['totalGames']} ခု'),
                _buildDetailStatRow('အနိုင်ရဂိမ်း', '${_gameStats['gamesWon']} ခု'),
                _buildDetailStatRow('ရှုံးနိမ့်ဂိမ်း', '${_gameStats['gamesLost']} ခု'),
                _buildDetailStatRow('အကြိုက်ဆုံးနံပါတ်', _gameStats['favoriteNumber']),
                _buildDetailStatRow('အကြိုက်ဆုံးဂိမ်း', _gameStats['favoriteGame']),
                _buildDetailStatRow('အကြီးဆုံးအနိုင်ရ', '${_gameStats['biggestWin'].toStringAsFixed(0)} ကျပ်'),
                _buildDetailStatRow('အကြီးဆုံးအနိုင်ရရက်', _gameStats['biggestWinDate']),
                _buildDetailStatRow('လက်ရှိအနိုင်ရအစီအစဉ်', '${_gameStats['currentStreak']} ခု'),
              ],
            ),
          ),
        ],
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

  Widget _buildBettingHistoryCard(Map<String, dynamic> bet) {
    final isWon = bet['status'] == 'won';
    final statusColor = isWon ? AppColors.brightGold : AppColors.accentGold;
    final statusText = isWon ? 'အနိုင်ရ' : 'ရှုံးနိမ့်';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isWon ? Icons.emoji_events : Icons.sports_esports,
                  color: statusColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bet['game'],
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bet['date'],
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ထီထိုးနံပါတ်',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    bet['number'],
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ထီထိုးငွေ',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${bet['amount'].toStringAsFixed(0)} ကျပ်',
                    style: TextStyle(
                      color: AppColors.accentGold,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (isWon)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'အနိုင်ရငွေ',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${bet['winAmount'].toStringAsFixed(0)} ကျပ်',
                      style: TextStyle(
                        color: AppColors.brightGold,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (!isWon) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'ရလဒ်: ',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  bet['result'],
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWinningHistoryCard(Map<String, dynamic> win) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.brightGold.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.brightGold.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.brightGold.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.brightGold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.emoji_events,
              color: AppColors.brightGold,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  win['game'],
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'နံပါတ်: ',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      win['number'],
                      style: TextStyle(
                        color: AppColors.brightGold,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'အဆ: ',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      win['multiplier'],
                      style: TextStyle(
                        color: AppColors.brightGold,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  win['date'],
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'အနိုင်ရငွေ',
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 12,
                ),
              ),
              Text(
                '${win['winAmount'].toStringAsFixed(0)} ကျပ်',
                style: TextStyle(
                  color: AppColors.brightGold,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
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
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: AppColors.textGrey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
