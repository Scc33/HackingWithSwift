//
//  ContentView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 8/1/21.
//

// The rule of 72
// https://en.wikipedia.org/wiki/Rule_of_72#E-M_rule
// maybe include a link to this and the formulas under the settings

import SwiftUI
import Foundation

// this struct is currently unused
struct MenuView: View {
    @State private var isShareSheetShowing = false
    
    func shareButton() {
        isShareSheetShowing.toggle()
        let url = URL(string: "https://apple.com")
        let activityView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: shareButton) {
                Image(systemName: "square.and.arrow.up")
                    .font(.largeTitle)
            }
            Image(systemName:  "gearshape")
                .font(.largeTitle)
        }
    }
}

struct DoubleView: View {
    @State private var estBase: topLine = .seventy
    @State private var estInterest = ""
    
    var excDouble: Double {
        let convertedEstInterest = Double(estInterest) ?? 0.1
        let num = log(2.0)
        let dem = log(1.0 + (convertedEstInterest / 100.0))
        return num / dem
    }
    
    var estDouble: Double {
        let convertedEstBase = Double(estBase.id) ?? 0.1
        let convertedEstInterest = Double(estInterest) ?? 0.1
        return convertedEstBase / convertedEstInterest
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Base", selection: $estBase) {
                    ForEach(topLine.allCases, id: \.id) { value in
                        Text(value.localizedName)
                            .tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Interest Rate", text: $estInterest)
                    .keyboardType(.decimalPad)
            }
            Section {
                Text("Estimated doubling time \(estDouble)")
                Text("Exact doubling time \(excDouble)")
            }
        }
    }
}

struct CompoundSolverView: View {
    @State private var initial = ""
    @State private var start = ""
    @State private var time = ""
    
    var body: some View {
        Form {
            Section {
                HStack {
                    VStack {
                        Text("Contribution amount")
                        Text("Compounded") //(annually, quarterly, monthly, daily)
                        Text("Number ") //of contributions per year
                    }
                    VStack {
                        TextField("Years", text: $time)
                            .keyboardType(.decimalPad)
                        TextField("Starting amount", text: $start)
                            .keyboardType(.decimalPad)
                        Text("test")
                    }
                }
            }
            Section {
                Text("Final Value")
            }
            Section {
                Text("Graph type (bar for contrib/profits or just total)")
                Text("A slider for type")
                Text("Graph")
            }
            Section {
                Text("Yearly Values")
            }
            Section {
                //https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
                NavigationLink(destination: Text("Second View")) {
                    Text("History")
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                CompoundSolverView()
                .navigationTitle(Text("Compound Solver"))
            }
            .tabItem {
                Text("Compound")
                Image(systemName:"waveform.path.ecg.rectangle")
            }.tag(0)
            NavigationView {
                DoubleView()
                .navigationTitle(Text("Doubling"))
            }
            .tabItem {
                Text("Doubling Calculator")
                Image(systemName:"waveform.path.ecg.rectangle")
            }.tag(1)
        }
    }
}

enum topLine: String, Equatable, CaseIterable, Identifiable {
    case exact = "69.3"
    case seventy = "70"
    case seventyTwo = "72"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
