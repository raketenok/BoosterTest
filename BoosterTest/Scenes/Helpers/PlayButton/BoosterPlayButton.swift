//
//  BoosterPlayButton.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import SwiftUI


struct BoosterPlayButton: View {
 
    @ObservedObject var viewModel: BoosterViewModel
    private func playButtonText() -> String {
        return self.viewModel.isPlaying ? "Pause" : "Play"
    }
    
    var body: some View {

        GeometryReader { geometry in
            Button(action: {
                self.viewModel.updateStatus()
            }) {
                GeometryReader { geometry_ in
                    Text(self.playButtonText())
                        .fontWeight(.bold)
                        .frame(width: geometry_.size.width)
                }
            }
            .frame(width: geometry.size.width - UIScheme.Spacings.S * 2, height: UIScheme.Spacings.M).background(Color.init(.systemBlue))
            .accentColor(Color.init(.white))
            .cornerRadius(UIScheme.Spacings.M/6)
            .alert(isPresented: self.$viewModel.isRecordingError) {
                Alert(title: Text("Recording error"), message: Text("Check settings"))
            }
    
        }.frame(height: UIScheme.Spacings.M)
    }
}

struct BoosterPlayButton_Previews: PreviewProvider {
    static var previews: some View {
        BoosterPlayButton(viewModel: BoosterViewModel())
    }
}
