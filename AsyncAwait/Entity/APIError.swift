//
//  APIError.swift
//  AsyncAwait
//
//  Created by 宮本光直 on 2021/12/31.
//

import SwiftUI

enum APIError: Error {
    case unknown(message: String)
    case other
    
    var message: String {
        switch self {
        case .unknown(let message):
            return message
        default:
            return "エラーです！！！！"
        }
    }
}
