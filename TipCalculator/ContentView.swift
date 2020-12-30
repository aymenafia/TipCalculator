//
//  ContentView.swift
//  TipCalculator
//
//  Created by Mohamed aymen AFIA on 30/12/2020.
//
import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage: Double = 40
            
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    
                    VStack{
                        
                        Form {
                            Section {
                              TextField("Amount", text: $checkAmount)
                                .keyboardType(.decimalPad)

                              Picker("Number of people", selection: $numberOfPeople) {
                                ForEach(2 ..< 100) {
                                  Text("\($0) people")
                                }
                              }
                            }
                            
                            Section(header: Text("How much tip do you want to leave?")) {
                                Slider(value: $tipPercentage, in: 0...100, step: 0.1)

                                Text("\(tipPercentage, specifier: "%.0f") %")

                            }
                            
                            Section(header: Text("Price")) {
                                tipPercentage == 100 ?
                                    Text("\(totalPerPerson, specifier: "%.2f")")
                                    .foregroundColor(.red)
                                    : Text("\(totalPerPerson, specifier: "%.2f")")
                            }
                        }
                        .foregroundColor(Color.white)
                        .modifier(DismissingKeyboard())
                    }
                }
                
            }
            .navigationBarTitle("Tip Calculator")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}
