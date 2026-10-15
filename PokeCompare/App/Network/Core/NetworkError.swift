//
//  NetworkError.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 04.10.2026.
//

import Foundation

enum NetworkError: Error {
    case transport(Error)
    case badUrl
    case clientError(Int)
    case serverError(Int)
    case decoding(Error)
    case encodeError
    case unknownError
    case responseError
    case authorizationProblem
    
    var userMessage: String {
        switch self {
        case .transport(let error):
            guard let urlError = error as? URLError else {
                return "Что-то пошло не так"
            }
            switch urlError.code {
            case .notConnectedToInternet:
                return "Проверьте интернет соединение"
            case .networkConnectionLost:
                return "Потеряно соединение с интернетом"
            case .timedOut:
                return "Сервер не отвечает, попробуйте позже"
            case .cannotFindHost, .cannotConnectToHost:
                return "Сервис недоступен, попробуйте позже"
            default:
                return "Проблема с подключением"
            }
            
        case .serverError:
            return "Проблема сервера, повторите позже"
        case .authorizationProblem:
            return "Проблема авторизации, войдите еще раз"
        case .badUrl, .clientError, .decoding, .encodeError, .unknownError, .responseError:
            return "Что-то пошло не так"
        }
    }
    
    var isRetryable: Bool {
        switch self {
        case .serverError:
            return true
        case .transport:
            return !isCancelled
            
        case .clientError(let code):
            if code == 429 {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    var isCancelled: Bool {
        switch self {
        case .transport(let error):
            guard let urlError = error as? URLError else {
                return false
            }
            return urlError.code == .cancelled
        default:
            return false
        }
    }
}
