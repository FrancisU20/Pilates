import 'dart:convert';
import 'package:http/http.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/file-asset/file_asset_model.dart';
import 'package:pilates/services/api_base_service.dart';

class FileAssetController {
  Future<StandardResponse<FileAssetModel>> postS3File(
      MultipartFile file, String folderPath, String dni) async {
    try {
      final apiBase =
          await ApiBaseService.create(contentType: 'multipart/form-data');

      String awsFoldetPath = '$folderPath/$dni';

      List<MultipartFile> fileList = [file];
      FileAssetModel sendFileAssetModel = FileAssetModel(path: awsFoldetPath);

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

      StandardResponse<FileAssetModel> fileAssetResponse = StandardResponse<FileAssetModel>.fromJson(
        serverJson,
        (data) => FileAssetModel.fromJson(data),
      );

      return fileAssetResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
