//
//  ContentView.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI
import Haptica

struct ContentView: View {
    @EnvironmentObject var manager: APIManager
    
    @State private var mode: GradeMode = .colorEmoji
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(manager.modules, id: \.id, content: { module in
                    ModuleRow(for: module, in: $mode).listRowBackground(Color.clear)
                })
            }
            .navigationTitle("iOSSC")
            .background(
                BackgroundView()
            )
            .navigationBarItems(leading: summaryLabel, trailing: logoutButton)
        }
    }
    
    var logoutButton: some View {
        Button("Logout") {
            Haptic.impact(.medium).generate()
            manager.logout()
        }
        .foregroundColor(.black)
        .padding(.vertical, 4)
        .padding(.horizontal, 14)
        .background(Capsule().foregroundColor(Color.white))
    }
    
    var summaryLabel: some View {
        Text(summaryText)
            .foregroundColor(.gray)
    }
    
    var summaryText: String {
        let grade = String(format: "%.2f", manager.avgGrade ?? "")
        // let gradeText = mode.isEmojiMode ? manager.avgGrade?.emoji : grade
        return "Ø \(grade) - CP \(manager.totalCreditPoints?.description ?? "-")"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
