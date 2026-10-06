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
}
