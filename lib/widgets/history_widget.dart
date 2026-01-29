import 'package:flutter/material.dart';
import '../services/history_service.dart';

class HistoryWidget extends StatefulWidget {
  final HistoryService historyService;

  const HistoryWidget({
    Key? key,
    required this.historyService,
  }) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Histórico da Sessão',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (widget.historyService.getHistoryCount() > 0)
                TextButton.icon(
                  onPressed: () {
                    _showClearDialog(context);
                  },
                  icon: const Icon(Icons.delete_sweep),
                  label: const Text('Limpar'),
                )
            ],
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              final history = widget.historyService.getHistory();
              if (history.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhum registro no histórico',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final entry = history[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(entry.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('CPF: ${entry.cpf}'),
                          Text('CNPJ: ${entry.cnpj}'),
                          Text(
                            'Adicionado: ${_formatTime(entry.timestamp)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          widget.historyService.removeEntry(entry.id);
                          setState(() {});
                        },
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'há ${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return 'há ${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return 'há ${difference.inHours}h';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
          '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Limpar Histórico'),
          content: const Text(
            'Tem certeza que deseja limpar todo o histórico da sessão?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                widget.historyService.clearHistory();
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text('Limpar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
