//
//  HomeScreenSUI.swift
//  Trays
//
//  Created by Abhishek Chandrashekar on 23/01/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    init() {
        viewModel = HomeViewModel()
    }
    
    var body: some View {
        //id :  keypath/ identifiable / Hashable
        List {
            ForEach(viewModel.trays) { tray in
                self.constructTray(tray: tray)
            }
        }
    }
    
    func constructTray(tray:Tray) -> some View {
        switch  tray.trayLayout {
        case .gridTray:
                let grid = GridView(tray.items!, columns: 3, columnsInLandscape: 5, vSpacing: 10, hSpacing: 10, vPadding: 5, hPadding: 5) { item in
                    MediaCell(media: item)
                }
               return  AnyView(grid)
        case .listTray:
                let list = ListView(tray.items!) { rowItem  in
                    MediaRowCell(_media: rowItem)
                }
               return  AnyView(list)
        default:
              return  AnyView(Text("Unknown type"))
        }
    }
}


