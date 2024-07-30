import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:github_user/repository/rest_client/rest_client_exception.dart';

abstract class IGlobalError {
  Future<GlobalErrorModel> errorHandling(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]);
}

class GlobalError implements IGlobalError {
  @override
  Future<GlobalErrorModel> errorHandling(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]) async {
    switch (error.runtimeType) {
      case const (SocketException):
        error as SocketException;
        error.message;
        return GlobalErrorModel(
          GlobalErrorTypes.connection,
          "Verifique a conexão e tente novamente",
        );
      case const (PlatformException):
        error as PlatformException;
        return GlobalErrorModel(
          GlobalErrorTypes.hardware,
          error.toString(),
        );
      case const (RestClientException):
        error as RestClientException;
        return GlobalErrorModel(
          GlobalErrorTypes.request,
          error.message,
        );
      case const (TimeoutException):
        error as TimeoutException;
        return GlobalErrorModel(
          GlobalErrorTypes.timeout,
          "Tempo limite da requisição esgotado",
        );
      default:
        if (error.toString().contains('Failed host lookup')) {
          return GlobalErrorModel(
            GlobalErrorTypes.connection,
            "Verifique a conexão e tente novamente",
          );
        }
        return GlobalErrorModel(
          GlobalErrorTypes.exception,
          error.toString(),
        );
    }
  }
}

class GlobalErrorModel {
  Enum type;
  String message;
  GlobalErrorModel(
    this.type,
    this.message,
  );

  @override
  String toString() {
    return message;
  }
}

enum GlobalErrorTypes {
  request,
  timeout,
  hardware,
  connection,
  exception,
}

/*
Exemplo de aplicação
final IGlobalError _globalError;

catch (e) {
  final globalError = await _globalError.globalError(
          descrição da função,
          e,
          StackTrace.current);
      _stateController.addError(globalError);
    }    
 
*/
