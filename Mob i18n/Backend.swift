//
//  Backend.swift
//  Mob i18n
//
//  Created by Joseph Quigley on 5/24/21.
//

import Foundation

struct User: Identifiable {
    let id: Int
    var firstName: String
    var middleName: String
    var lastName: String
    var zipCode: String
}

class Backend: ObservableObject {
    enum BackendError: Error {
        case userNotFound
    }

    private var users = [
        User(id: 0, firstName: "Johnny", middleName: "Frank", lastName: "Appleseed", zipCode: "05544"),
        User(id: 1, firstName: "Riazuddin", middleName: "", lastName: "", zipCode: "23200"),
        User(id: 2, firstName: "", middleName: "", lastName: "Akihito", zipCode: "112-3319"),
        User(id: 3, firstName: "George", middleName: "", lastName: "Fullbright", zipCode: "B44"),
        User(id: 4, firstName: "Ahmad", middleName: "bin Husain", lastName: "Muhammad ibn Sa’ud AL-TIKRITI", zipCode: ""),
        User(id: 5, firstName: "هاشم", middleName: "", lastName: "أشهأد‎", zipCode: "55477"), //Hashim Ashhad
        User(id: 6, firstName: "Hans", middleName: "", lastName: "Göttl", zipCode: "22166")
    ]

    func getBalance() -> Decimal {
        Decimal(Double.random(in: 12...12000))
    }

    func getBalanceDisclaimer() -> String {
        "For every $5.00 of balance, we charge 23.5% interest."
    }

    func getUsers() -> [User] {
        users
    }

    func getUser(withID id: Int) -> User? {
        guard id <= users.count - 1 else {
            return nil
        }
        return users[id]
    }

    func getTemperature() -> Int {
        return Int.random(in: 0...90)
    }

    func validate(nameFor user: User) -> Bool {
        let isNotEmpty = !user.firstName.isEmpty && !user.lastName.isEmpty
        let noSpaces = !user.firstName.contains(" ") && !user.lastName.contains(" ")

        return isNotEmpty && noSpaces
    }

    func validate(zipCode: String) -> Bool {
        let range = NSRange(location: 0, length: zipCode.utf16.count)
        let regex = try! NSRegularExpression(pattern: "\\d{5}")
        let valid = regex.firstMatch(in: zipCode, options: [], range: range) != nil
        return valid
    }
}
