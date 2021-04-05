//
//  PhoneView.swift
//  TrialX
//
//  Created by Apollo Zhu on 9/12/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

struct PhoneView: View {
    var phone: String

    var body: some View {
        HStack {
            Text("App Support")
            Spacer()
            Text(phone)
                .foregroundColor(.accentColor)
        }
        .padding(.vertical)
        .onTapGesture {
            guard let url = URL(string: "tel://\(self.phone)") else { return }
            UIApplication.shared.open(url)

        }
    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneView(phone: "123456789")
    }
}