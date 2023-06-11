//
//  SoundCell.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/5/23.
//

import SwiftUI

struct SoundCell: View {
    
    let soundString: String
    var isSelected = false
    
    var body: some View {
        
        HStack { 
            Spacer()
            Text(soundString)
            Spacer()
            
            Button {
                print("oy shekel")
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.blue)
                    
                    Image(systemName: "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    PlaySound.shared.playSound(key: soundString)
                }
            }
        }
        .padding(8)
        .background(isSelected ? Color.blue.opacity(0.3) : Color.clear)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
    
    
    
}

struct SoundCell_Previews: PreviewProvider {
    static var previews: some View {
        SoundCell(soundString: "chime")
    }
}

