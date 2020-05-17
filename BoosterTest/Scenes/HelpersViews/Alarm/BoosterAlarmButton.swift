//
//  AlarmButton.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import SwiftUI

struct BoosterAlarmButton: View {
  //  @State private var isPresented: Bool = false
    @ObservedObject var viewModel: BoosterViewModel

    var body: some View {
        Button(action: {
            self.viewModel.isDatePickerShowed.toggle()
        }) {
            HStack {
                Spacer()
                Text(self.viewModel.alarmDate?.stringTime() ?? "Off")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
        .frame(width: 200)
        .accentColor(Color.blue)
    }
}

struct BoosterAlarmButton_Previews: PreviewProvider {
    static var previews: some View {
        BoosterAlarmButton(viewModel: BoosterViewModel())
    }
}
