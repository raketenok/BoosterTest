//
//  BoosterAlarmPicker.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 15.05.2020.
//

import SwiftUI

struct BoosterAlarmPicker: View {
    
    @ObservedObject var viewModel: BoosterViewModel
    @State private var time = Date().minAlarmDate()

    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all).opacity(0.1)
            VStack {
                Spacer()
                VStack {
                    BoosterAlarmPickerHeader(viewModel: self.viewModel, time: self.$time)
                    Divider()
                    Spacer()
                    DatePicker(
                        "",
                        selection: self.$time,
                        in: Date().minAlarmDate()..., displayedComponents: .hourAndMinute
                    )
                }.frame(height: 280)
                    .background(Color.white)
                   
            }.transition(.move(edge: .bottom))
        }
    }
}

struct BoosterAlarmPicker_Previews: PreviewProvider {
    static var previews: some View {
        BoosterAlarmPicker(viewModel: BoosterViewModel())
    }
}


