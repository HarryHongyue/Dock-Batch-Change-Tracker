import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/change_event_model.dart';
import '../../data/models/dock_model.dart';
import '../../data/repositories/change_event_repository.dart';
import '../../i18n/app_localizations.dart';
import '../../providers/database_provider.dart';
import '../../providers/dock_providers.dart';
import '../../providers/session_providers.dart';
import '../../utils.dart';

class DockDetailPage extends ConsumerStatefulWidget {
  final String dockId;

  const DockDetailPage({super.key, required this.dockId});

  @override
  ConsumerState<DockDetailPage> createState() => _DockDetailPageState();
}

class _DockDetailPageState extends ConsumerState<DockDetailPage> {
  bool _managing = false;
  final Set<String> _selected = {};

  void _setManaging(bool value) {
    setState(() {
      _managing = value;
      if (!_managing) _selected.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final dockAsync = ref.watch(dockDetailProvider(widget.dockId));
    final eventsAsync = ref.watch(dockEventsProvider(widget.dockId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.history),
        actions: [
          IconButton(
            icon: Icon(_managing ? Icons.done : Icons.edit),
            onPressed: () => _setManaging(!_managing),
          ),
        ],
      ),
      bottomNavigationBar: _managing
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.icon(
                  onPressed: _selected.isEmpty ? null : _deleteSelected,
                  icon: const Icon(Icons.delete),
                  label: Text(l.deleteSelectedEvents),
                ),
              ),
            )
          : null,
      body: dockAsync.when(
        data: (dock) {
          if (dock == null) {
            return Center(child: Text(l.noData));
          }
          return eventsAsync.when(
            data: (events) => _buildList(context, l, dock, events),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text(l.loadFailed)),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.loadFailed)),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    AppLocalizations l,
    DockModel dock,
    List<ChangeEventModel> events,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(dock.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('${l.status}: ${l.dockStatusLabel(dock.currentStatus)}'),
        Text(formatShortDateTime(dock.updatedAt)),
        const Divider(),
        if (events.isEmpty) Center(child: Text(l.noData)),
        ...events.map((e) => _EventTile(
              event: e,
              l: l,
              isManaging: _managing,
              isSelected: _selected.contains(e.id),
              onToggle: _managing
                  ? () => _toggleSelection(e.id)
                  : null,
            )),
      ],
    );
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  Future<void> _deleteSelected() async {
    final db = await ref.read(databaseProvider.future);
    for (final id in _selected) {
      await ChangeEventRepository(db).delete(id);
    }
    _selected.clear();
    _setManaging(false);
    ref.invalidate(dockEventsProvider(widget.dockId));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).success)),
      );
    }
  }
}

class _EventTile extends StatelessWidget {
  final ChangeEventModel event;
  final AppLocalizations l;
  final bool isManaging;
  final bool isSelected;
  final VoidCallback? onToggle;

  const _EventTile({
    required this.event,
    required this.l,
    this.isManaging = false,
    this.isSelected = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.35),
      leading: isManaging ? Checkbox(
        value: isSelected,
        onChanged: (_) => onToggle?.call(),
      ) : null,
      title: Text(l.eventDisplay(event)),
      subtitle: Text(formatShortDateTime(event.eventTime)),
      onTap: onToggle,
    );
  }
}
