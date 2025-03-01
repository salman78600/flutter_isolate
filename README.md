# flutter_isolate

A new Flutter project.

## Getting Started

This Flutter project demonstrates the usage of Isolates to perform heavy computations without blocking the UI.

Flutter runs code in a single-threaded environment by default, meaning expensive operations can freeze the UI. To solve this, Isolates allow running computations in a separate memory space, ensuring a smooth user experience.

# Features

Task 1 (Blocking UI): Runs a heavy calculation synchronously on the main thread, causing the UI to freeze.

Task 2 (Non-Blocking UI using Isolate): Runs the same heavy calculation in a separate Isolate, ensuring the UI remains responsive.

GIF Animation: A continuously running animation to visually check if the UI is blocked.

## How to Run the Project

Clone the repository.

Ensure you have Flutter SDK installed.

# Run the following command:

flutter pub get
flutter run

Observe the difference between Task 1 and Task 2.
