//
//  PlainList.swift
//  Cognostic
//
//  Created by Apollo Zhu on 9/12/20.
//  Copyright © 2020-2021 Cognostic. All rights reserved.
//

import SwiftUI

struct PlainList<Content: View>: View {
    var iOS13: some View {
        List(content: { return content })
            .onAppear{
                UITableView.appearance().separatorStyle = .none
            }
            .onDisappear{
                UITableView.appearance().separatorStyle = .singleLine
            }
    }

    var body: some View {
        #if canImport(UniformTypeIdentifiers)
        Group {
            if #available(iOS 14, *) {
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading,
                               content: { return content })
                        .padding()
                }
            } else {
                iOS13
            }
        }
        #else
        return iOS13
        #endif
    }

    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

extension PlainList {
    init<Data, ID, RowContent>(_ data: Data,
                               id: KeyPath<Data.Element, ID>,
                               @ViewBuilder content: @escaping (Data.Element) -> RowContent)
    where Data: RandomAccessCollection, ID: Hashable, RowContent: View,
          Content == ForEach<Data, ID, RowContent> {
        self.init {
            ForEach(data, id: id, content: content)
        }
    }

    init<Data, RowContent>(_ data: Data,
                           @ViewBuilder content: @escaping (Data.Element) -> RowContent)
    where Data: RandomAccessCollection, Data.Element : Identifiable,
          Content == ForEach<Data, Data.Element.ID, RowContent> {
        self.init(data, id: \.id, content: content)
    }
}

extension PlainList {
    init<RowContent>(_ data: Range<Int>,
                     @ViewBuilder content: @escaping (Int) -> RowContent)
    where Content == ForEach<Range<Int>, Int, RowContent> {
        self.init(data, id: \.self, content: content)
    }
}

struct PlainList_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PlainList(1..<3) {
                Text("\($0)")
            }
            ForEach(1..<3) {
                Text("\($0)")
            }
        }
    }
}
