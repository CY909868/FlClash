import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tray_manager/tray_manager.dart';

class TrayManager extends StatefulWidget {
  final Widget child;

  const TrayManager({
    super.key,
    required this.child,
  });

  @override
  State<TrayManager> createState() => _TrayContainerState();
}

class _TrayContainerState extends State<TrayManager> with TrayListener {
  @override
  void initState() {
    super.initState();
    trayManager.addListener(this);
  }

  @override
  Widget build(BuildContext context) {
    return Selector3<AppState, Config, ClashConfig, TrayState>(
      selector: (_, appState, config, clashConfig) => TrayState(
        mode: clashConfig.mode,
        autoLaunch: config.autoLaunch,
        isStart: appState.isStart,
        locale: config.locale,
        systemProxy: config.desktopProps.systemProxy,
        tunEnable: clashConfig.tun.enable,
        brightness: appState.brightness,
      ),
      shouldRebuild: (prev, next) {
        if (prev != next) {
          globalState.appController.updateTray();
        }
        return prev != next;
      },
      builder: (_, state, child) {
        return child!;
      },
      child: widget.child,
    );
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  onTrayIconMouseDown() {
    window?.show();
  }

  @override
  dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }
}
