//
//  HomeViewModel.swift
//  TraysSwiftUI
//
//  Created by Abhishek Chandrashekar on 21/02/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import Foundation

class HomeViewModel : ObservableObject {
    
    var trays:[Tray]
    
    init() {
        trays = NetworkManager.getTabResponse()
    }
    
}
