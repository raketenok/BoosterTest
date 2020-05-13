//
//  BoosterContentView.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import SwiftUI

struct BoosterContentView: View {
    
    @State private var viewModel = BoosterViewModel()
    @State private var isPlaying = false

    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(alignment: .center) {
                
                Text(self.viewModel.playTitleText(isPlaying: self.isPlaying))
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .padding(.top, UIScheme.Spacings.M)
                
                Spacer()
                Divider()
                    .padding([.leading, .trailing], UIScheme.Spacings.S)
                
                BoosterTimeView(type: .timer)
                
                Divider()
                    .padding([.leading, .trailing], UIScheme.Spacings.S)
                BoosterTimeView(type: .alarm)
                
                Divider()
                    .padding([.leading, .trailing], UIScheme.Spacings.S)
                    .padding( .bottom, UIScheme.Spacings.M)
                
                BoosterPlayButton().playAction { (isPlaying) in
                    self.isPlaying = isPlaying
                    self.viewModel.playAction(isPlaying: isPlaying)
                }
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
