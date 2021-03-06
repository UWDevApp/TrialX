//
//  StatisticsBubble.swift
//  Cognostic
//
//  Created by Lucas Wang on 2020-09-13.
//  Copyright © 2020-2021 Cognostic. All rights reserved.
//

import SwiftUI

struct StatisticsBubble: View {
    @EnvironmentObject var data: NotificationsAndResults
    let result: Result
    let backGroundColor: Color
    let textColor: Color
    
    var body: some View {
        PlainNavigationLink(destination: DetailGraphView(result: result, color: textColor)) {
            HStack {
                Text(self.result.testName)
                    .foregroundColor(self.textColor)
                    .font(Font.headline.weight(.heavy))
                    .padding(.vertical)
                    .padding(.leading)
                Spacer()
                HStack(spacing: 8) {
                    Text("\(String(format: "%.1f", self.data.getLastestScore(scores: self.result.scores)))")
                        .font(Font.largeTitle.monospacedDigit())
                    Image(systemName: "chevron.right.square.fill")
                        .accessibility(label: Text("Show all scores"))
                }
                .foregroundColor(self.backGroundColor)
                .padding()
                .fixedSize(horizontal: true, vertical: false)
                .frame(maxHeight: .infinity)
                .background(self.textColor)
            }
        }
        .frame(maxWidth: .infinity)
        .background(self.backGroundColor)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

//struct StatisticsBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        StatisticsBubble()
//    }
//}
