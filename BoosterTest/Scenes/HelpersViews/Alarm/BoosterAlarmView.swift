//
//  BoosterAlarmView.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import SwiftUI

struct BoosterAlarmView: View {
    
    @ObservedObject var viewModel: BoosterViewModel
    
    var body: some View {
        HStack {
            Text(UIScheme.ConstantsLabels.alarm)
                .multilineTextAlignment(.leading)
            Spacer()
            BoosterAlarmButton(viewModel: viewModel)
        }
        .padding(UIScheme.Spacings.S).frame(height: UIScheme.Spacings.M)
    }
}

struct BoosterAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterAlarmView(viewModel: BoosterViewModel())
    }
}
