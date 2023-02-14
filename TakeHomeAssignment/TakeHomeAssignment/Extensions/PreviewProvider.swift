//
//  PreviewProvider.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/14/23.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let coin = Coin(usd: 20.01, coinName: "sample coin")
}
