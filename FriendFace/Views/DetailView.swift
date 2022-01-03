//
//  DetailView.swift
//  FriendFace
//
//  Created by Viktor Mauzer on 03.01.2022..
//

import SwiftUI

struct DetailView: View {
    @Environment(\.colorScheme) var colorScheme
    let user: CachedUser
    
    var body: some View {
        VStack {
            Text(user.nameInitials ?? "XX")
                .font(.largeTitle)
                .padding(60)
                .background(colorScheme == .dark ? .black : .white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(user.isActive ? Color.green : Color.gray, lineWidth: 4)
                )
                .padding(20)
            
            List {
                Section {
                    Text("Registered: \(user.wrappedFormattedDate)")
                    Text("Age: \(user.age)")
                    Text("Email: \(user.wrappedEmail)")
                    Text("Address: \(user.wrappedAddress)")
                    Text("Works for: \(user.wrappedCompany)")
                } header: {
                    Text("Basic info")
                }
                
                Section {
                    Text(user.wrappedAbout)
                } header: {
                    Text("About")
                }
                
                Section {
                    ForEach(user.friendsArray) { friend in
                        Text(friend.wrappedName)
                    }
                } header: {
                    Text("Friends")
                }
            }
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
