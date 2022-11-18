//
//  ContentView.swift
//  Challenge1-UnitConverter
//
//  Created by Phaninder on 18/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputLength = 1.0
    @State private var selectedInputUnit = "km"
    @FocusState private var textFieldFocused: Bool
    @State private var selectedOutputUnit = "m"
    
    private var outputLength: Double {
        return convertMetersLengthToOutputUnit()
    }
    
    private var units = ["m", "km", "ft", "yd", "mi"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input length", value: $inputLength, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($textFieldFocused)
                    Picker("Units", selection: $selectedInputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input Length")
                }
                
                Section {
                    Picker("Output Units", selection: $selectedOutputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(outputLength, format: .number)
                } header: {
                    Text("Converted Length")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        textFieldFocused = false
                    }
                }
            }
        }
    }
    
    func convertInputLengthToMeters() -> Double {
        switch selectedInputUnit {
        case "m":
            return inputLength
        case "km":
            return inputLength * 1000
        case "ft":
            return inputLength / 3.2808
        case "yd":
            return inputLength / 1.0936
        case "mi":
            return inputLength / 0.00062137
        default:
            return 0
        }
    }
    
    func convertMetersLengthToOutputUnit() -> Double {
        let inputInMeters = convertInputLengthToMeters()
        switch selectedOutputUnit {
        case "m":
            return inputInMeters
        case "km":
            return inputInMeters / 1000
        case "ft":
            return inputInMeters * 3.2808
        case "yd":
            return inputInMeters * 1.0936
        case "mi":
            return inputInMeters * 0.00062137
        default:
            return 0
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
