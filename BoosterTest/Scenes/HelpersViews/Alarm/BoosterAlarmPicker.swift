//
//  BoosterAlarmPicker.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 15.05.2020.
//

import SwiftUI

struct BoosterAlarmPicker: View {
    
    @EnvironmentObject private var viewModel: BoosterViewModel
    @State private var time = Date().minAlarmDate()

    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all).opacity(0.1)
            VStack {
                Spacer()
                VStack {
                    BoosterAlarmPickerHeader(time: self.$time)
                    Divider()
                    Spacer()
                    DatePicker(
                        "",
                        selection: self.$time,
                        in: Date().minAlarmDate()..., displayedComponents: .hourAndMinute
                    ).background(Color.white)
                }.frame(height: 280)
                    .background(Color.white)
                   
            }.transition(.move(edge: .bottom))
        }
    }
}

struct BoosterAlarmPicker_Previews: PreviewProvider {
    static var previews: some View {
        BoosterAlarmPicker()
    }
}


