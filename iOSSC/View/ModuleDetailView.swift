//
//  ModuleDetailView.swift
//  iOSSC
//
//  Created by André Kuhlmann on 26.10.20.
//

import SwiftUI
import SFSafeSymbols

struct ModuleDetailView: View {
    let module: Module
    
    init(for module: Module) {
        self.module = module
    }
    
    var body: some View {
        Text(module.name)
    }
}
