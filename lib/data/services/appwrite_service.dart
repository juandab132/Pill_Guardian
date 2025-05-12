import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/models/medicamento_model.dart';

class AppwriteService {
  static final AppwriteService _instance = AppwriteService._internal();
  factory AppwriteService() => _instance;

  late final Client _client;
  late final Account _account;
  late final Databases _databases;

  final String projectId = '680eb01b000bd489842c';
  final String databaseId = '680ed41a0006ddbb2030';
  final String collectionId = '680ed424001466590af1';

  AppwriteService._internal() {
    _client = Client()
      ..setEndpoint('https://cloud.appwrite.io/v1')
      ..setProject(projectId);
    _account = Account(_client);
    _databases = Databases(_client);
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      await _account.deleteSessions();
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getCurrentUser() async {
    try {
      return await _account.get();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createFormula({
    required String userId,
    required String nombreFormula,
    required List<MedicamentoModel> medicamentos,
  }) async {
    try {
      for (final med in medicamentos) {
        await _databases.createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: ID.unique(),
          data: {
            'userId': userId,
            'nombreFormula': nombreFormula,
            'nombre': med.nombre,
            'dosis': med.dosis,
            'frecuencia': med.frecuencia,
            'duracion': med.duracion,
            'fechaCreacion': DateTime.now().toUtc().toIso8601String(),
          },
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Document>> getFormulas(String userId) async {
    try {
      final result = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [Query.equal('userId', userId)],
      );
      return result.documents;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFormula(String documentId) async {
    try {
      await _databases.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
