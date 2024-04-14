//
//  ContentView.swift
//  TempConvert
//
//  Created by Glynis Jones on 4/13/24.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var tempIsFocussed: Bool
    @State private var inputTemp = 0
    @State private var inputUnit: inputUnits = .farenheitStart
//    @State private var outputTemp = 0
//    let tempUnits = ["Farenheit to Celsius", "Celsius to Fahrenheit"]
    
//had to look up this enum bit but it isn't copypasta code
    enum inputUnits: String, CaseIterable {
        case farenheitStart = "Farenheit to Celsius"
        case celsiusStart = "Celsius to Farenheit"
    }
    
    var outputTemp: Int {
        var convertResult = 0
        
        switch inputUnit {
        case .farenheitStart:
            convertResult = (inputTemp - 32) / 2
        case .celsiusStart:
            convertResult = (inputTemp * 2) + 32
        }
        
        return convertResult
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose Conversion Direction") {
                    Picker("F / C", selection: $inputUnit) {
                        ForEach(inputUnits.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Enter Temperature") {
                    TextField("Temp", value: $inputTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempIsFocussed)
                }
                Section("Converted Temperature") {
                    Text("\(outputTemp)")
                }
                
            }
            .navigationTitle("Temperature Converter")
            .toolbar {
                if tempIsFocussed {
                    Button("Done") {
                        tempIsFocussed = false
                    }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
