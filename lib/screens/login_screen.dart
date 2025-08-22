import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isLoginMode = true; // Toggle between login and register

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Pre-fill with dummy data for easy testing
    _emailController.text = 'test@example.com';
    _passwordController.text = '123456';
    _phoneController.text = '+959123456789';
    _otpController.text = '1234';
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailLogin() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading for 1 second
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    // Always succeed - it's a dummy page!
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.loginWithEmail(_emailController.text, _passwordController.text);
  }

  Future<void> _handleEmailRegister() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading for 1 second
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registration successful! Please login.'),
          backgroundColor: AppColors.brightGold,
        ),
      );
      setState(() {
        _isLoginMode = true;
      });
    }
  }

  Future<void> _handleOtpLogin() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading for 1 second
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    // Always succeed - it's a dummy page!
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.loginWithOtp(_otpController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // App Logo/Title
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.accentGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.accentGold.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.casino,
                  size: 60,
                  color: AppColors.brightGold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Burmese Lottery',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              Text(
                _isLoginMode ? 'Welcome back!' : 'Create your account',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(height: 40),
              
              // Enhanced Tab Bar with better styling
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.accentGold.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentGold.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accentGold,
                        AppColors.brightGold,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGold.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: AppColors.primaryBackground,
                  unselectedLabelColor: AppColors.textGrey,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  tabs: const [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email, size: 20),
                          SizedBox(width: 8),
                          Text('Email'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.security, size: 20),
                          SizedBox(width: 8),
                          Text('OTP'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildEmailPasswordTab(),
                    _buildOtpTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailPasswordTab() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.accentGold.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentGold.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _emailController,
              style: TextStyle(color: AppColors.textWhite),
              decoration: InputDecoration(
                hintText: 'Enter your email (any email works)',
                hintStyle: TextStyle(color: AppColors.textGrey),
                prefixIcon: Icon(Icons.email, color: AppColors.accentGold),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Password Field
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.accentGold.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentGold.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: AppColors.textWhite),
              decoration: InputDecoration(
                hintText: 'Enter your password (any password works)',
                hintStyle: TextStyle(color: AppColors.textGrey),
                prefixIcon: Icon(Icons.lock, color: AppColors.accentGold),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Action Button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _isLoading ? null : (_isLoginMode ? _handleEmailLogin : _handleEmailRegister),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGold,
                foregroundColor: AppColors.primaryBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                shadowColor: AppColors.accentGold.withOpacity(0.3),
              ),
              child: _isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBackground,
                        ),
                      ),
                    )
                  : Text(
                      _isLoginMode ? 'Login' : 'Register',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Toggle between Login and Register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isLoginMode ? "Don't have an account? " : "Already have an account? ",
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLoginMode = !_isLoginMode;
                  });
                },
                child: Text(
                  _isLoginMode ? 'Register' : 'Login',
                  style: TextStyle(
                    color: AppColors.accentGold,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtpTab() {
    return Column(
      children: [
        // Phone Number Field
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColors.accentGold.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGold.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _phoneController,
            style: TextStyle(color: AppColors.textWhite),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Enter phone number (any number works)',
              hintStyle: TextStyle(color: AppColors.textGrey),
              prefixIcon: Icon(Icons.phone, color: AppColors.accentGold),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // OTP Field
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColors.accentGold.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGold.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _otpController,
            style: TextStyle(color: AppColors.textWhite),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter OTP (any 4+ digits work)',
              hintStyle: TextStyle(color: AppColors.textGrey),
              prefixIcon: Icon(Icons.security, color: AppColors.accentGold),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Resend OTP Button
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('OTP resent to your phone'),
                backgroundColor: AppColors.brightGold,
              ),
            );
          },
          child: Text(
            'Resend OTP',
            style: TextStyle(
              color: AppColors.accentGold,
              fontSize: 16,
            ),
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Login Button
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleOtpLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGold,
              foregroundColor: AppColors.primaryBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0,
              shadowColor: AppColors.accentGold.withOpacity(0.3),
            ),
            child: _isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryBackground,
                      ),
                    ),
                  )
                : const Text(
                    'Login with OTP',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
