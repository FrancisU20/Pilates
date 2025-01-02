import 'dart:convert';
import 'package:http/http.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/file-asset/file_asset_model.dart';
import 'package:pilates/services/api_base_service.dart';

class FileAssetController {
  Future<FileAssetModel> postS3File(
      MultipartFile file, String folderPath, String dni) async {
    try {
      final apiBase =
          await ApiBaseService.create(contentType: 'multipart/form-data');

      List<MultipartFile> fileList = [file];
      FileAssetModel sendFileAssetModel = FileAssetModel(path: folderPath);

      String dataJson = jsonEncode(sendFileAssetModel.toJson());

      final response = await apiBase.multipartRequest('/file-asset',
          files: fileList, bodyRequest: dataJson);

      final serverStream = await response.stream.bytesToString();
      final serverJson = json.decode(serverStream);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      final fileAssetResponse = StandardResponse<FileAssetModel>.fromJson(
        serverJson,
        (data) => FileAssetModel.fromJson(data),
      );

      FileAssetModel fileAsset = fileAssetResponse.data!;

      return fileAsset;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
