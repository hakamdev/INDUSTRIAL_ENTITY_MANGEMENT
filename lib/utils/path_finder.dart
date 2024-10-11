import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class XPathFinder {
  static Future init() async {
    _imageStorageDir = await _getImagesStorageDirectory();
    _storageDir = await _getStorageDirectory();
    _appDownloadsDir = await _getAppDownloadsDirectory();
    _appDocumentsDir = await getApplicationDocumentsDirectory();
  }

  static Directory? _imageStorageDir;
  static Directory? _storageDir;
  static Directory? _appDownloadsDir;
  static Directory? _appDocumentsDir;

  static Directory get imageStorageDir => _imageStorageDir!;

  static Directory get storageDir => _storageDir!;

  static Directory get downloadsDir => _appDownloadsDir!;

  static Directory get documentsDir => _appDocumentsDir!;

  static Future<Directory> _getImagesStorageDirectory() async {
    Directory? appStorageDir;
    if (Platform.isAndroid) {
      appStorageDir = await getExternalStorageDirectory();
    } else {
      appStorageDir = await getApplicationDocumentsDirectory();
    }
    appStorageDir ??= await getApplicationDocumentsDirectory();
    final appImagesDir = Directory("${appStorageDir.path}/images");
    if (!(await appImagesDir.exists())) {
      await appImagesDir.create(recursive: true);
    }
    return appImagesDir;
  }

  static Future<Directory> _getStorageDirectory() async {
    Directory? appStorageDir;
    if (Platform.isAndroid) {
      appStorageDir = await getExternalStorageDirectory();
    } else {
      appStorageDir = await getApplicationDocumentsDirectory();
    }
    appStorageDir ??= await getApplicationDocumentsDirectory();
    return appStorageDir;
  }

  static Future<Directory> _getAppDownloadsDirectory() async {
    Directory? appStorageDir;
    if (Platform.isAndroid) {
      appStorageDir = await getExternalStorageDirectory();
    } else {
      appStorageDir = await getApplicationDocumentsDirectory();
    }
    appStorageDir ??= await getApplicationDocumentsDirectory();
    final appDownloadsDir = Directory("${appStorageDir.path}/downloads");
    if (!(await appDownloadsDir.exists())) {
      await appDownloadsDir.create(recursive: true);
    }
    return appDownloadsDir;
  }
}
