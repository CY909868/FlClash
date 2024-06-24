import 'package:collection/collection.dart';
import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card.dart';

class ProxiesTabFragment extends StatefulWidget {
  const ProxiesTabFragment({super.key});

  @override
  State<ProxiesTabFragment> createState() => _ProxiesTabFragmentState();
}

class _ProxiesTabFragmentState extends State<ProxiesTabFragment>
    with TickerProviderStateMixin {
  TabController? _tabController;

  _handleTabControllerChange() {
    final indexIsChanging = _tabController?.indexIsChanging ?? false;
    if (indexIsChanging) return;
    final index = _tabController?.index;
    if (index == null) return;
    final appController = globalState.appController;
    final currentGroups = appController.appState.currentGroups;
    if (currentGroups.length > index) {
      appController.config.updateCurrentGroupName(currentGroups[index].name);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

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
      shouldRebuild: (prev, next) {
        if (!const ListEquality<String>()
            .equals(prev.groupNames, next.groupNames)) {
          _tabController?.removeListener(_handleTabControllerChange);
          _tabController?.dispose();
          _tabController = null;
          return true;
        }
        return false;
      },
      builder: (_, state, __) {
        final index = state.groupNames.indexWhere(
          (item) => item == state.currentGroupName,
        );
        _tabController ??= TabController(
          length: state.groupNames.length,
          initialIndex: index == -1 ? 0 : index,
          vsync: this,
        )..addListener(_handleTabControllerChange);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              controller: _tabController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              dividerColor: Colors.transparent,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              tabs: [
                for (final groupName in state.groupNames)
                  Tab(
                    text: groupName,
                  ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  for (final groupName in state.groupNames)
                    KeepContainer(
                      key: ObjectKey(groupName),
                      child: ProxiesTabView(
                        groupName: groupName,
                      ),
                    ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class ProxiesTabView extends StatelessWidget {
  final String groupName;

  const ProxiesTabView({
    super.key,
    required this.groupName,
  });

  List<Proxy> _sortOfName(List<Proxy> proxies) {
    return List.of(proxies)
      ..sort(
        (a, b) => other.sortByChar(a.name, b.name),
      );
  }

  List<Proxy> _sortOfDelay(BuildContext context, List<Proxy> proxies) {
    final appState = context.read<AppState>();
    return proxies = List.of(proxies)
      ..sort(
        (a, b) {
          final aDelay = appState.getDelay(a.name);
          final bDelay = appState.getDelay(b.name);
          if (aDelay == null && bDelay == null) {
            return 0;
          }
          if (aDelay == null || aDelay == -1) {
            return 1;
          }
          if (bDelay == null || bDelay == -1) {
            return -1;
          }
          return aDelay.compareTo(bDelay);
        },
      );
  }

  double _getItemHeight(ProxyCardType proxyCardType) {
    final isExpand = proxyCardType == ProxyCardType.expand;
    final measure = globalState.appController.measure;
    final baseHeight =
        12 * 2 + measure.bodyMediumHeight * 2 + measure.bodySmallHeight + 8;
    return isExpand ? baseHeight + measure.labelSmallHeight + 8 : baseHeight;
  }

  _getProxies(
    BuildContext context,
    List<Proxy> proxies,
    ProxiesSortType proxiesSortType,
  ) {
    if (proxiesSortType == ProxiesSortType.delay) {
      return _sortOfDelay(context, proxies);
    }
    if (proxiesSortType == ProxiesSortType.name) return _sortOfName(proxies);
    return proxies;
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

  _delayTest(List<Proxy> proxies) async {
    for (final proxy in proxies) {
      final appController = globalState.appController;
      final proxyName =
          appController.appState.getRealProxyName(proxy.name) ?? proxy.name;
      globalState.appController.setDelay(
        Delay(
          name: proxyName,
          value: 0,
        ),
      );
      clashCore.getDelay(proxyName).then((delay) {
        globalState.appController.setDelay(delay);
      });
    }
    await Future.delayed(httpTimeoutDuration + moreDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Selector2<AppState, Config, ProxyGroupSelectorState>(
      selector: (_, appState, config) {
        final group = appState.getGroupWithName(groupName)!;
        final currentProxyName =
            config.currentSelectedMap[group.name] ?? group.now;
        return ProxyGroupSelectorState(
          proxyCardType: config.proxyCardType,
          proxiesSortType: config.proxiesSortType,
          sortNum: appState.sortNum,
          group: group,
          viewMode: appState.viewMode,
          currentProxyName: currentProxyName ?? '',
        );
      },
      builder: (_, state, __) {
        final proxies = _getProxies(
          context,
          state.group.all,
          state.proxiesSortType,
        );
        return DelayTestButtonContainer(
          onClick: () async {
            await _delayTest(
              state.group.all,
            );
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getColumns(state.viewMode),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: _getItemHeight(state.proxyCardType),
              ),
              itemCount: proxies.length,
              itemBuilder: (_, index) {
                final proxy = proxies[index];
                return ProxyCard(
                  type: state.proxyCardType,
                  key: ValueKey('$groupName.${proxy.name}'),
                  isSelected: state.currentProxyName == proxy.name,
                  proxy: proxy,
                  groupName: groupName,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class DelayTestButtonContainer extends StatefulWidget {
  final Widget child;
  final Future Function() onClick;

  const DelayTestButtonContainer({
    super.key,
    required this.child,
    required this.onClick,
  });

  @override
  State<DelayTestButtonContainer> createState() =>
      _DelayTestButtonContainerState();
}

class _DelayTestButtonContainerState extends State<DelayTestButtonContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  _healthcheck() async {
    _controller.forward();
    await widget.onClick();
    _controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          1,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.reverse();
    return FloatLayout(
      floatingWidget: FloatWrapper(
        child: AnimatedBuilder(
          animation: _controller.view,
          builder: (_, child) {
            return SizedBox(
              width: 56,
              height: 56,
              child: Transform.scale(
                scale: _scale.value,
                child: child,
              ),
            );
          },
          child: FloatingActionButton(
            heroTag: null,
            onPressed: _healthcheck,
            child: const Icon(Icons.network_ping),
          ),
        ),
      ),
      child: widget.child,
    );
  }
}
