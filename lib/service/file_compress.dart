import 'dart:io';
import 'dart:typed_data';
//import 'package:flutter_image_compress/flutter_image_compress.dart';
/*

// ignore: camel_case_types
class File_compress {
  
  // 1. compress file and get Uint8List
  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    print(file.lengthSync());
    print(result!.length);
    return result;
  }

  // 2. compress file and get file.
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88,
        rotate: 0,
      );

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }

  // 3. compress asset and get Uint8List.
  Future<Uint8List> testCompressAsset(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 180,
    );

    return list!;
  }

  // 4. compress Uint8List and get another Uint8List.
  Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    print(list.length);
    print(result.length);
    return result;
  }


  Future<File> compressImage(File file) async {
    // Get file path
    // eg:- "Volume/VM/abcd.jpeg"
    final filePath = file.absolute.path;
    
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    print("image image imahe ibcdhef");
    print(filePath);
    final newfilepath = filePath.substring(1);
    final lastIndex = newfilepath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = newfilepath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${newfilepath.substring(lastIndex)}";

    print("image image imahe ibcdhef");
    print(filePath);
    print("image image imahe ibcdhef");
    print(newfilepath);
    print("image image imahe ibcdhef");
    print(outPath);

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
          newfilepath, 
          outPath,
          quality: 70);
    
    print(compressedImage);

    return compressedImage!;
  }
  
}*/