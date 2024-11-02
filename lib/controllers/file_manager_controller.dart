import 'dart:convert';
import 'dart:developer';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:pilates/models/response/error_response.dart';
import 'package:pilates/models/response/upload_profile_photo_response.dart';
import 'package:pilates/services/api_base_service.dart';

class FileManagerController {
  Future<MultipartFile> convertToFile(XFile file) async {
    MultipartFile multipartFiles = MultipartFile.fromBytes(
      'file',
      await file.readAsBytes(),
      filename: file.name,
    );
    return multipartFiles;
  }

  Future<XFile> compressImage(XFile file) async {
  final targetPath = file.path.replaceAll('.jpg', '_compressed.jpg');

  var result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 70,
    minHeight: 1920,
    minWidth: 1080,
  );

  return XFile(result!.path);
}

  Future<UploadS3Response> postS3ProfilePhoto(
    XFile profilePhoto, String dni) async {
  try {
    final apiBase = await ApiBaseService.create(
        isLogging: false, typeHeader: 'multipart/form-data');

    // Comprimir la imagen antes de convertirla a MultipartFile
    XFile compressedProfilePhoto = await compressImage(profilePhoto);

    MultipartFile multipartFile = await convertToFile(compressedProfilePhoto);

    List<MultipartFile> multipartFiles = [multipartFile];

    final response = await apiBase.multipartRequest(
        '/api/file_manager/upload_image/$dni',
        files: multipartFiles);

    String stringImage = await response.stream.bytesToString();

    Map<String, dynamic> decodedJson = json.decode(stringImage);

    if (response.statusCode == 201) {
      UploadS3Response uploadProfilePhotoResponse =
          UploadS3Response.fromJson(decodedJson);
      return uploadProfilePhotoResponse;
    } else {
      log('Error del servidor en /api/file_manager/upload_image con código: ${response.statusCode}');
      throw Exception(decodedJson['message']);
    }
  } catch (e) {
    log('$e');
    ErrorResponse errorResponse = ErrorResponse.fromJson(
        json.decode(e.toString().replaceAll('Exception: ', '')));
    throw Exception(errorResponse.message);
  }
}

  Future<UploadS3Response> postS3TransferVoucher(
      XFile profilePhoto, String dni) async {
    try {
      final apiBase = await ApiBaseService.create(
          isLogging: false, typeHeader: 'multipart/form-data');

      // Comprimir la imagen antes de convertirla a MultipartFile
      XFile compressedProfilePhoto = await compressImage(profilePhoto);

      MultipartFile multipartFile = await convertToFile(compressedProfilePhoto);

      List<MultipartFile> multipartFiles = [multipartFile];

      final response = await apiBase.multipartRequest(
          '/api/file_manager/upload_transfer_voucher/$dni',
          files: multipartFiles);

      Map<String, dynamic> decodedJson =
          json.decode(await response.stream.bytesToString());

      if (response.statusCode == 201) {
        UploadS3Response uploadProfilePhotoResponse =
            UploadS3Response.fromJson(decodedJson);
        return uploadProfilePhotoResponse;
      } else {
        log('Error del servidor en /api/file_manager/upload_transfer_voucher con código: ${response.statusCode}');
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
