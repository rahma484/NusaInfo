import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/post.dart'; // Mengimpor post.dart yang berisi Post & Comment

class PostService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Mengambil daftar pengumuman (GET /posts)
  Future<List<Post>> getPosts() async {
    try {
      final Uri url = Uri.parse('$_baseUrl/posts');
      final http.Response response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception(
          'Gagal mengambil data pengumuman. Kode status: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception(
        'Tidak ada koneksi internet. Pastikan perangkat terhubung ke jaringan.',
      );
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Mengambil komentar pengumuman tertentu (GET /posts/{id}/comments)
  Future<List<Comment>> getComments(int postId) async {
    try {
      final Uri url = Uri.parse('$_baseUrl/posts/$postId/comments');
      final http.Response response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Comment.fromJson(json)).toList();
      } else {
        throw Exception(
          'Gagal memuat komentar. Kode status: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('Gagal memuat komentar: Tidak ada koneksi internet.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Menambahkan pengumuman baru (POST /posts)
  Future<Post> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    try {
      final Uri url = Uri.parse('$_baseUrl/posts');
      final Map<String, dynamic> payload = {
        'title': title,
        'body': body,
        'userId': userId,
      };

      final http.Response response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        return Post.fromJson(jsonData);
      } else {
        throw Exception(
          'Gagal mempublikasikan pengumuman. Kode status: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('Gagal mengirim data: Tidak ada koneksi internet.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Menambahkan komentar baru (POST /posts/{postId}/comments)
  Future<Comment> addComment({
    required int postId,
    required String name,
    required String email,
    required String body,
  }) async {
    try {
      final Uri url = Uri.parse('$_baseUrl/posts/$postId/comments');
      final Map<String, dynamic> payload = {
        'postId': postId,
        'name': name,
        'email': email,
        'body': body,
      };

      final http.Response response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        return Comment.fromJson(jsonData);
      } else {
        throw Exception(
          'Gagal mengirim komentar. Kode status: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception('Gagal mengirim komentar: Tidak ada koneksi internet.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
