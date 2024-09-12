import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/card.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const actions = [
  "启动/暂停",
  "显示/隐藏",
  "切换模式",
  "系统代理",
  "虚拟网卡",
];

class HotKeyFragment extends StatelessWidget {
  const HotKeyFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: actions.length,
      itemBuilder: (_, index) {
        return ListItem(
          title: Text(actions[index]),
          onTap: () {
            globalState.showCommonDialog(
              child: HotKeyRecorder(
                title: actions[index],
              ),
            );
          },
        );
      },
    );
  }
}

class HotKeyRecorder extends StatefulWidget {
  final String title;

  const HotKeyRecorder({
    super.key,
    required this.title,
  });

  @override
  State<HotKeyRecorder> createState() => _HotKeyRecorderState();
}

class _HotKeyRecorderState extends State<HotKeyRecorder> {
  Set<PhysicalKeyboardKey> keys = {};

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  bool _handleKeyEvent(KeyEvent keyEvent) {
    if (keyEvent is KeyUpEvent) return false;
    keys = HardwareKeyboard.instance.physicalKeysPressed;
    List<KeyModifier>? modifiers = KeyModifier.values
        .where((e) => e.physicalKeys.any(keys.contains))
        .toList();
    // setState(() {
    //
    // });
    return true;
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: dialogCommonWidth,
        child: Wrap(
          spacing: 8,
          children: [
            for (final key in keys)
              KeyboardKeyBox(
                keyboardKey: key,
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text("确定"),
        ),
      ],
    );
  }
}

class KeyboardKeyBox extends StatelessWidget {
  final KeyboardKey keyboardKey;

  const KeyboardKeyBox({
    super.key,
    required this.keyboardKey,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          keyboardKey.label,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      onPressed: () {},
    );
  }
}
