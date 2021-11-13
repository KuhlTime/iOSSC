//
//  ContentView.swift
//  iOSSC
//
//  Created by André Kuhlmann on 16.10.20.
//

import SwiftUI
import Haptica
import SwiftUIRefresh

struct ContentView: View {
    @EnvironmentObject var manager: APIManager
    @State private var mode: GradeMode = .colorEmoji
    @State private var pullToRefreshShowing = false
    @State private var selection: Module? = nil
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name: "HSD Sans", size: 32)!,
            .foregroundColor: UIColor(.hsd)
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "HSD Sans", size: 18)!,
            .foregroundColor: UIColor(.hsd)
        ]
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(manager.modules, id: \.id, content: { module in
                    HStack {
                        NavigationLink(
                            destination: ModuleDetailView(for: module, in: $mode),
                            tag: module,
                            selection: $selection
                        ) { EmptyView() }
                        .frame(width: 0)
                        .opacity(0)
                        
                        ModuleRow(for: module, in: $mode)
                            .onTapGesture {
                                selection = module
                            }
                    }
                    .listRowBackground(Color.clear)
                })
            }
            .background(
                BackgroundView()
            )
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    summaryLabel
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    logoutButton
                }
            })
            .pullToRefresh(isShowing: $pullToRefreshShowing) {
                manager.refresh {
                    pullToRefreshShowing = false
                }
            }
            .navigationTitle("iOSSC")
        }
        .accentColor(Color.white)
    }
    
    var logoutButton: some View {
        Button("Logout") {
            Haptic.impact(.medium).generate()
            manager.logout()
        }
        .foregroundColor(.white)
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
