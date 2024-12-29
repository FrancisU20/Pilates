import 'dart:convert';
import 'dart:developer';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:pilates/models/response/error_response.dart';
import 'package:pilates/models/response/upload_profile_photo_response.dart';
import 'package:pilates/models/send/file_asset_send.dart';
import 'package:pilates/services/api_base_service.dart';

class FileAssetController {
  Future<MultipartFile> convertToFile(XFile file) async {
    try {
      MultipartFile multipartFiles = MultipartFile.fromBytes(
        'file',
        await file.readAsBytes(),
        filename: file.name,
      );
      return multipartFiles;
    } catch (e) {
      log('Error al convertir el archivo a file:$e');
      throw Exception('Error al convertir la imagen');
    }
  }

  Future<XFile> compressImage(XFile file) async {
    try {
      final targetPath = file.path.replaceAll('.jpg', '_compressed.jpg');

      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        quality: 60,
        minHeight: 1280,
        minWidth: 720,
      );

      return XFile(result!.path);
    } catch (e) {
      log('Error al comprimir la imagen:$e');
      throw Exception('Error al comprimir la imagen');
    }
  }

  Future<UploadS3Response> postS3File(
      XFile profilePhoto, String folderPath, String dni) async {
    try {
      final apiBase =
          await ApiBaseService.create(contentType: 'multipart/form-data');

      // Comprimir la imagen
      XFile compressedProfilePhoto = await compressImage(profilePhoto);

      // Convertir la imagen comprimida a un archivo
      MultipartFile multipartFile = await convertToFile(compressedProfilePhoto);

      List<MultipartFile> multipartFiles = [multipartFile];

      // Crear el body del request donde se envia la data
      String jsonBody = json
          .encode(FileAssetSend(path: folderPath, userDniNumber: dni).toJson());

      final response = await apiBase.multipartRequest('/file-asset',
          files: multipartFiles, bodyRequest: jsonBody);

      String stringImage = await response.stream.bytesToString();

      Map<String, dynamic> decodedJson = json.decode(stringImage);

      if (response.statusCode == 201) {
        UploadS3Response uploadProfilePhotoResponse =
            UploadS3Response.fromJson(decodedJson);
        return uploadProfilePhotoResponse;
      } else {
        throw Exception(decodedJson['message']);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }
}
