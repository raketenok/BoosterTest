//
//  BoosterTimerButton.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import SwiftUI

struct BoosterTimerButton: View {
    @State private var isTimerPresent: Bool = false

    private func descriptionText() -> String {
        return NSLocalizedString("Sleep timer", comment: "Sleeper")
    }
    
    var body: some View {
        Button(action: {
            self.isTimerPresent.toggle()
            
        }) {
            HStack {
                Spacer()
                Text("self.timeText()")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
        .frame(width: 100)
        .accentColor(Color(.systemBlue))
        .actionSheet(isPresented: self.$isTimerPresent, content: {
            ActionSheet(title: Text(self.descriptionText()), buttons: [
                .default(Text("off")),
                .default(Text("1 min")),
                .default(Text("5 min")),
                .default(Text("10 min")),
                .default(Text("15 min")),
                .default(Text("20 min")),
                .cancel()
            ])
        })
    }
}

struct BoosterTimerButton_Previews: PreviewProvider {
    static var previews: some View {
        BoosterTimerButton()
    }
}
