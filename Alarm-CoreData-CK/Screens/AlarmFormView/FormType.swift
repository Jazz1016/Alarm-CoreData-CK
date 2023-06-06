//
//  FormType.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/4/23.
//

import SwiftUI

enum FormType: Identifiable, View {
    
    case new
    case update(alarm: Alarm)
    
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    
    var body: some View {
        switch self {
        case .new:
            AlarmFormView(viewModel: AlarmFormViewModel())
        case .update(alarm: let alarm):
            AlarmFormView(viewModel: AlarmFormViewModel(with: alarm))
        }
    }
}
