//
//  BoosterPlayButton.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import SwiftUI


struct BoosterPlayButton: View {
    
    @EnvironmentObject private var viewModel: BoosterViewModel
    private func playButtonText() -> String {
        return self.viewModel.isPlaying ? "Pause" : "Play"
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            Button(action: {
                self.viewModel.updatePlayingStatus()
            }) {
                GeometryReader { geometry_ in
                    Text(self.playButtonText())
                        .fontWeight(.bold)
                        .frame(width: geometry_.size.width)
                }
            }
            .disabled(self.viewModel.alarmDate == nil)
            .frame(width: geometry.size.width - UIScheme.Spacings.S * 2, height: UIScheme.Spacings.M).background(Color.init(.systemBlue))
            .accentColor(Color.init(.white))
            .cornerRadius(UIScheme.Spacings.M/6)
        }.frame(height: UIScheme.Spacings.M)
    }
}

struct BoosterPlayButton_Previews: PreviewProvider {
    static var previews: some View {
        BoosterPlayButton()
    }
}
