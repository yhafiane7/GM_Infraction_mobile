import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/services/data_repository.dart';

/// Controller for managing Categorie business logic and state
class CategorieController extends ChangeNotifier {
  CategorieController();

  // State management
  bool _isLoading = false;
  String? _errorMessage;
  final List<Categorie> _categories = [];

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Categorie> get categories => _categories;

  /// Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// Load categories (if needed in the future)
  Future<void> loadCategories() async {
    _setLoading(true);
    _setError(null);

    try {
      // This would be implemented if we need to load categories
      // For now, categories are passed from parent widget
      _setLoading(false);
    } catch (e) {
      _setError('Failed to load categories: $e');
      _setLoading(false);
    }
  }

  /// Create a new categorie
  Future<String> createCategorie(Categorie categorie) async {
    _setLoading(true);
    _setError(null);

    try {
      final result = await UiService.performCategorieCreate(categorie);
      _setLoading(false);
      return result;
    } catch (e) {
      _setError('Failed to create categorie: $e');
      _setLoading(false);
      return 'Error: Failed to create categorie';
    }
  }

  /// Update an existing categorie
  Future<String> updateCategorie(int index, Categorie categorie) async {
    _setLoading(true);
    _setError(null);

    try {
      // Use the category's ID instead of the array index
      final categoryId = categorie.id!;
      final result =
          await UiService.performCategorieUpdate(categoryId, categorie);
      _setLoading(false);
      return result;
    } catch (e) {
      _setError('Failed to update categorie: $e');
      _setLoading(false);
      return 'Error: Failed to update categorie';
    }
  }

  /// Delete a categorie
  Future<String> deleteCategorie(int index, Categorie categorie) async {
    _setLoading(true);
    _setError(null);

    try {
      // Use the category's ID instead of the array index
      final categoryId = categorie.id!;
      final result =
          await UiService.performCategorieDelete(categoryId, categorie);
      _setLoading(false);
      return result;
    } catch (e) {
      _setError('Failed to delete categorie: $e');
      _setLoading(false);
      return 'Error: Failed to delete categorie';
    }
  }

  /// Get a single categorie by ID
  Future<Categorie> getCategorie(int id) async {
    try {
      return await DataRepository.getCategorie(id);
    } catch (e) {
      throw Exception('Failed to fetch categorie: $e');
    }
  }

  /// Clear error message
  void clearError() {
    _setError(null);
  }
}
