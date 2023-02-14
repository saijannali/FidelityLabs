//
//  TakeHomeAssignmentApp.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/10/23.
//

import SwiftUI

@main
struct TakeHomeAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            NavigationStack {
                Welcome()  
            }
        }
    }
}
