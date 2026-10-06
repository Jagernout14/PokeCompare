//
//  NetworkError.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 04.10.2026.
//

enum NetworkError: Error {
    case noInternet
    case badUrl
    case clientError(Int)
    case serverError(Int)
    case decodeError
    case encodeError
    case unknownError
    case responseError
    case authorizationProblem
    
    var userMessage: String {
        switch self {
        case .noInternet:
            return "Проблемы с интернет соединением"
        case .badUrl:
            return "Ссылка невалидна"
        case .clientError(let code):
            return "Ошибка клиента, код: \(code)"
        case .serverError(let code):
            return "Ошибка сервера, код: \(code)"
        case .decodeError:
            return "Ошибка декодирования"
        case .encodeError:
            return "Ошибка кодирования"
        case .unknownError:
            return "Неизвестная ошибка"
        case .responseError:
            return "Ошибка ответа от сервера"
        case .authorizationProblem:
            return "Ошибка авторизации"
        }
    }
}
