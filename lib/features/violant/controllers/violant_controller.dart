import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/services/data_repository.dart';

class ViolantController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final List<Violant> _violants = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Violant> get violants => _violants;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadViolants() async {
    _setLoading(true);
    _setError(null);
    try {
      final items = await DataRepository.fetchViolants();
      _violants
        ..clear()
        ..addAll(items);
    } catch (e) {
      _setError('Failed to load violants: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<String> createViolant(Violant violant) async {
    _setLoading(true);
    _setError(null);
    try {
      final result = await UiService.performViolantCreate(violant);
      return result;
    } catch (e) {
      _setError('Failed to create violant: $e');
      return 'Error: Failed to create violant';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> updateViolant(int index, Violant violant) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = violant.id ?? index;
      final result = await UiService.performViolantUpdate(id, violant);
      return result;
    } catch (e) {
      _setError('Failed to update violant: $e');
      return 'Error: Failed to update violant';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> deleteViolant(int index, Violant violant) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = violant.id ?? index;
      final result = await UiService.performViolantDelete(id, violant);
      return result;
    } catch (e) {
      _setError('Failed to delete violant: $e');
      return 'Error: Failed to delete violant';
    } finally {
      _setLoading(false);
    }
  }

  Future<Violant> getViolant(int id) async {
    try {
      return await DataRepository.getViolant(id);
    } catch (e) {
      throw Exception('Failed to fetch violant: $e');
    }
  }

  void clearError() {
    _setError(null);
  }
}
