# Blaze 🔥

A vibrant, modern location-based collectible battle arena game built with Flutter.

## Game Overview

**Blaze** is a fast-paced mobile game where you hunt down and claim rare collectible creatures scattered across your neighborhood. Battle other players, customize your collection, and climb the global ranks.

### Core Features

- 🗺️ **Real-time Map**: Hunt creatures in your actual location
- 🎨 **Vibrant Characters**: Hundreds of unique, colorful collectible creatures
- ⚡ **Fast-Paced Battles**: Quick, arcade-style PvP combat
- 🏆 **Progression System**: Level up, unlock rare creatures, earn rewards
- 👥 **Social Features**: Leaderboards, guilds, and competitive events
- 🎁 **Daily Rewards**: Complete challenges and claim daily bonuses

## Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Firestore, Authentication, Cloud Functions)
- **Maps**: Google Maps API
- **State Management**: Provider
- **UI**: Material Design 3, Google Fonts, Lottie Animations

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/                   # Data models
│   ├── creature.dart
│   ├── player.dart
│   └── territory.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   └── game_provider.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── map_screen.dart
│   ├── collection_screen.dart
│   └── profile_screen.dart
└── theme/                    # App theming
    └── app_theme.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Firebase Project
- Android Studio or Xcode

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/n1ght-sh4dow/blaze.git
   cd blaze
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Configure Firebase
   - Create a Firebase project
   - Follow [FlutterFire setup](https://firebase.flutter.dev/docs/overview/)
   - Update `firebase_options.dart` with your credentials

4. Run the app
   ```bash
   flutter run
   ```

## Features in Development

- [ ] Google Maps integration with real-time creature spawns
- [ ] Battle system with turn-based mechanics
- [ ] Creature evolution and leveling
- [ ] Guild system and guild wars
- [ ] Seasonal events and limited-time creatures
- [ ] In-app shop and cosmetics
- [ ] Push notifications
- [ ] Voice chat for guilds

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and feature requests, please open an issue on GitHub.

---

**Claim. Battle. Dominate.** 🔥
