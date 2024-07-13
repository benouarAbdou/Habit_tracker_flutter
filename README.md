# Habit Tracker App

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Contributing](#contributing)
- [Credits](#credits)
- [License](#license)

## Overview

The Habit Tracker App is a Flutter-based mobile application designed to help users build and maintain positive habits. This app allows users to create, track, and visualize their daily habits, providing a simple and intuitive interface for habit management.

This project is based on the tutorial by Mitch Koko: [Mitch koko](https://www.youtube.com/watch?v=2VKpq4h3Sdw)

## Features

- **Habit Management**: Add, edit, and delete habits
- **Daily Tracking**: Mark habits as completed for each day
- **Heat Map Visualization**: View habit completion trends over time
- **Streak Tracking**: Monitor current and longest streaks for motivation
- **Persistence**: Local data storage for offline access
- **Clean UI**: Intuitive and visually appealing user interface

## Technologies Used

- **Flutter**: UI framework for building natively compiled applications
- **Dart**: Programming language used with Flutter
- **Hive**: Lightweight and fast NoSQL database for local storage
- **hive_flutter**: Flutter extension for Hive
- **fl_chart**: Charting library for Flutter (used for heat map visualization)

## Project Structure

The project is structured as follows:

- `lib/`
  - `components/`: Reusable UI components
  - `data/`: Data management and database operations
  - `functions/`: Utility functions (e.g., date formatting)
  - `main.dart`: Entry point of the application

Key files:

- `habitDb.dart`: Manages habit data and heat map calculations
- `main.dart`: Contains the main UI and app logic
- `dateTime.dart`: Provides date formatting and conversion utilities

## Getting Started

To run this project locally:

1. Ensure you have Flutter installed on your machine
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Connect a device or start an emulator
5. Run `flutter run` to start the app

## Usage

1. **Adding a Habit**: Tap the floating action button and enter the habit name
2. **Completing a Habit**: Check the box next to a habit to mark it as complete for the day
3. **Editing a Habit**: Long press on a habit to edit its name
4. **Deleting a Habit**: Swipe left on a habit to delete it
5. **Viewing Progress**: Check the heat map at the top of the screen to see your habit completion trends

## Contributing

Contributions to improve the Habit Tracker App are welcome. Please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Credits

This project was created following the tutorial by [Mitch Koko](https://www.youtube.com/watch?v=2VKpq4h3Sdw). Special thanks to Mitch for the excellent guidance and inspiration.

## License

This project is open source and available under the [MIT License](LICENSE).
