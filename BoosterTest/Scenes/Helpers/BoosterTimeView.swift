//
//  BoosterTimerView.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import SwiftUI

enum TimeViewType {
    case timer
    case alarm
}

struct BoosterTimeView: View {

    @State var type: TimeViewType
    
    private func descriptionText() -> String {
        switch type {
        case .timer:
             return NSLocalizedString("Sleep timer", comment: "Sleeper")
        case .alarm:
            return NSLocalizedString("Alarm", comment: "alarm")
        }
    }
    
    var timerDateChanged: (()->())?
    var alarmDateChanged: (()->())?

    var body: some View {
        HStack {
            Text(self.descriptionText())
                .multilineTextAlignment(.leading)
            Spacer()
            if self.type == .alarm {
                BoosterAlarmButton()
            } else {
                BoosterTimerButton()
            }
        }
        .padding(UIScheme.Spacings.S).frame(height: UIScheme.Spacings.M)
    }
        
    
}

struct BoosterTimeView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterTimeView(type: .alarm)
    }
}

