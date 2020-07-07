
//
//  JSONParcer.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 12.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

enum AppError: Error {
    case jsonError
}

protocol JSONParser {
    func parseJSON(file: String) -> Result<[DataModel], AppError>
}

final class JSONParserImpl: JSONParser {
    
    public func parseJSON(file: String) -> Result<[DataModel], AppError>  {
        if let url = Bundle.main.url(forResource: file, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([DataModel].self, from: data)
                return .success(jsonData)
            } catch {
                print("error:\(error)")
            }
        }
        return .failure(.jsonError)
    }
}
