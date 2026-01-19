import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import 'isar_service.dart';
import '../models/bilhete.dart';
import '../models/participante.dart';

class ExportImportService {
  final IsarService _isarService = IsarService();

  /// Exporta os dados de uma rifa para JSON
  Future<Map<String, dynamic>> exportarRifaParaJson(int rifaId) async {
    final rifa = await _isarService.obterRifaPorId(rifaId);
    if (rifa == null) throw Exception('Rifa não encontrada');

    final bilhetes = await _isarService.obterBilhetesRifa(rifaId);
    final participantesMap = <int, Participante>{};
    final bilhetesPorParticipante = <int, List<Map<String, dynamic>>>{};

    // Buscar participantes dos bilhetes e agrupar bilhetes por participante
    for (final bilhete in bilhetes) {
      if (bilhete.participanteId != null) {
        // Buscar participante se ainda não foi buscado
        if (!participantesMap.containsKey(bilhete.participanteId)) {
          final participante = await _isarService.obterParticipantePorId(bilhete.participanteId!);
          if (participante != null) {
            participantesMap[bilhete.participanteId!] = participante;
            bilhetesPorParticipante[bilhete.participanteId!] = [];
          }
        }
        
        // Adicionar bilhete à lista do participante
        bilhetesPorParticipante[bilhete.participanteId!]?.add({
          'numero': bilhete.numero,
          'numeroFormatado': bilhete.numero.toString().padLeft(3, '0'),
          'status': bilhete.status.name,
          'dataVenda': bilhete.dataVenda?.toIso8601String(),
        });
      }
    }

    // Criar lista de compradores com seus bilhetes
    final compradores = participantesMap.entries.map((entry) {
      final participante = entry.value;
      final bilhetesDoParticipante = bilhetesPorParticipante[entry.key] ?? [];
      final bilhetesPagos = bilhetesDoParticipante.where((b) => b['status'] == 'vendido').toList();
      final bilhetesPendentes = bilhetesDoParticipante.where((b) => b['status'] == 'reservado').toList();
      
      return {
        'id': participante.id,
        'nome': participante.nome,
        'telefone': participante.telefone,
        'email': participante.email,
        'notas': participante.notas,
        'bilhetesPagos': bilhetesPagos.map((b) => b['numeroFormatado']).toList(),
        'bilhetesPendentes': bilhetesPendentes.map((b) => b['numeroFormatado']).toList(),
        'totalPago': bilhetesPagos.length,
        'totalPendente': bilhetesPendentes.length,
        'valorPago': bilhetesPagos.length * rifa.valorBilhete,
        'valorPendente': bilhetesPendentes.length * rifa.valorBilhete,
      };
    }).toList();

    // Ordenar compradores por nome
    compradores.sort((a, b) => (a['nome'] as String).compareTo(b['nome'] as String));

    return {
      'versao': '1.0',
      'exportadoEm': DateTime.now().toIso8601String(),
      'app': 'Rifa Deck',
      'rifa': {
        'titulo': rifa.titulo,
        'descricao': rifa.descricao,
        'totalBilhetes': rifa.totalBilhetes,
        'valorBilhete': rifa.valorBilhete,
        'status': rifa.status.name,
        'dataCriacao': rifa.dataCriacao.toIso8601String(),
        'observacoes': rifa.observacoes,
      },
      'resumo': {
        'totalVendidos': bilhetes.where((b) => b.status.name == 'vendido').length,
        'totalReservados': bilhetes.where((b) => b.status.name == 'reservado').length,
        'totalLivres': bilhetes.where((b) => b.status.name == 'livre').length,
        'receitaAtual': bilhetes.where((b) => b.status.name == 'vendido').length * rifa.valorBilhete,
        'totalCompradores': compradores.length,
      },
      'compradores': compradores,
      'bilhetes': bilhetes.map((b) => {
        'numero': b.numero,
        'numeroFormatado': b.numero.toString().padLeft(3, '0'),
        'status': b.status.name,
        'participanteId': b.participanteId,
        'dataVenda': b.dataVenda?.toIso8601String(),
        'observacoes': b.observacoes,
      }).toList(),
    };
  }

  /// Gera texto formatado com resumo da rifa
  Future<String> gerarTextoResumo(int rifaId) async {
    final rifa = await _isarService.obterRifaPorId(rifaId);
    if (rifa == null) throw Exception('Rifa não encontrada');

    final bilhetes = await _isarService.obterBilhetesRifa(rifaId);
    final vendidos = bilhetes.where((b) => b.status.name == 'vendido').toList();
    final reservados = bilhetes.where((b) => b.status.name == 'reservado').toList();
    final livres = bilhetes.where((b) => b.status.name == 'livre').toList();

    final receita = vendidos.length * rifa.valorBilhete;
    final potencial = rifa.totalBilhetes * rifa.valorBilhete;

    final buffer = StringBuffer();
    buffer.writeln('═══════════════════════════════════');
    buffer.writeln('   📋 RELATÓRIO DA RIFA');
    buffer.writeln('═══════════════════════════════════');
    buffer.writeln();
    buffer.writeln('🎫 ${rifa.titulo}');
    if (rifa.descricao?.isNotEmpty == true) {
      buffer.writeln('📝 ${rifa.descricao}');
    }
    buffer.writeln();
    buffer.writeln('───────────────────────────────────');
    buffer.writeln('   📊 ESTATÍSTICAS');
    buffer.writeln('───────────────────────────────────');
    buffer.writeln('• Total de bilhetes: ${rifa.totalBilhetes}');
    buffer.writeln('• Valor por bilhete: R\$ ${rifa.valorBilhete.toStringAsFixed(2)}');
    buffer.writeln();
    buffer.writeln('✅ Vendidos: ${vendidos.length} (${(vendidos.length / rifa.totalBilhetes * 100).toStringAsFixed(1)}%)');
    buffer.writeln('⏳ Reservados: ${reservados.length} (${(reservados.length / rifa.totalBilhetes * 100).toStringAsFixed(1)}%)');
    buffer.writeln('🆓 Livres: ${livres.length} (${(livres.length / rifa.totalBilhetes * 100).toStringAsFixed(1)}%)');
    buffer.writeln();
    buffer.writeln('───────────────────────────────────');
    buffer.writeln('   💰 FINANCEIRO');
    buffer.writeln('───────────────────────────────────');
    buffer.writeln('• Receita atual: R\$ ${receita.toStringAsFixed(2)}');
    buffer.writeln('• Potencial total: R\$ ${potencial.toStringAsFixed(2)}');
    buffer.writeln();

    // Listar bilhetes vendidos com compradores
    if (vendidos.isNotEmpty || reservados.isNotEmpty) {
      buffer.writeln('───────────────────────────────────');
      buffer.writeln('   👥 COMPRADORES');
      buffer.writeln('───────────────────────────────────');

      final participantesMap = <int, List<Bilhete>>{};
      for (final bilhete in [...vendidos, ...reservados]) {
        if (bilhete.participanteId != null) {
          participantesMap.putIfAbsent(bilhete.participanteId!, () => []).add(bilhete);
        }
      }

      for (final entry in participantesMap.entries) {
        final participante = await _isarService.obterParticipantePorId(entry.key);
        if (participante != null) {
          final bilhetesVendidos = entry.value.where((b) => b.status.name == 'vendido').toList();
          final bilhetesReservados = entry.value.where((b) => b.status.name == 'reservado').toList();
          
          buffer.writeln();
          buffer.writeln('👤 ${participante.nome}');
          if (participante.telefone?.isNotEmpty == true) {
            buffer.writeln('   📱 ${participante.telefone}');
          }
          if (bilhetesVendidos.isNotEmpty) {
            final nums = bilhetesVendidos.map((b) => b.numero.toString().padLeft(3, '0')).join(', ');
            buffer.writeln('   ✅ Pagos: $nums');
          }
          if (bilhetesReservados.isNotEmpty) {
            final nums = bilhetesReservados.map((b) => b.numero.toString().padLeft(3, '0')).join(', ');
            buffer.writeln('   ⏳ Pendentes: $nums');
          }
        }
      }
    }

    // Listar bilhetes livres
    if (livres.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('───────────────────────────────────');
      buffer.writeln('   🆓 BILHETES DISPONÍVEIS');
      buffer.writeln('───────────────────────────────────');
      final nums = livres.map((b) => b.numero.toString().padLeft(3, '0')).toList();
      // Agrupar em linhas de 10
      for (var i = 0; i < nums.length; i += 10) {
        final end = (i + 10 > nums.length) ? nums.length : i + 10;
        buffer.writeln(nums.sublist(i, end).join(', '));
      }
    }

    buffer.writeln();
    buffer.writeln('═══════════════════════════════════');
    buffer.writeln('Exportado em: ${DateTime.now().toString().substring(0, 16)}');
    buffer.writeln('Gerado por: Rifa Deck 📱');
    buffer.writeln('═══════════════════════════════════');

    return buffer.toString();
  }

  /// Compartilha o arquivo JSON
  Future<void> compartilharJson(int rifaId) async {
    try {
      final data = await exportarRifaParaJson(rifaId);
      final jsonString = const JsonEncoder.withIndent('  ').convert(data);
      
      final rifa = await _isarService.obterRifaPorId(rifaId);
      final nomeArquivo = 'rifa_${rifa?.titulo.replaceAll(' ', '_').toLowerCase() ?? 'export'}_${DateTime.now().millisecondsSinceEpoch}.json';
      
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$nomeArquivo');
      await file.writeAsString(jsonString);
      
      final result = await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Backup Rifa - ${rifa?.titulo ?? 'Exportação'}',
        text: 'Backup da rifa ${rifa?.titulo ?? ""}',
      );
      
      print('Resultado do compartilhamento: ${result.status}');
    } catch (e, stack) {
      print('Erro ao compartilhar JSON: $e');
      print('Stack trace: $stack');
      rethrow;
    }
  }

  /// Compartilha o texto formatado
  Future<void> compartilharTexto(int rifaId) async {
    final texto = await gerarTextoResumo(rifaId);
    await Share.share(texto);
  }

  /// Copia texto para a área de transferência
  Future<void> copiarParaClipboard(int rifaId) async {
    final texto = await gerarTextoResumo(rifaId);
    await Clipboard.setData(ClipboardData(text: texto));
  }

  /// Salva JSON no armazenamento
  Future<String> salvarJsonNoDispositivo(int rifaId) async {
    final data = await exportarRifaParaJson(rifaId);
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);
    
    final rifa = await _isarService.obterRifaPorId(rifaId);
    final nomeArquivo = 'rifa_${rifa?.titulo.replaceAll(' ', '_').toLowerCase() ?? 'export'}_${DateTime.now().millisecondsSinceEpoch}.json';
    
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$nomeArquivo');
    await file.writeAsString(jsonString);
    
    return file.path;
  }

  /// Importa rifa de um arquivo JSON
  Future<int> importarRifaDeJson(String jsonString) async {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // Validar versão
      final versao = data['versao'] as String?;
      if (versao == null) {
        throw Exception('Arquivo inválido: versão não encontrada');
      }

      final rifaData = data['rifa'] as Map<String, dynamic>;
      final bilhetesData = data['bilhetes'] as List<dynamic>;
      final totalBilhetes = rifaData['totalBilhetes'] as int;
      
      // Suporta tanto formato antigo (participantes) quanto novo (compradores)
      final compradoresData = data['compradores'] as List<dynamic>? ?? 
                              data['participantes'] as List<dynamic>? ?? [];

      // Criar a rifa
      final rifaId = await _isarService.criarRifa(
        titulo: '${rifaData['titulo']} (Importada)',
        descricao: rifaData['descricao'] as String?,
        totalBilhetes: totalBilhetes,
        valorBilhete: (rifaData['valorBilhete'] as num).toDouble(),
      );

      // IMPORTANTE: Criar os bilhetes da rifa!
      await _isarService.criarBilhetes(rifaId, totalBilhetes);

      // Mapear participantes antigos para novos IDs
      final participanteIdMap = <int, int>{};
      for (final pData in compradoresData) {
        final oldId = pData['id'] as int;
        final newId = await _isarService.obterOuCriarParticipante(
          nome: pData['nome'] as String,
          telefone: pData['telefone'] as String?,
        );
        participanteIdMap[oldId] = newId;
      }

      // Atualizar bilhetes com status e participantes
      for (final bData in bilhetesData) {
        final numero = bData['numero'] as int;
        final status = bData['status'] as String;
        final oldParticipanteId = bData['participanteId'] as int?;

        if (status != 'livre' && oldParticipanteId != null) {
          final newParticipanteId = participanteIdMap[oldParticipanteId];
          if (newParticipanteId != null) {
            await _isarService.atualizarBilheteImportacao(
              rifaId: rifaId,
              participanteId: newParticipanteId,
              numero: numero,
              status: status,
            );
          }
        }
      }

      return rifaId;
    } catch (e) {
      throw Exception('Erro ao importar: $e');
    }
  }

  /// Seleciona arquivo JSON e importa
  Future<int?> selecionarEImportarJson() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null || result.files.isEmpty) return null;

    final file = File(result.files.single.path!);
    final jsonString = await file.readAsString();
    
    return await importarRifaDeJson(jsonString);
  }

  /// Importa de texto colado (JSON)
  Future<int> importarDeTexto(String texto) async {
    return await importarRifaDeJson(texto);
  }
}
