# Calendar App

## Overview

**Calendar App** is a mobile application that helps users manage their events efficiently. Users can add events by providing a title, start date, and end date. The app stores the events locally using Core Data and displays them with a clean and visually appealing user interface. This app is designed to streamline event management while offering a delightful user experience.

## Features

- Add events with a title, start date, and end date.
- Local event storage using Core Data for offline access.
- Display events in a visually appealing and user-friendly interface.

## Technologies Used

- **UIKit**: Framework for building the user interface programmatically.
- **Core Data**: For local storage of events.
- **DatePicker**: For selecting start and end dates of events.
- **RxSwift**: For managing asynchronous data flows and updates.
- **Swinject**: For implementing dependency injection.
- **SnapKit**: For creating Auto Layout constraints programmatically with ease.
- **MVVM**: Architectural pattern for better code organization and maintainability.
- **XCTest**: For writing unit tests, including testing the Core Data manager.

## Screenshots

| Home Screen | Add Event Screen |
|-------------|------------------|
| ![Home](https://github.com/user-attachments/assets/749f08c8-647f-4ec3-b54d-c27ae9c3c792) | ![AddEvent](https://github.com/user-attachments/assets/428f99bf-4d0c-4a72-ab8f-390e0aacf6ae) |

## Installation

To install and run the Calendar App, follow these steps:

1. Clone the repository.
2. Navigate to the `CalendarApp` folder.
3. Open the project in Xcode.
4. Run it on a simulator or a real device.

## Testing

The Core Data manager has been thoroughly tested using **XCTest** to ensure reliability and data integrity.

## Contributing

If you encounter any bugs or have suggestions for improvements, feel free to open an issue or submit a pull request. Contributions are welcome!
