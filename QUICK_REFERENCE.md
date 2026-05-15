# ShopEase - Quick Reference Guide

A quick lookup guide for developers working on the ShopEase Flutter project.

---

## 🚀 One-Command Start

```bash
cd shopease && flutter pub get && flutter run
```

---

## 📂 File Locations Quick Reference

| Component | File Path |
|-----------|-----------|
| App Entry Point | `lib/main.dart` |
| Splash Screen | `lib/screens/splash_screen.dart` |
| Home Screen | `lib/screens/home_screen.dart` |
| Product Detail | `lib/screens/product_detail_screen.dart` |
| Product Model | `lib/models/product.dart` |
| API Service | `lib/services/api_service.dart` |
| Product Card Widget | `lib/widgets/product_card.dart` |
| Loading Skeleton | `lib/widgets/product_shimmer_loading.dart` |
| Error Widget | `lib/widgets/error_display_widget.dart` |
| Rating Widget | `lib/widgets/rating_widget.dart` |
| Colors | `lib/utils/app_colors.dart` |
| Constants | `lib/utils/app_constants.dart` |
| Text Styles | `lib/utils/app_text_styles.dart` |
| Dependencies | `pubspec.yaml` |

---

## 🎨 Common UI Customizations

### Change Primary Color
Edit `lib/utils/app_colors.dart`:
```dart
static const Color primary = Color(0xFF6200EE);  // Change this
```

### Change App Name
Edit `lib/utils/app_constants.dart`:
```dart
static const String appName = 'ShopEase';  // Change this
```

### Add New Button Style
Edit `lib/main.dart` in `ThemeData`:
```dart
// Add to elevatedButtonTheme or create new buttonTheme
```

### Change Font
Edit `lib/main.dart`:
```dart
textTheme: GoogleFonts.robotoTextTheme(  // Change to any Google Font
  Theme.of(context).textTheme,
),
```

---

## 🔌 API Integration Quick Reference

### Add New API Endpoint
Edit `lib/services/api_service.dart`:
```dart
static Future<List<Product>> fetchNewData() async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/your-endpoint'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(const Duration(seconds: 30));
    
    if (response.statusCode == 200) {
      // Parse and return data
    } else {
      throw Exception('Failed to load');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
```

### FakeStore API Endpoints
- `GET /products` - All products
- `GET /products/{id}` - Single product
- `GET /products/category/{category}` - Products by category
- `GET /products/categories` - All categories

---

## 🎯 Common Task Solutions

### 1. Add Dark Mode
```dart
// In main.dart, add darkTheme parameter
darkTheme: ThemeData.dark().copyWith(
  primaryColor: AppColors.primary,
  // ... other theme properties
),
```

### 2. Add New Screen
```dart
// 1. Create lib/screens/new_screen.dart
// 2. Add route in main.dart routes map:
routes: {
  '/new': (context) => const NewScreen(),
}
// 3. Navigate using:
Navigator.of(context).pushNamed('/new');
```

### 3. Add Search Functionality
```dart
// In home_screen.dart, add SearchBar widget
// Filter products list based on search query
List<Product> filtered = products
    .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
    .toList();
```

### 4. Save Favorites to Local Storage
```dart
// Add hive or shared_preferences package
// Save to local database:
// SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs.setStringList('favorites', favoriteIds);
```

### 5. Add Error Boundary
```dart
// Wrap FutureBuilder with error boundary:
try {
  return FutureBuilder(
    future: _productsFuture,
    builder: (context, snapshot) { ... }
  );
} catch (e) {
  return Center(child: Text('Error: $e'));
}
```

---

## 📱 Widget Component Reference

### ProductCard Widget
```dart
ProductCard(
  product: product,
  onTap: () => _navigateToDetail(product),
)
```

### Error Display Widget
```dart
ErrorDisplayWidget(
  message: 'Failed to load products',
  onRetry: _retryFetchProducts,
  icon: Icons.error_outline,
)
```

### Rating Widget
```dart
RatingWidget(
  rate: 4.5,
  count: 120,
)
```

### Product Shimmer Loading
```dart
ProductShimmerLoading(
  itemCount: 6,
)
```

---

## 🎓 State Management Patterns

### FutureBuilder Pattern
```dart
FutureBuilder<List<Product>>(
  future: ApiService.fetchProducts(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return ProductShimmerLoading();
    }
    if (snapshot.hasError) {
      return ErrorDisplayWidget(
        message: snapshot.error.toString(),
        onRetry: () => setState(() {}),
      );
    }
    return GridView(items: snapshot.data);
  },
)
```

### setState Pattern
```dart
setState(() {
  _isFavorite = !_isFavorite;
});
```

### Animation Pattern
```dart
AnimationController _controller = AnimationController(
  duration: Duration(milliseconds: 500),
  vsync: this,
);

Animation<double> _animation = Tween<double>(begin: 0, end: 1)
    .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
```

---

## 🔍 Debugging Commands

| Command | Purpose |
|---------|---------|
| `flutter run` | Run app on connected device |
| `flutter run -v` | Run with verbose output |
| `flutter run --profile` | Run in profile mode |
| `flutter clean` | Clean build artifacts |
| `flutter pub get` | Get dependencies |
| `flutter pub upgrade` | Upgrade dependencies |
| `flutter analyze` | Check for lint issues |
| `flutter doctor` | Check environment setup |
| `flutter devices` | List connected devices |

---

## 🎨 Color Codes Quick Access

```dart
// Primary Colors
#6200EE  - Primary (Purple)
#3700B3  - Primary Dark
#03DAC6  - Accent (Teal)

// Neutral Colors
#FAFAFA  - Background
#FFFFFF  - Surface
#F0F0F0  - Divider
#E0E0E0  - Border

// Text Colors
#212121  - Text Primary (Dark)
#757575  - Text Secondary (Gray)
#BDBDBD  - Text Hint (Light Gray)

// Status Colors
#4CAF50  - Success (Green)
#B00020  - Error (Red)
#FFC107  - Warning (Yellow)
#2196F3  - Info (Blue)
```

---

## 📦 Adding New Dependencies

```bash
# Add package
flutter pub add package_name

# Add dev dependency
flutter pub add --dev package_name

# Update to latest version
flutter pub upgrade package_name

# Get specific version
flutter pub add package_name:1.2.3
```

---

## 🚦 Common Error Solutions

### Error: "Unable to connect to API"
```
✓ Check internet connection
✓ Verify API URL is correct
✓ Check firewall/proxy settings
✓ Verify timeout duration (30s default)
```

### Error: "Image failed to load"
```
✓ Check image URL is valid
✓ Verify network connection
✓ Check image format is supported (PNG, JPG, GIF, WebP)
✓ Clear app cache and restart
```

### Error: "Dependency version conflict"
```
✓ Run: flutter pub get
✓ Run: flutter clean
✓ Check pubspec.yaml for conflicts
✓ Run: flutter pub upgrade
```

### Error: "Widget overflow"
```
✓ Add SingleChildScrollView wrapper
✓ Reduce padding/margins
✓ Use Flexible/Expanded widgets
✓ Check device screen size
```

---

## 💡 Performance Tips

1. **Use const widgets** - Prevents unnecessary rebuilds
   ```dart
   const SizedBox(height: 16)
   ```

2. **Cache images** - Using CachedNetworkImage
   ```dart
   CachedNetworkImage(imageUrl: url)
   ```

3. **Lazy load lists** - Use ListView.builder
   ```dart
   GridView.builder()
   ```

4. **Debounce searches** - Prevent excessive API calls
   ```dart
   Future.delayed(Duration(milliseconds: 500))
   ```

5. **Use Hero animations** - Smooth transitions
   ```dart
   Hero(tag: 'tag', child: widget)
   ```

---

## 🎯 Navigation Shortcuts

```dart
// Push new screen
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => NewScreen()),
);

// Named navigation
Navigator.of(context).pushNamed('/route-name');

// Replace current screen
Navigator.of(context).pushReplacementNamed('/route-name');

// Pop back
Navigator.of(context).pop();

// Pop until specific route
Navigator.of(context).popUntil((route) => route.isFirst);
```

---

## 📊 Data Model Quick Reference

### Product Model
```dart
Product(
  id: int,
  title: String,
  price: double,
  description: String,
  category: String,
  image: String,
  rating: Rating?,
)
```

### Rating Model
```dart
Rating(
  rate: double,
  count: int,
)
```

---

## 🌐 Supported Platforms

```
✅ Android (API 21+)
✅ iOS (12.0+)
✅ Web
✅ Windows
✅ macOS
✅ Linux
```

---

## 📋 Deployment Checklist

Before releasing:

- [ ] Update version in pubspec.yaml
- [ ] Update app icon and splash screen
- [ ] Test on multiple devices
- [ ] Run `flutter analyze` and fix issues
- [ ] Remove debug code and print statements
- [ ] Set debugShowCheckedModeBanner to false (already done)
- [ ] Test with `flutter run --profile`
- [ ] Create build: `flutter build apk/ios/web`

---

## 🔗 Useful Links

- Flutter Docs: https://flutter.dev/docs
- Dart Docs: https://dart.dev
- Material Design: https://material.io/design
- Google Fonts: https://fonts.google.com
- FakeStore API: https://fakestoreapi.com
- Pub.dev Packages: https://pub.dev

---

## 📞 Quick Help

| Issue | Solution |
|-------|----------|
| App won't start | `flutter clean && flutter pub get && flutter run` |
| Image not loading | Check URL, verify internet, clear cache |
| API timeout | Increase timeout duration in api_service.dart |
| Widget overflow | Wrap with SingleChildScrollView or reduce padding |
| Hot reload not working | Press R for hot restart |
| Lint errors | Run `flutter analyze` and review warnings |

---

**Last Updated**: May 2026
**Version**: 1.0.0
**Status**: Production Ready ✨
