import 'dart:convert';
import 'dart:io';

import 'package:ajiledakarv/models/Soiree.dart';
import 'package:path_provider/path_provider.dart';

class FileHandlerLive {
  // Makes this a singleton class, as we want only want a single
  // instance of this object for the whole application
  FileHandlerLive._privateConstructor();
  static final FileHandlerLive instance = FileHandlerLive._privateConstructor();
  static File? _file;
  static final _fileName = 'soireeLives.txt';
  static Set<Soiree> _liveSet = {};

  // Get the data file
  Future<File> get file async {
    if (_file != null) {
      return _file!;
    } else {
      _file = await _initFile();
    }

    return _file!;
  }

  // Inititalize file
  Future<File> _initFile() async {
    print("i am here for test");
    final _directory = await getApplicationDocumentsDirectory();
    print(_directory);
    final _path = _directory.path;
    return File('$_path/$_fileName');
  }

  Future<void> writeLive(Soiree live) async {
    final File fl = await file;
    _liveSet.add(live);

    // Now convert the set to a list as the jsonEncoder cannot encode
    // a set but a list.
    final _liveListMap = _liveSet.map((e) => e.toJson()).toList();

    print("writing writing");
    print(_liveSet);

    await fl.writeAsString(jsonEncode(_liveListMap));
  }

  Future<List<Soiree>> readLives() async {
    final File fl = await file;
    final _content = await fl.readAsString();

    final List<dynamic> _jsonData = jsonDecode(_content);
    final List<Soiree> _lives = _jsonData
        .map(
          (e) => Soiree.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    return _lives;
  }

  Future<void> deleteLive(Soiree live) async {
    final File fl = await file;

    _liveSet.removeWhere((e) => e == live);
    final _liveListMap = _liveSet.map((e) => e.toJson()).toList();

    await fl.writeAsString(jsonEncode(_liveListMap));
  }

  Future<void> updateLive({
    int? id,
    Soiree? updatedLive,
  }) async {
    _liveSet.removeWhere((e) => e.id == updatedLive!.id);
    await writeLive(updatedLive!);
  }
}
