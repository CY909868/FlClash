import 'package:fl_clash/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSelector0<T> extends Selector0<T> {
  CustomSelector0({
    super.key,
    required ValueWidgetBuilder<T> builder,
    required T Function(BuildContext) selector,
    super.shouldRebuild,
    super.child,
  }) : super(
    selector: (context) => selector(context),
    builder: (_, __, ___) {
      return ThemeChangeBuilder(
        child: builder(_, __, ___),
      );
    },
  );
}

class CustomSelector<A, S> extends CustomSelector0<S> {
  CustomSelector({
    super.key,
    required super.builder,
    required S Function(BuildContext, A) selector,
    super.shouldRebuild,
    super.child,
  }) : super(
    selector: (context) => selector(
      context,
      Provider.of(context),
    ),
  );
}

class CustomSelector2<A, B, S> extends Selector0<S> {
  CustomSelector2({
    super.key,
    required super.builder,
    required S Function(BuildContext, A, B) selector,
    super.shouldRebuild,
    super.child,
  }) : super(
    selector: (context) => selector(
      context,
      Provider.of(context),
      Provider.of(context),
    ),
  );
}

class ScrollOverBuilder extends StatefulWidget {
  final Widget Function(bool isOver) builder;

  const ScrollOverBuilder({
    super.key,
    required this.builder,
  });

  @override
  State<ScrollOverBuilder> createState() => _ScrollOverBuilderState();
}

class _ScrollOverBuilderState extends State<ScrollOverBuilder> {
  final isOverNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    super.dispose();
    isOverNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (scrollNotification) {
        isOverNotifier.value = scrollNotification.metrics.maxScrollExtent > 0;
        return true;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: isOverNotifier,
        builder: (_, isOver, __) {
          return widget.builder(isOver);
        },
      ),
    );
  }
}

class ProxiesActionsBuilder extends StatelessWidget {
  final Widget? child;
  final Widget Function(
    ProxiesActionsState state,
    Widget? child,
  ) builder;

  const ProxiesActionsBuilder({
    super.key,
    required this.child,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<AppState, ProxiesActionsState>(
      selector: (_, appState) => ProxiesActionsState(
        isCurrent: appState.currentLabel == "proxies",
        hasProvider: appState.providers.isNotEmpty,
      ),
      builder: (_, state, child) => builder(state, child),
      child: child,
    );
  }
}

class ThemeChangeBuilder extends StatelessWidget {
  final Widget child;

  const ThemeChangeBuilder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<Config, ThemeState>(
      selector: (_, config) => ThemeState(
        locale: config.locale,
        scaleProps: config.scaleProps,
      ),
      builder: (_, context, __) {
        return child;
      },
    );
  }
}
