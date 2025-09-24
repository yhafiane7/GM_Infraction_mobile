import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'package:gmsoft_infractions_mobile/services/ui_service.dart';
import 'package:gmsoft_infractions_mobile/services/data_repository.dart';

class AgentController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final List<Agent> _agents = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Agent> get agents => _agents;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadAgents() async {
    _setLoading(true);
    _setError(null);
    try {
      final items = await DataRepository.fetchAgents();
      _agents
        ..clear()
        ..addAll(items);
    } catch (e) {
      _setError('Failed to load agents: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<String> createAgent(Agent agent) async {
    _setLoading(true);
    _setError(null);
    try {
      final result = await UiService.performAgentCreate(agent);
      return result;
    } catch (e) {
      _setError('Failed to create agent: $e');
      return 'Error: Failed to create agent';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> updateAgent(int index, Agent agent) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = agent.id ?? index;
      final result = await UiService.performAgentUpdate(id, agent);
      return result;
    } catch (e) {
      _setError('Failed to update agent: $e');
      return 'Error: Failed to update agent';
    } finally {
      _setLoading(false);
    }
  }

  Future<String> deleteAgent(int index, Agent agent) async {
    _setLoading(true);
    _setError(null);
    try {
      final id = agent.id ?? index;
      final result = await UiService.performAgentDelete(id, agent);
      return result;
    } catch (e) {
      _setError('Failed to delete agent: $e');
      return 'Error: Failed to delete agent';
    } finally {
      _setLoading(false);
    }
  }

  Future<Agent> getAgent(int id) async {
    try {
      return await DataRepository.getAgent(id);
    } catch (e) {
      throw Exception('Failed to fetch agent: $e');
    }
  }

  void clearError() {
    _setError(null);
  }
}
