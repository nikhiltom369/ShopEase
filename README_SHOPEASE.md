# ShopEase - Flutter Shopping App

A modern, professional Flutter application showcasing a beautiful e-commerce platform with product listing and details. This is a production-ready Flutter app built for internship screening tasks.

## 📋 Features

✅ **Splash Screen**
- Smooth fade and scale animations
- Auto-navigation after 3 seconds
- Professional branding

✅ **Home Screen**
- Responsive GridView product listing
- Fetches real data from FakeStore API
- Shimmer loading skeleton
- Error handling with retry button
- Pull-to-refresh functionality

✅ **Product Detail Screen**
- Hero animation on product images
- Large product image with caching
- Product title, description, price, and category
- Star rating display
- Favorite button
- Add to cart and Buy now buttons
- Scrollable responsive layout

✅ **UI/UX Features**
- Modern minimal design
- Light theme with professional colors
- Google Fonts (Poppins)
- Cached network images
- Smooth animations
- Responsive on mobile and tablet
- Proper spacing and padding

✅ **Architecture**
- Clean folder structure (models, services, screens, widgets, utils)
- Reusable widgets and components
- Proper state management with setState and FutureBuilder
- Comprehensive error handling
- Modular and maintainable code

## 📱 App Structure

```
lib/
├── main.dart                 # App entry point and routing
├── models/
│   └── product.dart         # Product and Rating models
├── services/
│   └── api_service.dart     # API calls to FakeStore API
├── screens/
│   ├── splash_screen.dart   # Splash screen with animations
│   ├── home_screen.dart     # Product listing screen
│   └── product_detail_screen.dart  # Product details screen
├── widgets/
│   ├── product_card.dart    # Reusable product card widget
│   ├── product_shimmer_loading.dart  # Loading skeleton
│   ├── error_display_widget.dart     # Error UI component
│   └── rating_widget.dart   # Star rating display widget
└── utils/
    ├── app_colors.dart      # Color constants
    ├── app_constants.dart   # App-wide constants
    └── app_text_styles.dart # Text styles with Google Fonts
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.11.5 or higher)
- Dart SDK
- Android Studio or Xcode (for device emulation)
- Internet connection (for API calls)

### Installation Steps

1. **Clone or navigate to the project**
   ```bash
   cd shopease
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### First Run Troubleshooting

If you encounter any issues:

```bash
# Clean build artifacts
flutter clean

# Get fresh dependencies
flutter pub get

# Build again
flutter run
```

## 📦 Dependencies

The app uses the following packages:

- **provider** (^6.0.0) - State management
- **http** (^1.1.0) - HTTP requests for API calls
- **google_fonts** (^6.1.0) - Beautiful custom fonts
- **cached_network_image** (^3.2.3) - Image caching and optimization
- **shimmer** (^3.0.0) - Loading skeleton animations

## 🎨 Design System

### Colors
- **Primary**: `#6200EE` (Purple) - Main brand color
- **Accent**: `#03DAC6` (Teal) - Highlights
- **Error**: `#B00020` (Red) - Error states
- **Background**: `#FAFAFA` (Light Gray)
- **Surface**: `#FFFFFF` (White)

### Typography
All text uses **Google Fonts Poppins** for a modern look:
- Display: 24-32px (Bold)
- Headline: 16-20px (Semi-bold)
- Body: 12-16px (Regular)
- Label: 10-14px (Medium)

### Spacing
- Extra Small: 4px
- Small: 8px
- Medium: 16px
- Large: 24px
- Extra Large: 32px

## 🔌 API Integration

The app fetches data from **FakeStore API**:
- **Base URL**: `https://fakestoreapi.com`
- **Endpoints Used**:
  - `GET /products` - Fetch all products
  - `GET /products/{id}` - Fetch single product
  - `GET /products/category/{category}` - Fetch by category

## 🎯 Key Features Implementation

### 1. **Splash Screen**
- Uses `AnimationController` for smooth animations
- Combines `FadeTransition` and `ScaleTransition`
- Auto-navigates using `Future.delayed()`

### 2. **API Service**
- Centralized HTTP client with timeout handling
- Error messages for user feedback
- JSON parsing with model classes

### 3. **Product Listing**
- `FutureBuilder` for async data loading
- Shimmer skeleton while loading
- Grid layout with responsive columns
- Pull-to-refresh functionality

### 4. **Product Details**
- Hero animation for smooth image transition
- Scrollable layout for responsive design
- Favorites toggle functionality
- Call-to-action buttons

### 5. **State Management**
- Simple `setState` for local state
- `FutureBuilder` for async operations
- Clean separation of concerns

## 🧪 Testing the App

### Test Scenarios

1. **Splash Screen**
   - Launch app and verify splash screen displays
   - Check fade and scale animations
   - Verify automatic navigation after 3 seconds

2. **Home Screen**
   - Verify products load from API
   - Check shimmer loading skeleton
   - Test error handling by going offline
   - Verify pull-to-refresh works

3. **Product Details**
   - Tap on product to navigate
   - Verify hero animation on image
   - Check all product details display correctly
   - Test favorite button toggle
   - Test cart and buy buttons (show snackbar)

4. **Responsive Design**
   - Test on portrait and landscape modes
   - Verify grid layout adapts (2 cols portrait, 3 cols landscape)
   - Test on different screen sizes

## 🔧 Development Tips

### Hot Reload
Use hot reload to see changes instantly:
```bash
flutter run
# Press 'r' in terminal for hot reload
# Press 'R' for hot restart
```

### Debug Logging
Add debugging to services:
```dart
debugPrint('Loading products...');
```

### Check Device
```bash
flutter devices
```

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (12.0+)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🎓 Learning Points

This project demonstrates:
- Flutter widget hierarchy and composition
- State management with FutureBuilder
- API integration and error handling
- Responsive design patterns
- Animation implementation
- Theme customization
- Code organization and architecture
- Reusable components
- Google Fonts integration
- Image caching strategies

## 📝 Code Standards

The code follows Flutter best practices:
- Proper naming conventions
- Comprehensive comments
- DRY (Don't Repeat Yourself) principle
- Separation of concerns
- Const constructors for performance
- Proper error handling
- Type safety

## 🐛 Known Limitations

- Buy and Add to Cart buttons are UI only (dummy functionality)
- No local persistence
- No user authentication
- API calls limited by FakeStore API rate limits

## 🚀 Future Enhancements

- [ ] Search functionality
- [ ] Category filtering
- [ ] Dark mode implementation
- [ ] Local cart storage with Hive
- [ ] Product reviews and comments
- [ ] User authentication with Firebase
- [ ] Payment integration
- [ ] Order tracking
- [ ] Wishlist with persistence

## 📄 License

This project is open source and available for educational purposes.

## 👨‍💻 Author

Built as a professional Flutter internship screening project.

---

## ❓ Troubleshooting

### App doesn't start
```bash
flutter clean
flutter pub get
flutter run -v
```

### API errors
- Check internet connection
- Verify FakeStore API is accessible: https://fakestoreapi.com/products
- Check timeout in `api_service.dart` (default: 30 seconds)

### Image caching issues
- Clear app cache
- Restart the app

### Build errors
```bash
flutter doctor
flutter clean
flutter pub get
flutter pub upgrade
```

---

**Happy coding! 🎉**
