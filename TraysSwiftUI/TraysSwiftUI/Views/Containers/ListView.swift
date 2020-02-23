//
//  ListView.swift
//  TraysSwiftUI
//
//  Created by Abhishek Chandrashekar on 19/02/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import SwiftUI

struct ListView  <Data, Content>: View
   where Data : RandomAccessCollection, Content : View, Data.Element : Identifiable {
   
   private struct GridIndex : Identifiable { var id: Int }

   // MARK: - STORED PROPERTIES
   private let data: [Data.Element]
   private let content: (Data.Element) -> Content

    public init(_ data: Data,
                content: @escaping (Data.Element) -> Content) {
      self.data = data.map { $0 }
      self.content = content
    }
    
    var body: some View {
        VStack {
            Text("List View").foregroundColor(.black).bold()
            ForEach(data) { item in
                self.content(item)
            }
               
        }
    }
}

struct MediaRowCell: View {
    var media: Media

    init(_media:Media) {
        media = _media
    }
    
    var body: some View {
        HStack {
            Text(media.desc ?? "")
            Text(media.title ?? "")
        }
        .aspectRatio(contentMode: .fill)
    }
}
