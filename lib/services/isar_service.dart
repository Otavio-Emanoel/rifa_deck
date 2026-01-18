import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/rifa.dart';
import '../models/bilhete.dart';
import '../models/participante.dart';
import '../models/transacao.dart';
import '../models/enums.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  late Database _db;

  IsarService._internal();

  factory IsarService() {
    return _instance;
  }

  /// Inicializa o banco de dados
  Future<void> initialize() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'rifa_deck.db');
    
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    // Tabela de rifas
    await db.execute('''
      CREATE TABLE IF NOT EXISTS rifas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT,
        totalBilhetes INTEGER NOT NULL,
        valorBilhete REAL NOT NULL,
        status TEXT NOT NULL,
        bilheteSorteadoId INTEGER,
        dataSorteio TEXT,
        dataCriacao TEXT NOT NULL,
        dataAtualizacao TEXT NOT NULL,
        observacoes TEXT
      )
    ''');

    // Tabela de bilhetes
    await db.execute('''
      CREATE TABLE IF NOT EXISTS bilhetes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rifaId INTEGER NOT NULL,
        numero INTEGER NOT NULL,
        status TEXT NOT NULL,
        participanteId INTEGER,
        dataVenda TEXT,
        observacoes TEXT,
        dataCriacao TEXT NOT NULL,
        dataAtualizacao TEXT NOT NULL
      )
    ''');

    // Tabela de participantes
    await db.execute('''
      CREATE TABLE IF NOT EXISTS participantes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        telefone TEXT,
        email TEXT,
        valorDevendo REAL DEFAULT 0,
        valorPago REAL DEFAULT 0,
        dataCriacao TEXT NOT NULL,
        dataAtualizacao TEXT NOT NULL,
        notas TEXT
      )
    ''');

    // Tabela de transações
    await db.execute('''
      CREATE TABLE IF NOT EXISTS transacaos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rifaId INTEGER NOT NULL,
        participanteId INTEGER NOT NULL,
        tipo TEXT NOT NULL,
        valor REAL NOT NULL,
        descricao TEXT,
        data TEXT NOT NULL,
        bilhetesIds TEXT,
        notas TEXT
      )
    ''');
  }

  // ========== RIFAS ==========

  Future<int> criarRifa({
    required String titulo,
    String? descricao,
    required int totalBilhetes,
    required double valorBilhete,
  }) async {
    return await _db.insert('rifas', {
      'titulo': titulo,
      'descricao': descricao,
      'totalBilhetes': totalBilhetes,
      'valorBilhete': valorBilhete,
      'status': 'ativa',
      'dataCriacao': DateTime.now().toIso8601String(),
      'dataAtualizacao': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Rifa>> obterTodasRifas() async {
    final result = await _db.query('rifas');
    return result.map((map) => _rifaFromMap(map)).toList();
  }

  Future<List<Rifa>> obterRifasAtivas() async {
    final result = await _db.query(
      'rifas',
      where: "status = ?",
      whereArgs: ['ativa'],
    );
    return result.map((map) => _rifaFromMap(map)).toList();
  }

  Future<Rifa?> obterRifaPorId(int id) async {
    final result = await _db.query(
      'rifas',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return _rifaFromMap(result.first);
  }

  Future<void> atualizarRifa(Rifa rifa) async {
    await _db.update(
      'rifas',
      {
        'titulo': rifa.titulo,
        'descricao': rifa.descricao,
        'status': rifa.status.name,
        'dataAtualizacao': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [rifa.id],
    );
  }

  Future<void> deletarRifa(int id) async {
    await _db.delete('rifas', where: 'id = ?', whereArgs: [id]);
  }

  // ========== BILHETES ==========

  Future<void> criarBilhetes(int rifaId, int quantidade) async {
    final batch = _db.batch();
    final now = DateTime.now().toIso8601String();
    
    for (int i = 1; i <= quantidade; i++) {
      batch.insert('bilhetes', {
        'rifaId': rifaId,
        'numero': i,
        'status': 'livre',
        'dataCriacao': now,
        'dataAtualizacao': now,
      });
    }
    await batch.commit();
  }

  Future<List<Bilhete>> obterBilhetesRifa(int rifaId) async {
    final result = await _db.query(
      'bilhetes',
      where: 'rifaId = ?',
      whereArgs: [rifaId],
    );
    return result.map((map) => _bilheteFromMap(map)).toList();
  }

  Future<List<Bilhete>> obterBilhetesVendidos(int rifaId) async {
    final result = await _db.query(
      'bilhetes',
      where: 'rifaId = ? AND status = ?',
      whereArgs: [rifaId, 'vendido'],
    );
    return result.map((map) => _bilheteFromMap(map)).toList();
  }

  Future<List<Bilhete>> obterBilhetesReservados(int rifaId) async {
    final result = await _db.query(
      'bilhetes',
      where: 'rifaId = ? AND status = ?',
      whereArgs: [rifaId, 'reservado'],
    );
    return result.map((map) => _bilheteFromMap(map)).toList();
  }

  /// Obtém um bilhete vendido aleatório para sorteio
  Future<Bilhete?> obterBilheteSorteio(int rifaId) async {
    final result = await _db.query(
      'bilhetes',
      where: 'rifaId = ? AND status = ?',
      whereArgs: [rifaId, 'vendido'],
    );
    if (result.isEmpty) return null;
    final bilhetes = result.map((map) => _bilheteFromMap(map)).toList();
    final random = DateTime.now().millisecondsSinceEpoch % bilhetes.length;
    return bilhetes[random];
  }

  Future<void> venderBilhetes({
    required int rifaId,
    required int participanteId,
    required List<int> numerosBilhetes,
    required double totalPago,
  }) async {
    final now = DateTime.now().toIso8601String();
    final batch = _db.batch();
    
    for (var numero in numerosBilhetes) {
      batch.update(
        'bilhetes',
        {
          'status': 'vendido',
          'participanteId': participanteId,
          'dataVenda': now,
          'dataAtualizacao': now,
        },
        where: 'rifaId = ? AND numero = ? AND status = ?',
        whereArgs: [rifaId, numero, 'livre'],
      );
    }
    await batch.commit();
  }

  /// Busca participante por nome, ou cria um novo se não existir
  Future<int> obterOuCriarParticipante({
    required String nome,
    String? telefone,
  }) async {
    final result = await _db.query(
      'participantes',
      where: 'nome = ?',
      whereArgs: [nome.trim()],
    );
    if (result.isNotEmpty) {
      return result.first['id'] as int;
    }
    return await criarParticipante(
      nome: nome.trim(),
      telefone: telefone?.trim(),
    );
  }

  /// Atualiza bilhetes com participante e status (vendido ou reservado)
  Future<void> atualizarBilhetesCheckout({
    required int rifaId,
    required int participanteId,
    required List<int> numerosBilhetes,
    required String status, // 'vendido' ou 'reservado'
  }) async {
    final now = DateTime.now().toIso8601String();
    final batch = _db.batch();
    
    for (var numero in numerosBilhetes) {
      batch.update(
        'bilhetes',
        {
          'status': status,
          'participanteId': participanteId,
          'dataVenda': now,
          'dataAtualizacao': now,
        },
        where: 'rifaId = ? AND numero = ? AND status = ?',
        whereArgs: [rifaId, numero, 'livre'],
      );
    }
    await batch.commit();
  }

  // ========== PARTICIPANTES ==========

  Future<int> criarParticipante({
    required String nome,
    String? telefone,
    String? email,
    String? notas,
  }) async {
    return await _db.insert('participantes', {
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'notas': notas,
      'valorDevendo': 0.0,
      'valorPago': 0.0,
      'dataCriacao': DateTime.now().toIso8601String(),
      'dataAtualizacao': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Participante>> obterTodosParticipantes() async {
    final result = await _db.query('participantes');
    return result.map((map) => _participanteFromMap(map)).toList();
  }

  Future<Participante?> obterParticipantePorId(int id) async {
    final result = await _db.query(
      'participantes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return _participanteFromMap(result.first);
  }

  Future<void> atualizarParticipante(Participante participante) async {
    await _db.update(
      'participantes',
      {
        'nome': participante.nome,
        'telefone': participante.telefone,
        'email': participante.email,
        'dataAtualizacao': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [participante.id],
    );
  }

  /// Obtém todos os participantes que têm bilhetes em uma rifa específica
  Future<List<Map<String, dynamic>>> obterParticipantesRifaComBilhetes(int rifaId) async {
    final result = await _db.rawQuery('''
      SELECT DISTINCT p.*, GROUP_CONCAT(b.numero) as bilhete_numeros, 
             GROUP_CONCAT(b.status) as bilhete_statuses
      FROM participantes p
      INNER JOIN bilhetes b ON p.id = b.participanteId
      WHERE b.rifaId = ?
      GROUP BY p.id
      ORDER BY p.nome ASC
    ''', [rifaId]);
    return result;
  }

  /// Marca todos os bilhetes reservados de um participante como vendidos
  Future<void> marcarParticipantePago(int participanteId) async {
    final now = DateTime.now().toIso8601String();
    await _db.update(
      'bilhetes',
      {
        'status': 'vendido',
        'dataAtualizacao': now,
      },
      where: 'participanteId = ? AND status = ?',
      whereArgs: [participanteId, 'reservado'],
    );
  }

  // ========== TRANSAÇÕES ==========

  Future<void> registrarTransacao({
    required int rifaId,
    required int participanteId,
    required TipoTransacao tipo,
    required double valor,
    String? descricao,
    String? bilhetesIds,
    String? notas,
  }) async {
    await _db.insert('transacaos', {
      'rifaId': rifaId,
      'participanteId': participanteId,
      'tipo': tipo.name,
      'valor': valor,
      'descricao': descricao,
      'bilhetesIds': bilhetesIds,
      'notas': notas,
      'data': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Transacao>> obterTransacoesRifa(int rifaId) async {
    final result = await _db.query(
      'transacaos',
      where: 'rifaId = ?',
      whereArgs: [rifaId],
      orderBy: 'data DESC',
    );
    return result.map((map) => _transacaoFromMap(map)).toList();
  }

  // ========== CONVERSORES ==========

  Rifa _rifaFromMap(Map<String, dynamic> map) {
    return Rifa()
      ..id = map['id']
      ..titulo = map['titulo']
      ..descricao = map['descricao']
      ..totalBilhetes = map['totalBilhetes']
      ..valorBilhete = (map['valorBilhete'] as num).toDouble()
      ..status = RifaStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => RifaStatus.ativa,
      )
      ..dataCriacao = DateTime.parse(map['dataCriacao'])
      ..dataAtualizacao = DateTime.parse(map['dataAtualizacao']);
  }

  Bilhete _bilheteFromMap(Map<String, dynamic> map) {
    return Bilhete()
      ..id = map['id']
      ..rifaId = map['rifaId']
      ..numero = map['numero']
      ..status = BilheteStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => BilheteStatus.livre,
      )
      ..participanteId = map['participanteId']
      ..dataCriacao = DateTime.parse(map['dataCriacao'])
      ..dataAtualizacao = DateTime.parse(map['dataAtualizacao']);
  }

  Participante _participanteFromMap(Map<String, dynamic> map) {
    return Participante()
      ..id = map['id']
      ..nome = map['nome']
      ..telefone = map['telefone']
      ..email = map['email']
      ..valorDevendo = (map['valorDevendo'] as num?)?.toDouble() ?? 0.0
      ..valorPago = (map['valorPago'] as num?)?.toDouble() ?? 0.0
      ..dataCriacao = DateTime.parse(map['dataCriacao'])
      ..dataAtualizacao = DateTime.parse(map['dataAtualizacao'])
      ..notas = map['notas'];
  }

  Transacao _transacaoFromMap(Map<String, dynamic> map) {
    return Transacao()
      ..id = map['id']
      ..rifaId = map['rifaId']
      ..participanteId = map['participanteId']
      ..tipo = TipoTransacao.values.firstWhere(
        (e) => e.name == map['tipo'],
        orElse: () => TipoTransacao.venda,
      )
      ..valor = (map['valor'] as num).toDouble()
      ..descricao = map['descricao']
      ..bilhetesIds = map['bilhetesIds']
      ..notas = map['notas']
      ..data = DateTime.parse(map['data']);
  }

  Future<void> close() async {
    await _db.close();
  }

  String _statusToString(BilheteStatus status) {
    return status.name;
  }

  Future<Bilhete?> obterBilhetePorId(int id) async {
    final result = await _db.query(
      'bilhetes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return _bilheteFromMap(result.first);
  }

  Future<void> atualizarBilhete(Bilhete bilhete) async {
    final now = DateTime.now().toIso8601String();
    await _db.update(
      'bilhetes',
      {
        'status': _statusToString(bilhete.status),
        'participanteId': bilhete.participanteId,
        'dataAtualizacao': now,
      },
      where: 'id = ?',
      whereArgs: [bilhete.id],
    );
  }

  /// Remove bilhetes de um participante (limpa participanteId desses bilhetes)
  Future<void> limparParticipanteDeBilhetes(List<int> bilheteIds) async {
    for (final id in bilheteIds) {
      await _db.update(
        'bilhetes',
        {'participanteId': null, 'status': 'livre'},
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  /// Remove uma rifa e todos os seus bilhetes
  Future<void> removerRifa(int rifaId) async {
    // Remove todos os bilhetes da rifa
    await _db.delete(
      'bilhetes',
      where: 'rifaId = ?',
      whereArgs: [rifaId],
    );
    // Remove a rifa
    await _db.delete(
      'rifas',
      where: 'id = ?',
      whereArgs: [rifaId],
    );
  }

  /// Obtém o participante associado a um bilhete
  Future<Participante?> obterParticipanteComBilhete(int bilheteId) async {
    final bilhete = await obterBilhetePorId(bilheteId);
    if (bilhete == null || bilhete.participanteId == null) {
      return null;
    }
    return await obterParticipantePorId(bilhete.participanteId!);
  }
}
