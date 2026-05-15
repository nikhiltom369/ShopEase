import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

/// API Service class for handling all HTTP requests
/// Uses FakeStore API for fetching products
class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  /// Fetch all products from the API
  /// Throws an exception if the request fails
  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/products'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception(
              'Request timeout. Please check your internet connection.',
            ),
          );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load products. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  /// Fetch products by category
  static Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/products/category/$category'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load category products');
      }
    } catch (e) {
      throw Exception('Error fetching category products: $e');
    }
  }

  /// Fetch a single product by ID
  static Future<Product> fetchProductById(int id) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/products/$id'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }
}
