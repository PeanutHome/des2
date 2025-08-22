# Burmese Lottery App

A Flutter application for Burmese lottery betting with a modern, responsive design.

## Features

- **Login System**: Two authentication methods
  - Email & Password login
  - OTP (One-Time Password) login
- **Responsive Design**: Works on mobile, tablet, and web
- **Real-time Data**: Live lottery results from API
- **Multiple Betting Options**: 2D Morning, 2D Evening, and 3D betting
- **User Management**: Profile, wallet, and transaction history
- **Settings**: Customizable app preferences

## Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Login System

The app now starts with a login screen that offers two authentication methods:

### Email & Password Login/Register
- **Login**: Enter any valid email format and password (6+ characters)
- **Register**: Create new account with email and password
- **Toggle**: Easily switch between login and register modes
- For demo purposes, any valid credentials will work

### OTP Login
- Enter any 4+ digit number as OTP
- Includes a "Resend OTP" option
- For demo purposes, any 4+ digit number will work

### Authentication Flow
1. App starts with login screen
2. After successful login, user is taken to the main app with tab navigation
3. User can logout from Settings → Profile tab
4. Logout returns user to login screen

## Project Structure

```
lib/
├── constants/
│   └── app_colors.dart          # App color scheme
├── screens/
│   ├── login_screen.dart        # Login screen with tabs
│   ├── homepage.dart            # Main app with tab navigation
│   ├── two_d_morning.dart      # 2D Morning betting
│   ├── two_d_evening.dart      # 2D Evening betting
│   ├── three_d_betting.dart    # 3D betting
│   ├── wallet_page.dart        # User wallet
│   ├── profile_page.dart       # User profile
│   ├── history_page.dart       # Betting history
│   └── settings_page.dart      # App settings
├── services/
│   └── auth_service.dart       # Authentication management
├── widgets/                    # Reusable UI components
└── main.dart                  # App entry point
```

## Dependencies

- `flutter`: Core Flutter framework
- `http`: For API calls to lottery data
- `provider`: For state management and authentication

## Demo Credentials

For testing purposes, you can use:

**Email & Password:**
- Email: `test@example.com`
- Password: `123456`

**Registration:**
- Any valid email format
- Password must be at least 6 characters

**OTP:**
- Any 4+ digit number (e.g., `1234`, `567890`)

## Features

- **Responsive Layout**: Adapts to different screen sizes
- **Dark Theme**: Consistent with app branding
- **Burmese Language Support**: UI elements in Burmese
- **Real-time Updates**: Lottery results update every 30 seconds
- **Tab Navigation**: Easy access to different sections
- **Form Validation**: Input validation for login forms

## Development Notes

- The app uses Provider for state management
- Authentication is simulated for demo purposes
- API calls are made to `https://api.thaistock2d.com/live`
- The app follows Material Design 3 guidelines
- Responsive design wrapper limits width on larger screens for mobile-like experience

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is for educational and demonstration purposes.
