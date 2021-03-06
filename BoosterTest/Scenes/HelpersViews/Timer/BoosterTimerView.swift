//
//  BoosterTimerView.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import SwiftUI


struct BoosterTimerView: View {
    
    @EnvironmentObject private var viewModel: BoosterViewModel

    var body: some View {
        HStack {
            Text(UIScheme.ConstantsLabels.sleepTimer)
                .multilineTextAlignment(.leading)
            Spacer()
            BoosterTimerButton()
        }
        .padding(UIScheme.Spacings.S).frame(height: UIScheme.Spacings.M)
    }
    
}

struct BoosterTimerView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterTimerView()
    }
}

