//
//  ContentView.swift
//  SmartEdit
//
//  Created by João Gabriel Pozzobon dos Santos on 17/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var messages = [
        Message(text: "lol you arrived late", sent: false),
        Message(text: "hiii", sent: true)
    ]
    
    @State var text: String = ""
    @State var correction: CorrectionProposal? = nil
    
    var body: some View {
        VStack {
            Spacer()
            ForEach(messages) { message in
                MessageView(message: message)
            }
            
            TextField("Message", text: $text)
//                .background {
//                    HStack {
//                        if !text.isEmpty {
//                            Text(text)
//                                .matchedGeometryEffect(id: text, in: animation)
//                        }
//                        Spacer()
//                    }
//                }
                .padding(12)
                .background(Capsule().stroke(Color(.systemGray6), lineWidth: 2))
                .padding(.vertical)
                .onSubmit {
                    withAnimation(.spring()) {
                        messages.append(Message(text: text, sent: true))
                    }
                    text = ""
                }
        }
        .padding(38)
        .onChange(of: text) { text in
            guard !text.isEmpty else {
                return
            }
            if text[0] == "*" || text[text.count-1] == "*" {
                let correctionWord = text
                
                let words = messages.last(where: { $0.sent })?.text.split(separator: " ")
                let similarity: CGFloat = 0
                
                if let words {
                    
                }
            }
        }
    }
}

extension String {
    subscript(i: Int) -> String {
        return  i < count ? String(self[index(startIndex, offsetBy: i)]) : ""
    }
}

struct CorrectionProposal {
    var corrected: String
    var text: String
}

struct MessageView: View {
    var message: Message
    
    var body: some View {
        HStack {
            if message.sent {
                Spacer()
            }
            
            HStack {
                Text(message.text)
                    .multilineTextAlignment(message.sent ? .leading : .trailing)
                    .padding(12)
                    .padding(.horizontal, 6)
                    .foregroundStyle(message.sent ? .white : .black)
            }
            .background(Capsule().fill(message.sent ? .blue : Color(.systemGray6)))
            
            if !message.sent {
                Spacer()
            }
        }.transition(.offset(y: 16).combined(with: .opacity))
    }
}

struct Message: Identifiable, Equatable {
    let id = UUID()
    var text: String
    var sent: Bool
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
