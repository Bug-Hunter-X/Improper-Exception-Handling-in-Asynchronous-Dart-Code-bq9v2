```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchData() async {
  int retries = 3;
  while (retries > 0) {
    try {
      final response = await http.get(Uri.parse('https://example.com/data'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      print('Error fetching data (attempt ${4 - retries}): $e');
      retries--;
      if (retries == 0) {
        rethrow; // Re-throw after all retries fail
      }
      await Future.delayed(Duration(seconds: 2)); // Wait before retrying
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }
  return null; // Return null if all retries fail
}
```