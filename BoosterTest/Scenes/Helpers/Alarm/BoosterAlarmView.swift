//
//  BoosterAlarmView.swift
//  BoosterTest
//
//  Created by Ievgen Iefimenko on 14.05.2020.
//

import SwiftUI

struct BoosterAlarmView: View {
    
    var body: some View {
        HStack {
            Text(UIScheme.ConstantsLabels.alarm)
                .multilineTextAlignment(.leading)
            Spacer()
            BoosterAlarmButton()
        }
        .padding(UIScheme.Spacings.S).frame(height: UIScheme.Spacings.M)
    }
}

struct BoosterAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterAlarmView()
    }
}
