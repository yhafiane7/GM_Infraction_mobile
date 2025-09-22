import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/services/data_repository.dart';

class CommuneController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final List<Commune> _communes = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Commune> get communes => _communes;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadCommunes() async {
    _setLoading(true);
    _setError(null);
    try {
      final items = await UiService.buildCommuneList();
      _communes
        ..clear()
        ..addAll(items);
    } catch (e) {
      _setError('Failed to load communes: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<String> createCommune(Commune commune) async {
    _setLoading(true);
    _setError(null);
    try {
      final result = await UiService.performCommuneCreate(commune);
      return result;
    } catch (e) {
      _setError('Failed to create commune: $e');
      return 'Error: Failed to create commune';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> updateCommune(int index, Commune commune) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = commune.id!;
      final result = await UiService.performCommuneUpdate(id, commune);
      return result;
    } catch (e) {
      _setError('Failed to update commune: $e');
      return 'Error: Failed to update commune';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> deleteCommune(int index, Commune commune) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = commune.id!;
      final result = await UiService.performCommuneDelete(id, commune);
      return result;
    } catch (e) {
      _setError('Failed to delete commune: $e');
      return 'Error: Failed to delete commune';
    } finally {
      _setLoading(false);
    }
  }

  Future<Commune> getCommune(int id) async {
    try {
      return await DataRepository.getCommune(id);
    } catch (e) {
      throw Exception('Failed to fetch commune: $e');
    }
  }

  void clearError() {
    _setError(null);
  }
}
