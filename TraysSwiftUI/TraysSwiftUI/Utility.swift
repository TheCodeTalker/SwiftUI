//
//  Utility.swift
//  Trays
//
//  Created by Abhishek Chandrashekar on 21/01/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import Foundation
import SwiftUI


class Utility {
    
    static let shared = Utility()
    
    private init() {}
    
    static func readJSONFromFile(fileName: String) -> Any?
    {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
