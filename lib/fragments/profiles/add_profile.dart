import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/pages/scan.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddProfile extends StatelessWidget {
  final BuildContext context;

  const AddProfile({super.key, required this.context,});

  _handleAddProfileFormFile() async {
    globalState.appController.addProfileFormFile();
  }

  _handleAddProfileFormURL(String url, {String? label}) async {
    globalState.appController.addProfileFormURL(url, label: label);
  }

  _toScan() async {
    if(system.isDesktop){
      globalState.appController.addProfileFormQrCode();
      return;
    }
    final url = await Navigator.of(context)
        .push<String>(MaterialPageRoute(builder: (_) => const ScanPage()));
    if (url != null) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        _handleAddProfileFormURL(url);
      });
    }
  }

  _toAdd() async {
    // final url = await globalState.showCommonDialog<String>(
    //   child: const URLFormDialog(),
    // );
    final urlAndName = await globalState.showCommonDialog<Map<String, String>>(
      child: const URLFormDialog(),
    );
    final url = urlAndName?['url'];
    final name = urlAndName?['name'];
    if (url != null) {
      _handleAddProfileFormURL(url, label: name);
    }
  }

  @override
  Widget build(context) {
    return ListView(
      children: [
          ListItem(
            leading: const Icon(Icons.qr_code),
            title: Text(appLocalizations.qrcode),
            subtitle: Text(appLocalizations.qrcodeDesc),
            onTap: _toScan,
          ),
        ListItem(
          leading: const Icon(Icons.upload_file),
          title: Text(appLocalizations.file),
          subtitle: Text(appLocalizations.fileDesc),
          onTap: _handleAddProfileFormFile,
        ),
        ListItem(
          leading: const Icon(Icons.cloud_download),
          title: Text(appLocalizations.url),
          subtitle: Text(appLocalizations.urlDesc),
          onTap: _toAdd,
        )
      ],
    );
  }
}

class URLFormDialog extends StatefulWidget {
  const URLFormDialog({super.key});

  @override
  State<URLFormDialog> createState() => _URLFormDialogState();
}


class _URLFormDialogState extends State<URLFormDialog> {
  final urlController = TextEditingController();
  final nameController = TextEditingController();

  _handleAddProfileFormURL() async {
    final url = urlController.value.text;
    final name = nameController.value.text;
    if (url.isEmpty) return;
    Navigator.of(context).pop<Map<String, String>>({
      'url': url,
      'name': name,
    });
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(appLocalizations.importFromURL),
      content: SizedBox(
        width: 300,
        child: Wrap(
          runSpacing: 16,
          children: [
            TextField(
              maxLines: 5,
              minLines: 1,
              controller: urlController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalizations.url,
              ),
            ),
            TextField(
              maxLines: 1,
              minLines: 1,
              controller: nameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalizations.urlName,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _handleAddProfileFormURL,
          child: Text(appLocalizations.submit),
        )
      ],
    );
  }
}
