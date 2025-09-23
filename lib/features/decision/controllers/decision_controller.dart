import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/services/data_repository.dart';

class DecisionController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final List<Decision> _decisions = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Decision> get decisions => _decisions;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadDecisions() async {
    _setLoading(true);
    _setError(null);
    try {
      final items = await DataRepository.fetchDecisions();
      _decisions
        ..clear()
        ..addAll(items);
    } catch (e) {
      _setError('Failed to load decisions: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<String> createDecision(Decision decision) async {
    _setLoading(true);
    _setError(null);
    try {
      final result = await UiService.performDecisionCreate(decision);
      return result;
    } catch (e) {
      _setError('Failed to create decision: $e');
      return 'Error: Failed to create decision';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> updateDecision(int index, Decision decision) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = decision.id ?? index;
      final result = await UiService.performDecisionUpdate(id, decision);
      return result;
    } catch (e) {
      _setError('Failed to update decision: $e');
      return 'Error: Failed to update decision';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> deleteDecision(int index, Decision decision) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = decision.id ?? index;
      final result = await UiService.performDecisionDelete(id, decision);
      return result;
    } catch (e) {
      _setError('Failed to delete decision: $e');
      return 'Error: Failed to delete decision';
    } finally {
      _setLoading(false);
    }
  }

  Future<Decision> getDecision(int id) async {
    try {
      return await DataRepository.getDecision(id);
    } catch (e) {
      throw Exception('Failed to fetch decision: $e');
    }
  }

  void clearError() {
    _setError(null);
  }
}


