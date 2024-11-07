// 🌎 Project imports:
import 'package:dvizh_mob/core/models/message_response/message_response_model.dart';
import 'package:dvizh_mob/core/models/model/dto.dart';

class MessageResponseDTO with DTO {
  MessageResponseDTO({required this.message});

  factory MessageResponseDTO.fromJson(Map<String, Object?> json) =>
      MessageResponseDTO(message: json['message'] as String);

  final String message;

  @override
  MessageResponseModel toModel() => MessageResponseModel(message: message);
}
