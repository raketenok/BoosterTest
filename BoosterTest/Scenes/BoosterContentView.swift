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
        
        GeometryReader { geometry in
            
            VStack(alignment: .center) {
                
                Text(self.viewModel.statusTitleText(status: self.viewModel.status))
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .padding(.top, UIScheme.Spacings.M)
                
                Spacer()
                Divider()
                    .padding([.leading, .trailing], UIScheme.Spacings.S)
                
                BoosterTimerView(viewModel: self.viewModel)
                
                Divider()
                    .padding([.leading, .trailing], UIScheme.Spacings.S)
                BoosterAlarmView()
                
                Divider()
                    .padding([.leading, .trailing], UIScheme.Spacings.S)
                    .padding( .bottom, UIScheme.Spacings.M)
                
                BoosterPlayButton(viewModel: self.viewModel)
            }
            .padding(.bottom, UIScheme.Spacings.M)
        }
    }
}

struct BoosterContentView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterContentView()
    }
}
