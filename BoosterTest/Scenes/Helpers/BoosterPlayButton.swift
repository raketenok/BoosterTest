//
//  BoosterPlayButton.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import SwiftUI


struct BoosterPlayButton: View {
    @State private var isPlaying: Bool = false

    private func playButtonText() -> String {
        return self.isPlaying ? "Pause" : "Play"
    }
        
    private var playAction: ((Bool) -> Void)?

    func playAction(perform action: @escaping (_ isPlaying: Bool) -> Void ) -> Self {
        var copy = self
        copy.playAction = action
        return copy
    }
    
    var body: some View {

        GeometryReader { geometry in
            
            Button(action: {
                self.isPlaying.toggle()
                self.playAction?(self.isPlaying)
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
        }.frame(height: UIScheme.Spacings.M)
    }
}

struct BoosterPlayButton_Previews: PreviewProvider {
    static var previews: some View {
        BoosterPlayButton()
    }
}
