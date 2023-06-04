//
//  FormType.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/4/23.
//

import SwiftUI

enum FormType: Identifiable, View {
    
    case new
    case update
    
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    
    var body: some View {
        VStack {
            
        }
    }
}
