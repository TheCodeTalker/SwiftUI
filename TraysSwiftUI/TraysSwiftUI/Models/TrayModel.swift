//
//  TrayModel.swift
//  Trays
//
//  Created by Abhishek Chandrashekar on 21/01/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import Foundation

struct Media: Decodable, Identifiable {
    var id = UUID()
    var title: String?
    var desc: String?
    
    private enum codingKeys : String, CodingKey {
        case id = "id"
        case title = "title"
        case desc = "desc"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        desc = try container.decode(String.self, forKey: .desc)
    }
}

struct Tray : Decodable, Identifiable {
    var id = UUID()
    var trayName: String?
    var trayLayout: TrayLayout?
    var trayContentType: TrayType?
    var items: [Media]?
    
    private enum TrayKeys : String, CodingKey {
        case id = "id"
        case trayName = "trayName"
        case trayLayout = "trayLayout"
        case trayContentType = "trayContentType"
        case assets = "assets"
        case items = "items"
    }
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TrayKeys.self)
        trayName = try container.decode(String.self, forKey: .trayName)
        trayLayout = try container.decode(TrayLayout.self, forKey: .trayLayout)
        trayContentType = try container.decode(TrayType.self, forKey: .trayContentType)
        let assets = try container.decode([[String:[Media]]].self, forKey: .assets)
        items = assets.compactMap{$0[TrayKeys.items.rawValue]}.reduce([], +)
    }

}

struct GenericResponse : Decodable {
    var assets: [Tray]?
}
