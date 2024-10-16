

import '../model/dto.dart';
import 'message_response_model.dart';

class MessageResponseDTO extends DTO {
  final String message;
  MessageResponseDTO({required this.message});

  factory MessageResponseDTO.fromJson(Map<String, dynamic> json) {
    return MessageResponseDTO(message: json['message']);
  }

  @override
  MessageResponseModel toModel() {
    return MessageResponseModel(message: message);
  }
}
