//
//  Timer.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/13/23.
//

import Foundation
import Combine

class FetchTimer: ObservableObject{
    let currentTimePublisher = Timer.TimerPublisher(interval: 60.0, runLoop: .current, mode: .common)
        
    let cancellable: AnyCancellable?

    init() {
        self.cancellable = currentTimePublisher
            .connect() as? AnyCancellable
    }

    deinit {
        self.cancellable?.cancel()
    }
}
