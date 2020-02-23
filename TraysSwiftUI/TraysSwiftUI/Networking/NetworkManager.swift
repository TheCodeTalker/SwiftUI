//
//  NetworkManager.swift
//  Trays
//
//  Created by Abhishek Chandrashekar on 21/01/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    
    static func getTabResponse() -> [Tray] {
        let trays: GenericResponse = self.loadJSON(name: "TrayTabResponse")!
        return trays.assets!
    }
    
    static func loadJSON<T: Decodable>(name: String) -> T? {
        guard let filePath = Bundle.main.url(forResource: name, withExtension: "json") else {
            return nil
        }
        guard let jsonData = try? Data(contentsOf: filePath, options: .mappedIfSafe) else {
            return nil
        }
        guard (try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)) != nil else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: jsonData)
            return object
        }
        catch {
            print(error)
        }
        return nil
    }
    
}
