//
//  ScreenOne.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/10/23.
//

import SwiftUI
import RealmSwift

struct ScreenOne: View {
    
    //@ObservedResults(RealmCoinGroup.self) var realmCoinGroups : Results<RealmCoinGroup>
    
    @StateObject var vm = ScreenTwoViewModel()
    
    var body: some View {
        NavigationStack{
            Text("Welcome")
            NavigationLink("Screen Two", destination: ScreenTwo(vm: vm))
        }
        .navigationTitle("Screen One")
    }
}

struct ScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ScreenOne()
        }
    }
}
