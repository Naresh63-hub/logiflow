import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/network/connectivity_service.dart';
import '../../core/sync/sync_engine.dart';

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);
    final syncState = ref.watch(syncEngineProvider);

    if (isOnline && syncState.pendingCount == 0 && !syncState.isSyncing) {
      return const SizedBox.shrink();
    }

    final isOffline = !isOnline;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isOffline ? AppColors.warning : AppColors.secondary,
      child: Row(
        children: [
          Icon(
            isOffline ? Icons.wifi_off : Icons.sync,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              isOffline
                  ? context.tr('offlineBanner')
                  : syncState.isSyncing
                      ? 'Syncing ${syncState.pendingCount} pending updates...'
                      : '${syncState.pendingCount} offline changes queued for sync',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (syncState.pendingCount > 0 && isOnline && !syncState.isSyncing)
            GestureDetector(
              onTap: () => ref.read(syncEngineProvider.notifier).syncNow(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'SYNC NOW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
