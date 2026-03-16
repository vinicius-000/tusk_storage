import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sqflite/sqflite.dart';

class Backup {
  static const dbName = 'storage.db';

  static Future<File> _dbFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return File(path);
  }

  // Export
  static Future<void> exportDb() async {
    final db = await _dbFile();
    if (!db.existsSync()) {
      debugPrint('DB não existe');
      return;
    }

    final bytes = await db.readAsBytes();

    await FilePicker.platform.saveFile(
      dialogTitle: 'Save database backup',
      fileName: 'storage_backup.db',
      bytes: bytes, // 🔥 OBRIGATÓRIO
    );
  }

  // Import
  static Future<bool> importDb() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result == null) return false;

    final path = result.files.single.path;

    if (path == null || !path.endsWith('.db')) {
      return false;
    }

    final picked = File(path);
    final db = await _dbFile();

    await db.writeAsBytes(await picked.readAsBytes(), flush: true);
    return true;
  }

  // Confirmation
  static Future<bool> showImportConfirmDialog(BuildContext context) async {
    return await showDialog<bool>(

      context: context,
      builder: (context) => AlertDialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        title: const Text('Import database'),

        content: const Text(
          'This action cannot be undone.\n\n'
          'Do you want to continue?',
        ),

        actions: [

          ElevatedButton(
            child: const Text('Import', style: TextStyle(color: Color(0xFFB61414))),
            onPressed: () => Navigator.pop(context, true),
          ),

          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    ) ??
        false;
  }

}