//
//  BoosterTimerButton.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import SwiftUI


struct BoosterTimerButton: View {
  
    @ObservedObject var viewModel: BoosterViewModel
    @State private var isTimerPresent: Bool = false
    
    var body: some View {
        Button(action: {
            self.isTimerPresent.toggle()
        }) {
            HStack {
                Spacer()
                Text(self.timerText(timerData: self.viewModel.timerData))
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
        .frame(width: 100)
        .accentColor(Color(.systemBlue))
        .actionSheet(isPresented: self.$isTimerPresent, content: {
            ActionSheet(title: Text(UIScheme.ConstantsLabels.sleepTimer), buttons: self.alertButtons())
        })
    }
    
    private func alertButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = []
        
        TimerData.allCases.forEach { (timer) in
            
            let button = ActionSheet.Button.default(Text(self.timerText(timerData: timer))) {
                self.viewModel.timerHasBeenChanged(data: timer)
            }
            buttons.append(button)
        }
        buttons.append(.cancel())
        return buttons
    }
        
    private func timerText(timerData: TimerData) -> String {
        var text = ""
        switch timerData {
        case .off:
            text = "Off"
        case .oneMinute:
            text = "1 minute"
        default:
            text = "\(timerData.rawValue) minutes"
        }
        return text
    }
}

struct BoosterTimerButton_Previews: PreviewProvider {
    static var previews: some View {
        BoosterTimerButton(viewModel: BoosterViewModel())
    }
}
