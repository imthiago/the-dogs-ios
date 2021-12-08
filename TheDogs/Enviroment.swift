//
//  Enviroment.swift
//  TheDogs
//
//  Created by Thiago Oliveira on 08/12/21.
//

import Foundation

final class Environment {
    enum EnvironmentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
        case apiKey     = "API_KEY"
    }

    static func variable(_ key: EnvironmentVariables) -> String {
        guard let variable = Bundle.main.infoDictionary?[key.rawValue] as? String else {
            return ""
        }
        return variable
    }
}
