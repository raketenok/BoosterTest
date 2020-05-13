//
//  AlarmButton.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import SwiftUI

struct BoosterAlarmButton: View {
    @State private var isAlarmPresent: Bool = false
    
    func descriptionText() -> String {
        return NSLocalizedString("Alarm", comment: "alarm")
    }
        
    var body: some View {
        Button(action: {
            self.isAlarmPresent.toggle()
            
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
        .actionSheet(isPresented: self.$isAlarmPresent, content: {
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

struct BoosterAlarmButton_Previews: PreviewProvider {
    static var previews: some View {
        BoosterAlarmButton()
    }
}
