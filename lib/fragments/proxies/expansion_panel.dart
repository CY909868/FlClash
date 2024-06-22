import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProxiesExpansionPanelFragment extends StatefulWidget {
  const ProxiesExpansionPanelFragment({super.key});

  @override
  State<ProxiesExpansionPanelFragment> createState() =>
      _ProxiesExpansionPanelFragmentState();
}

class _ProxiesExpansionPanelFragmentState
    extends State<ProxiesExpansionPanelFragment> {
  @override
  Widget build(BuildContext context) {
    return Selector2<AppState, Config, ProxiesSelectorState>(
      selector: (_, appState, config) {
        final currentGroups = appState.currentGroups;
        final groupNames = currentGroups.map((e) => e.name).toList();
        return ProxiesSelectorState(
          groupNames: groupNames,
          currentGroupName: config.currentGroupName,
        );
      },
      builder: (_, state, __) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: state.groupNames.length,
          itemBuilder: (_, index) {
            final groupName = state.groupNames[index];
            return ProxiesExpansionView(
              key: Key(groupName),
              groupName: groupName,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 16,
            );
          },
        );
      },
    );
  }
}

class ProxiesExpansionView extends StatelessWidget {
  final String groupName;

  const ProxiesExpansionView({
    super.key,
    required this.groupName,
  });

  double _getItemHeight(BuildContext context) {
    final measure = globalState.appController.measure;
    return 12 * 2 +
        measure.bodyMediumHeight * 2 +
        measure.bodySmallHeight +
        measure.labelSmallHeight +
        8 * 2;
  }

  int _getColumns(ViewMode viewMode) {
    switch (viewMode) {
      case ViewMode.mobile:
        return 2;
      case ViewMode.laptop:
        return 3;
      case ViewMode.desktop:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector2<AppState, Config, ProxyGroupSelectorState>(
      selector: (_, appState, config) {
        final group = appState.getGroupWithName(groupName)!;
        final currentProxyName =
            config.currentSelectedMap[group.name] ?? group.now;
        return ProxyGroupSelectorState(
          proxiesSortType: config.proxiesSortType,
          sortNum: appState.sortNum,
          group: group,
          viewMode: appState.viewMode,
          currentProxyName: currentProxyName ?? '',
        );
      },
      builder: (_, state, __) {
        final group = state.group;
        final proxies = state.group.all;
        return CommonCard(
          child: ExpansionTile(
            controlAffinity: ListTileControlAffinity.trailing,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(group.name),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      group.type.name,
                      style: context.textTheme.labelMedium?.toLight,
                    ),
                    if (state.currentProxyName.isNotEmpty) ...[
                      const Icon(Icons.arrow_right),
                      Text(
                        state.currentProxyName,
                        style: context.textTheme.labelMedium?.toLight,
                      ),
                    ]
                  ],
                )
              ],
            ),
            shape: const RoundedRectangleBorder(
              side: BorderSide.none,
            ),
            collapsedShape: const RoundedRectangleBorder(
              side: BorderSide.none,
            ),
            childrenPadding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 8,
              right: 8,
            ),
            children: [
              Grid(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: _getColumns(state.viewMode),
                children: [
                  for (final proxy in proxies)
                    ProxyCard(
                      isSelected: state.currentProxyName == proxy.name,
                      key: ValueKey('$groupName.${proxy.name}'),
                      proxy: proxy,
                      groupName: groupName,
                    )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProxyCard extends StatelessWidget {
  final String groupName;
  final Proxy proxy;
  final bool isSelected;

  const ProxyCard({
    super.key,
    required this.groupName,
    required this.proxy,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final measure = globalState.appController.measure;
    return CommonCard(
      type: CommonCardType.filled,
      isSelected: isSelected,
      onPressed: (){
        final appController = globalState.appController;
        final group = appController.appState.getGroupWithName(groupName)!;
        if (group.type != GroupType.Selector) {
          globalState.showSnackBar(
            context,
            message: appLocalizations.notSelectedTip,
          );
          return;
        }
        globalState.appController.config.updateCurrentSelectedMap(
          groupName,
          proxy.name,
        );
        globalState.appController.changeProxy();
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: measure.bodyMediumHeight * 2,
              child: Text(
                proxy.name,
                maxLines: 2,
                style: context.textTheme.bodyMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: measure.bodySmallHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    proxy.type,
                    style: context.textTheme.bodySmall?.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color: context.textTheme.bodySmall?.color?.toLight(),
                    ),
                  ),
                  Selector<AppState, int?>(
                    selector: (context, appState) => appState.getDelay(
                      proxy.name,
                    ),
                    builder: (_, delay, __) {
                      return FadeBox(
                        child: Builder(
                          builder: (_) {
                            if (delay == null) {
                              return Container();
                            }
                            if (delay == 0) {
                              return SizedBox(
                                height: measure.labelSmallHeight,
                                width: measure.labelSmallHeight,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            }
                            return Text(
                              delay > 0 ? '$delay ms' : "Timeout",
                              style: context.textTheme.labelSmall?.copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: other.getDelayColor(
                                  delay,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
