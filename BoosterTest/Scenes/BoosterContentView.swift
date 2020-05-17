//
//  BoosterContentView.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import SwiftUI

struct BoosterContentView: View {
    
    @ObservedObject private var viewModel = BoosterViewModel()
    var body: some View {
        
        ZStack {
            VStack(alignment: .center) {
                
                Text(self.viewModel.statusTitleText(status: self.viewModel.status))
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .padding(.top, UIScheme.Spacings.M)
                
                Spacer()
                Divider()
                    .padding([.leading, .trailing], UIScheme.Spacings.S)
                
                BoosterTimerView(viewModel: viewModel)
                
                Divider()
                    .padding([.leading, .trailing], UIScheme.Spacings.S)
                BoosterAlarmView(viewModel: viewModel)
                
                Divider()
                    .padding([.leading, .trailing], UIScheme.Spacings.S)
                    .padding( .bottom, UIScheme.Spacings.M)
                
                BoosterPlayButton(viewModel: viewModel)
            }
            .padding(.bottom, UIScheme.Spacings.M)
            
            if self.viewModel.isDatePickerShowed {
                BoosterAlarmPicker(viewModel: self.viewModel)
            }
        }
        .alert(isPresented: self.$viewModel.showAlert) {
            
            switch self.viewModel.activeAlert {
                
            case .alarm:
                return Alert(title: Text("Wake up!"), dismissButton: .default(Text("Stop"), action: {
                    self.viewModel.stopAlarmSounds()
                }))
            case .recording:
                return Alert(title: Text("Recording error"), message: Text("Check settings"))
            }
        }
    }
}

#if DEBUG
struct BoosterContentView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterContentView()
    }
}
#endif

