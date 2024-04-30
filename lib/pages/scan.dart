import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [BarcodeFormat.qrCode],
  );

  StreamSubscription<Object?>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = controller.barcodes.listen(_handleBarcode);
    unawaited(controller.start());
  }

  _handleBarcode(BarcodeCapture barcodeCapture) {
    final barcode = barcodeCapture.barcodes.first;
    if (barcode.type == BarcodeType.url) {
      Navigator.pop<String>(
        context,
        barcode.rawValue,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    double sideLength = min(400, MediaQuery.of(context).size.width * 0.67);
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: sideLength,
      height: sideLength,
    );
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: MobileScanner(
              controller: controller,
              scanWindow: scanWindow,
            ),
          ),
          CustomPaint(
            painter: ScannerOverlay(scanWindow: scanWindow),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: IconButton(
              style: const ButtonStyle(
                iconSize: MaterialStatePropertyAll(32),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder<MobileScannerState>(
              valueListenable: controller,
              builder: (context, state, _) {
                var icon = const Icon(Icons.flash_off);
                var backgroundColor = Colors.black12;
                switch (state.torchState) {
                  case TorchState.off:
                    icon = const Icon(Icons.flash_off);
                    backgroundColor = Colors.black12;
                  case TorchState.on:
                    icon = const Icon(Icons.flash_on);
                    backgroundColor = Colors.orange;
                  case TorchState.unavailable:
                    icon = const Icon(Icons.no_flash);
                    backgroundColor = Colors.grey;
                }
                return IconButton(
                  color: Colors.white,
                  icon: icon,
                  style: ButtonStyle(
                    foregroundColor:
                    const MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(backgroundColor),
                  ),
                  padding: const EdgeInsets.all(16),
                  iconSize: 32.0,
                  onPressed: () => controller.toggleTorch(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}