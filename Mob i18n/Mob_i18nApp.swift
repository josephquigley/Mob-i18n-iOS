//
//  Mob_i18nApp.swift
//  Mob i18n
//
//  Created by Joseph Quigley on 5/24/21.
//

import SwiftUI
let backend = Backend()

@main
struct Mob_i18nApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    ForEach(backend.getUsers()) { user in
                        NavigationLink("\(user.firstName) \(user.lastName)", destination: UserView(user: user))
                    }
                }.navigationTitle(Text("Fancy App"))
            }.environmentObject(backend)
        }
    }
}
