import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/models/infraction_model.dart';
import 'package:gmsoft_infractions_mobile/services/ui_service.dart';
import 'package:gmsoft_infractions_mobile/services/data_repository.dart';

class InfractionController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final List<Infraction> _infractions = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Infraction> get infractions => _infractions;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadInfractions() async {
    _setLoading(true);
    _setError(null);
    try {
      final items = await DataRepository.fetchInfractions();
      _infractions
        ..clear()
        ..addAll(items);
    } catch (e) {
      _setError('Failed to load infractions: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<String> createInfraction(Infraction infraction) async {
    _setLoading(true);
    _setError(null);
    try {
      final result = await UiService.performInfractionCreate(infraction);
      return result;
    } catch (e) {
      _setError('Failed to create infraction: $e');
      return 'Error: Failed to create infraction';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> updateInfraction(int index, Infraction infraction) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = infraction.id ?? index;
      final result = await UiService.performInfractionUpdate(id, infraction);
      return result;
    } catch (e) {
      _setError('Failed to update infraction: $e');
      return 'Error: Failed to update infraction';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> deleteInfraction(int index, Infraction infraction) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = infraction.id ?? index;
      final result = await UiService.performInfractionDelete(id, infraction);
      return result;
    } catch (e) {
      _setError('Failed to delete infraction: $e');
      return 'Error: Failed to delete infraction';
    } finally {
      _setLoading(false);
    }
  }

  Future<Infraction> getInfraction(int id) async {
    try {
      return await DataRepository.getInfraction(id);
    } catch (e) {
      throw Exception('Failed to fetch infraction: $e');
    }
  }

  void clearError() {
    _setError(null);
  }
}
