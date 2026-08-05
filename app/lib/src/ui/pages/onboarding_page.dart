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
  int _dockCount = 6;
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

  void _generateControllers() {
    while (_dockNameControllers.length < _dockCount) {
      final n = _dockNameControllers.length + 1;
      _dockNameControllers.add(TextEditingController(text: '' + n.toString() + '号道口'));
      _batchCodeControllers.add(TextEditingController());
    }
    while (_dockNameControllers.length > _dockCount) {
      _dockNameControllers.removeLast().dispose();
      _batchCodeControllers.removeLast().dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('初始化向导')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('创建第一个仓库', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '仓库名称',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text('道口数量:', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(width: 16),
                DropdownButton<int>(
                  value: _dockCount,
                  items: [6, 8, 10, 12]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setState(() {
                        _dockCount = v;
                        _generateControllers();
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('道口名称与初始批次', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...List.generate(_dockCount, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _dockNameControllers[i],
                        decoration: const InputDecoration(
                          labelText: '道口名称',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _batchCodeControllers[i],
                        decoration: const InputDecoration(
                          labelText: '初始批次（可为空）',
                          border: OutlineInputBorder(),
                        ),
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
                          '创建仓库并开始使用',
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

      for (var i = 0; i < _dockCount; i++) {
        final dockId = generateId();
        final dockName = _dockNameControllers[i].text.trim().isEmpty
            ? '' + (i + 1).toString() + '号道口'
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
        context.go('/kanban?warehouseId=' + warehouse.id);
      }
    } catch (e, st) {
      debugPrint('创建仓库失败: ' + e.toString() + '\n' + st.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('创建失败: ' + e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
