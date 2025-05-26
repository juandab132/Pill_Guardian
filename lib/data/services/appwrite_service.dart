import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import '../models/medicamento_model.dart';

class AppwriteService {
  static final AppwriteService _instance = AppwriteService._internal();
  factory AppwriteService() => _instance;

  late Client _client;
  late Account _account;
  late Databases _databases;

  final String projectId = '680eb01b000bd489842c';
  final String databaseId = '680ed41a0006ddbb2030';
  final String collectionId = '680ed424001466590af1';

  AppwriteService._internal() {
    _client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject(projectId);

    _account = Account(_client);
    _databases = Databases(_client);
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    await _account.create(
      userId: ID.unique(),
      email: email,
      password: password,
    );
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await _account.createEmailPasswordSession(email: email, password: password);
  }

  Future<User> getCurrentUser() async {
    return await _account.get();
  }

  Future<void> logoutUser() async {
    await _account.deleteSessions();
  }

  Future<void> createFormula({
    required String userId,
    required String nombreFormula,
    required List<MedicamentoModel> medicamentos,
  }) async {
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
          'tomado': false,
          'fechaCreacion': DateTime.now().toUtc().toIso8601String(),
        },
      );
    }
  }

  Future<List<Document>> getFormulas(String userId) async {
    final result = await _databases.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: [Query.equal('userId', userId)],
    );
    return result.documents;
  }

  Future<void> deleteFormula(String documentId) async {
    await _databases.deleteDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
    );
  }

  Future<void> updateDocumentField({
    required String documentId,
    required String field,
    required dynamic value,
  }) async {
    await _databases.updateDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
      data: {field: value},
    );
  }

  Future<void> markMedicamentoAsTaken(String docId) async {
    await updateDocumentField(documentId: docId, field: 'tomado', value: true);
  }

  updateFormula(String formulaId, Map<String, dynamic> document) {}
}
