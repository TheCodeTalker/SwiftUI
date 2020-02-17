//
//  TrayProtocol.swift
//  Trays
//
//  Created by Abhishek Chandrashekar on 21/01/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import Foundation


protocol TrayProtocol: class {
    var trayName: String { get set }
    var trayType: String { get set }
    var trayLayout: String { get set }
}

enum TrayLayout: String,Codable {
    case carousel
    case mastHeadTray
    case gridTray
    case segmentedTray
}

enum TrayType: String,Codable {
    case inline
    case dynamic
    case offline
    case crossservice
    case recommendation
}

