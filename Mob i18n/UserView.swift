//
//  ContentView.swift
//  Mob i18n
//
//  Created by Joseph Quigley on 5/24/21.
//

import SwiftUI

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "M/d/YYYY"
    return formatter
}()

struct UserView: View {
    @State
    var user: User

    @EnvironmentObject
    var backend: Backend

    @Environment(\.presentationMode)
    var presentationMode

    @State
    var showAlert = false

    @State
    var showSaveError = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack {
                Text("Good morning, \(user.firstName) \(user.lastName). The current temperature is \(backend.getTemperature()) degrees, the date is \(dateFormatter.string(from: Date())) and your balance is \(currencyFromDecimal())")

                Button("Why is my balance so low?") {
                    showAlert = true
                }
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Why is my balance so low?"), message: Text(backend.getBalanceDisclaimer()), dismissButton: .default(Text("Got it!")))
            }

            Spacer()

            Text("Need to change your account info? Use this convenient form.").padding(.top)
            form

            Spacer()

            HStack {
                Spacer()
                Button("Save") {
                    if backend.validate(nameFor: user) && backend.validate(zipCode: user.zipCode) {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showSaveError = true
                    }
                }
                Spacer()
            }.alert(isPresented: $showSaveError) {
                Alert(title: Text("Error"), message: validateMessage(), dismissButton: .default(Text("I will fix it!")))
            }

        }.padding(.horizontal)
    }

    var form: some View {
        VStack(alignment: .leading) {
            Text("Name").font(.subheadline)
            HStack {
                TextField("First Name", text: $user.firstName)
                TextField("Middle Name", text: $user.middleName)
                TextField("Last Name", text: $user.lastName)
            }

            Text("Zip Code").font(.subheadline)
            TextField("Zip Code", text: $user.zipCode).keyboardType(.decimalPad)
        }.padding(7).border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).padding()
    }

    func validateMessage() -> Text {
        if !backend.validate(nameFor: user) {
            return Text("Name is not valid")
        } else if !backend.validate(zipCode: user.zipCode) {
            return Text("Zip code is not valid")
        } else {
            return Text("Something bad happened")
        }
    }

    func currencyFromDecimal() -> String {
        let double = NSDecimalNumber(decimal: backend.getBalance()).doubleValue
        return String(format: "$%03.2f", arguments: [double])
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: 0, firstName: "First", middleName: "", lastName: "Last", zipCode: "12345"))
    }
}
