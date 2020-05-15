//
//  AlarmButton.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import SwiftUI

struct BoosterAlarmButton: View {
    @State private var isAlarmPresent: Bool = false
        
    var body: some View {
        Button(action: {
            self.isAlarmPresent.toggle()
            
        }) {
            HStack {
                Spacer()
                //TODO: SET PICKER DATA
                Text("self.timeText()")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
        .frame(width: 100)
        .accentColor(Color(.systemBlue))
        .actionSheet(isPresented: self.$isAlarmPresent, content: {
            ActionSheet(title: Text(UIScheme.ConstantsLabels.alarm), buttons: [
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
