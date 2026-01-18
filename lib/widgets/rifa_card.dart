import 'package:flutter/material.dart';
import '../models/rifa.dart';

class RifaCard extends StatelessWidget {
  final Rifa rifa;
  final int bilhetesVendidos;
  final int bilhetesReservados;
  final VoidCallback onTapAcao;

  const RifaCard({
    Key? key,
    required this.rifa,
    required this.bilhetesVendidos,
    required this.bilhetesReservados,
    required this.onTapAcao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentual = (bilhetesVendidos / rifa.totalBilhetes) * 100;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              rifa.titulo,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Descrição (opcional)
            if (rifa.descricao != null && rifa.descricao!.isNotEmpty)
              Text(
                rifa.descricao!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

            const SizedBox(height: 12),

            // Estatísticas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatItem(
                  label: 'Vendidos',
                  valor: bilhetesVendidos,
                  total: rifa.totalBilhetes,
                  color: Colors.green,
                ),
                _StatItem(
                  label: 'Reservados',
                  valor: bilhetesReservados,
                  total: rifa.totalBilhetes,
                  color: Colors.orange,
                ),
                _StatItem(
                  label: 'Arrecadado',
                  valor: 'R\$ ${(bilhetesVendidos * rifa.valorBilhete).toStringAsFixed(2)}',
                  color: Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Barra de progresso
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progresso de Vendas',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      '${percentual.toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: percentual / 100,
                    minHeight: 8,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      percentual < 50
                          ? Colors.orange
                          : percentual < 80
                              ? Colors.yellow[700]!
                              : Colors.green,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Botão de ação
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onTapAcao,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Vender Bilhetes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final dynamic valor;
  final int? total;
  final Color color;

  const _StatItem({
    required this.label,
    required this.valor,
    this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isNumeric = valor is int;

    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 4),
        if (isNumeric)
          Text(
            '$valor${total != null ? '/$total' : ''}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          )
        else
          Text(
            valor,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
      ],
    );
  }
}
