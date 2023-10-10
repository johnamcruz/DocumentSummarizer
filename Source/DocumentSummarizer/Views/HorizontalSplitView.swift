//
//  HorizontalSplitView.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/10/23.
//

import SwiftUI

struct HorizontalSplitView<Content:View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
   #if os(macOS)
           // todo: replace with Splitview after fixing searchable bug with splitview
           HSplitView {
               content()
           }
   #else
           HStack {
               content()
           }
   #endif
       }
}

#Preview {
    HorizontalSplitView {
        Text("Left")
        Text("Right")
    }
}
