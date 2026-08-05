import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/batch_model.dart';
import '../../data/models/dock_model.dart';
import '../../data/models/enums.dart';
import '../../data/models/warehouse_model.dart';
import '../../data/repositories/batch_repository.dart';
import '../../data/repositories/dock_repository.dart';
import '../../data/repositories/warehouse_repository.dart';
import '../../i18n/app_localizations.dart';
import '../../providers/database_provider.dart';
import '../../providers/settings_provider.dart';
import '../../utils.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _nameController = TextEditingController(text: '主仓库');
  final _countController = TextEditingController(text: '6');
  final _dockNameControllers = <TextEditingController>[];
  final _batchCodeControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    _generateControllers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final c in _dockNameControllers) {
      c.dispose();
    }
    for (final c in _batchCodeControllers) {
      c.dispose();
    }
    super.dispose();
  }

  int get _dockCount {
    final v = int.tryParse(_countController.text);
    if (v == null || v < 0) return 0;
    return v;
  }

  void _generateControllers() {
    final count = _dockCount;
    while (_dockNameControllers.length < count) {
      final n = _dockNameControllers.length + 1;
      _dockNameControllers.add(TextEditingController(text: '$n号道口'));
      _batchCodeControllers.add(TextEditingController());
    }
    while (_dockNameControllers.length > count) {
      _dockNameControllers.removeLast().dispose();
      _batchCodeControllers.removeLast().dispose();
    }
  }

  void _onCountChanged(String value) {
    final v = int.tryParse(value);
    if (v != null && v < 0) {
      final l = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.countCannotBeNegative)),
      );
      _countController.text = '0';
    }
    setState(() => _generateControllers());
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.createWarehouse)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.createWarehouse, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            _NeumorphicTextField(
              controller: _nameController,
              label: l.warehouseName,
            ),
            const SizedBox(height: 24),
            _NeumorphicTextField(
              controller: _countController,
              label: l.dockCount,
              keyboardType: TextInputType.number,
              onChanged: _onCountChanged,
            ),
            const SizedBox(height: 16),
            Text(l.dockName, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...List.generate(_dockCount, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _NeumorphicTextField(
                        controller: _dockNameControllers[i],
                        label: l.dockName,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: _NeumorphicTextField(
                        controller: _batchCodeControllers[i],
                        label: l.initialBatch,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: _saving ? null : _save,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.35),
                        offset: const Offset(-6, -6),
                        blurRadius: 12,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(6, 6),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          l.createAndStart,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _saving = false;

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final db = await ref.read(databaseProvider.future);
      final warehouse = WarehouseModel(
        id: generateId(),
        name: _nameController.text.trim().isEmpty
            ? '主仓库'
            : _nameController.text.trim(),
      );

      await WarehouseRepository(db).insert(warehouse);

      for (var i = 0; i < _dockCount; i = i + 1) {
        final dockId = generateId();
        final dockName = _dockNameControllers[i].text.trim().isEmpty
            ? '${i + 1}号道口'
            : _dockNameControllers[i].text.trim();
        final code = _batchCodeControllers[i].text.trim();

        final dock = DockModel(
          id: dockId,
          warehouseId: warehouse.id,
          name: dockName,
          displayOrder: i,
          currentStatus:
              code.isEmpty ? DockStatus.empty : DockStatus.active,
        );
        await DockRepository(db).insert(dock);

        if (code.isNotEmpty) {
          final batch = BatchModel(
            id: generateId(),
            warehouseId: warehouse.id,
            batchCode: code,
            status: BatchStatus.active,
            startedAt: DateTime.now(),
          );
          await BatchRepository(db).insert(batch);
          await DockRepository(db).updateStatusAndBatch(
            dock.id,
            status: dock.currentStatus,
            batchId: batch.id,
          );
        }
      }

      final settings = await ref.read(settingsProvider.future);
      await settings.setFirstRun(false);
      await settings.setCurrentWarehouse(warehouse.id);

      if (mounted) {
        context.go('/kanban?warehouseId=${warehouse.id}');
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      if (mounted) {
        final l = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.createFailed)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _NeumorphicTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const _NeumorphicTextField({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? const Color(0xFF4A5278).withOpacity(0.35)
                : Colors.white.withOpacity(0.85),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.45)
                : Colors.black.withOpacity(0.12),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
