//
//  GridView.swift
//  TraysSwiftUI
//
//  Created by Abhishek Chandrashekar on 23/01/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct GridView <Data, Content>: View
    where Data : RandomAccessCollection, Content : View, Data.Element : Identifiable {
    
    private struct GridIndex : Identifiable { var id: Int }

    // MARK: - STORED PROPERTIES

    private let columns: Int
    private let columnsInLandscape: Int
    private let vSpacing: CGFloat
    private let hSpacing: CGFloat
    private let vPadding: CGFloat
    private let hPadding: CGFloat

    private let data: [Data.Element]
    private let content: (Data.Element) -> Content
    private let geometry: GeometryProxy
    // MARK: - INITIALIZERS

    /// Creates a QGrid that computes its cells on demand from an underlying
    /// collection of identified data.
    ///
    /// - Parameters:
    ///     - data: A collection of identified data.
    ///     - columns: Target number of columns for this grid, in Portrait device orientation
    ///     - columnsInLandscape: Target number of columns for this grid, in Landscape device orientation; If not provided, `columns` value will be used.
    ///     - vSpacing: Vertical spacing: The distance between each row in grid. If not provided, the default value will be used.
    ///     - hSpacing: Horizontal spacing: The distance between each cell in grid's row. If not provided, the default value will be used.
    ///     - vPadding: Vertical padding: The distance between top/bottom edge of the grid and the parent view. If not provided, the default value will be used.
    ///     - hPadding: Horizontal padding: The distance between leading/trailing edge of the grid and the parent view. If not provided, the default value will be used.
    ///     - content: A closure returning the content of the individual cell
    public init(_ data: Data,
                columns: Int,
                columnsInLandscape: Int? = nil,
                vSpacing: CGFloat = 10,
                hSpacing: CGFloat = 10,
                vPadding: CGFloat = 10,
                hPadding: CGFloat = 10,
                tray: Tray? = nil,
                geometry: GeometryProxy,
                content: @escaping (Data.Element) -> Content) {
      self.data = data.map { $0 }
      self.content = content
      self.columns = max(1, columns)
      self.columnsInLandscape = columnsInLandscape ?? max(1, columns)
      self.vSpacing = vSpacing
      self.hSpacing = hSpacing
      self.vPadding = vPadding
      self.hPadding = hPadding
      self.tray = tray
      self.geometry = geometry
    }

    // MARK: - COMPUTED PROPERTIES

    private var rows: Int {
      data.count / self.cols
    }

    private var cols: Int {
      #if os(tvOS)
      return columnsInLandscape
      #elseif os(macOS)
      return columnsInLandscape
      #else
      return UIDevice.current.orientation.isLandscape ? columnsInLandscape : columns
      #endif
    }
    
    var tray: Tray?
    var minimisedView = true //seeall
    
    public var body : some View {
        
        VStack {
            Text("GridView").foregroundColor(.black).bold()
            Spacer()
           VStack(spacing: self.vSpacing) {
             ForEach((0..<self.rows).map { GridIndex(id: $0) }) { row in
               self.rowAtIndex(row.id * self.cols,
                               geometry: self.geometry)
             }
             // Handle last row
             if (self.data.count % self.cols > 0) {
               self.rowAtIndex(self.cols * self.rows,
                               geometry: geometry,
                               isLastRow: true)
             }
           }
         }
         .padding(.horizontal, self.hPadding)
         .padding(.vertical, self.vPadding)
     }

    private func rowAtIndex(_ index: Int,
                            geometry: GeometryProxy,
                            isLastRow: Bool = false) -> some View {
      HStack(spacing: self.hSpacing) {
        ForEach((0..<(isLastRow ? data.count % cols : cols))
        .map { GridIndex(id: $0) }) { column in
            //remember content is a closure
          self.content(self.data[index + column.id])
          .frame(width: self.contentWidthFor(geometry))
        }
        if isLastRow { Spacer() }
      }
    }
      
    // MARK: - HELPER FUNCTIONS

    private func contentWidthFor(_ geometry: GeometryProxy) -> CGFloat {
      let hSpacings = hSpacing * (CGFloat(self.cols) - 1)
      let width = geometry.size.width - hSpacings - hPadding * 2
      return width / CGFloat(self.cols)
    }
}

@available(iOS 13.0.0, *)
struct MediaCell: View {
  var media: Media
    var body: some View {
    VStack() {
      Text(media.title ?? "").font(.headline).foregroundColor(.black)
      Text(media.desc ?? "trayname").font(.subheadline).foregroundColor(.black)
    }
    
  }
}

//GeometryReader
//struct GridView <Data, Content>: View
//where Data : RandomAccessCollection, Content : View, Data.Element : Identifiable {
//ForEach((0..<self.rows).map { GridIndex(id: $0) }) { row in
