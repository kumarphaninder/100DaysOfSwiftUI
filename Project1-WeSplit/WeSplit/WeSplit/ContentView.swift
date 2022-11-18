//
//  ContentView.swift
//  WeSplit
//
//  Created by Phaninder Kumar on 11/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmount / peopleCount
        return amountPerPerson
    }
    
    var currencyCode: String {
        if #available(iOS 16, *) {
            return Locale.current.currency?.identifier ?? "USD"
        } else {
            return Locale.current.currencyCode ?? "USD"
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    if #available(iOS 16.0, *) {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0..<101) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    } else {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: currencyCode))
                } header: {
                    Text("Total amount")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                } header: {
                    Text("Amount per person")
                }
                
            }
            .navigationTitle("We Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
