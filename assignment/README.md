# Assignment: Flutter Send Money App

This Flutter project implements a simple "Send Money" application with the following features:

## Features

- **Send Money Page**: 
  - Input fields for recipient name and amount.
  - Dropdown to select the payment method (Bank Transfer, Credit Card, PayPal).
  - Switch to mark the transaction as a favorite.
  - Form validation to ensure all inputs are valid.
  - A success dialog with an animation after completing the transaction.
  - Automatically clears the form after a successful transaction.

- **Custom Button**:
  - A reusable button widget with consistent styling.

- **Page Transition Animation**:
  - Smooth slide transition for navigating between pages.

## Screenshots

_Add screenshots of the app here if available._

## Getting Started

To run the project:

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd assignment
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## File Structure

```
lib/
├── main.dart                # Entry point of the application
├── send_money_page.dart     # Send Money page implementation
├── custom_button.dart       # Reusable custom button widget
├── animations/
│   └── page_transition.dart # Custom page transition animation
```

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

## License

This project is licensed under the MIT License.
