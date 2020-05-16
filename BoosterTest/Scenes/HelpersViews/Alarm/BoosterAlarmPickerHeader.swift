//
//  BoosterAlarmPickerHeader.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 16.05.2020.
//

import SwiftUI

struct BoosterAlarmPickerHeader: View {
    
    @ObservedObject var viewModel: BoosterViewModel
    @Binding var time: Date
    
    var body: some View {
        HStack {
            Button(action: {
                self.viewModel.isDatePickerShowed.toggle()

            }) {
                Text("Cancel")
            }.padding()
            Spacer()
            Text("Alarm").padding()
            Spacer()
            Button(action: {
                self.viewModel.isDatePickerShowed.toggle()
                let dateNow = Date().minAlarmDate()
                self.viewModel.updateAlarm(date: dateNow.isDescendingThan(self.time) ? dateNow : self.time)
            }) {
                Text("Done")
            }.padding()
            
        }
        .background(Color.white)
    }
}

struct BoosterAlarmPickerHeader_Previews: PreviewProvider {
    static var previews: some View {
        BoosterAlarmPickerHeader(viewModel: BoosterViewModel(), time: .constant(Date()))
    }
}
