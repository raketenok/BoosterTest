//
//  BoosterTimerView.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 13.05.2020.
//

import SwiftUI


struct BoosterTimerView: View {
    
    @ObservedObject var viewModel: BoosterViewModel

    var body: some View {
        HStack {
            Text(UIScheme.ConstantsLabels.sleepTimer)
                .multilineTextAlignment(.leading)
            Spacer()
            BoosterTimerButton(viewModel: viewModel)
        }
        .padding(UIScheme.Spacings.S).frame(height: UIScheme.Spacings.M)
    }
    
}

struct BoosterTimerView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterTimerView(viewModel: BoosterViewModel())
    }
}

