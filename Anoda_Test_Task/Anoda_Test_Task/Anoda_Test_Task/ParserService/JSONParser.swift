
//
//  JSONParcer.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 12.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

final class JSONParser {
    
    public func parseJSON(file: String) -> [DataModel]? {
        if let url = Bundle.main.url(forResource: file, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([DataModel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
