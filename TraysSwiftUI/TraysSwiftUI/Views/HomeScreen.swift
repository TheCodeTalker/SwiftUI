//
//  HomeScreenSUI.swift
//  Trays
//
//  Created by Abhishek Chandrashekar on 23/01/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    @State var trays : [Tray]
    
    var body: some View {
        //id :  keypath/ identifiable / Hashable
        List() {
            ForEach(trays) { tray in
                self.constructTray(tray: tray)
            }
        }
    }
    
    func constructTray(tray:Tray) -> some View {
//        switch  tray.trayLayout {
//        case .gridTray:
//            return
//                AnyView(GridView(gridTray: tray, horizontalItemCount: 3, minimisedView: true))
//            break
//        default: break
//            return
//                AnyView(GridView(gridTray: tray, horizontalItemCount: 3, minimisedView: true))
//            break
//        }
        return AnyView(Text(tray.trayName ?? ""))
    }
}

struct HomeScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeScreen(trays: [])
    }
}
