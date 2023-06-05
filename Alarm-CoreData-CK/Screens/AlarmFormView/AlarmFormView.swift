//
//  AlarmFormView.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/4/23.
//

import SwiftUI

struct AlarmFormView: View {
    @ObservedObject var viewModel: AlarmFormViewModel
    @State var name: String = ""
    @State var audioName: String = ""
    
    var body: some View {
        Form {
            
        }
    }
}

struct AlarmFormView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmFormView(viewModel: AlarmFormViewModel(with: nil))
    }
}
