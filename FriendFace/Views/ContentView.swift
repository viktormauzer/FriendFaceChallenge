//
//  ContentView.swift
//  FriendFace
//
//  Created by Viktor Mauzer on 03.01.2022..
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    let networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(cachedUsers) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    HStack {
                        Text(user.nameInitials ?? "XX")
                            .padding()
                            .background(colorScheme == .dark ? .black : .white)
                            .clipShape(Circle())
                            .frame(width: 70)
                            .overlay(
                                Circle()
                                    .stroke(user.isActive ? Color.green : Color.gray, lineWidth: 2)
                            )
                            .padding([.top, .bottom, .trailing], 5)
                        VStack(alignment: .leading) {
                            Text(user.wrappedName)
                                .font(.headline)
                            Text(user.isActive ? "Active" : "Offline")
                                .font(.subheadline)
                                .foregroundColor(user.isActive ? .green : .secondary)
                        }
                        
                    }
                    
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if cachedUsers.isEmpty {
                    if let retrievedUsers = await networkManager.getUsers() {
                        users = retrievedUsers
                    }
                    
                    await MainActor.run {
                        for user in users {
                            let newUser = CachedUser(context: moc)
                            newUser.name = user.name
                            newUser.id = user.id
                            newUser.isActive = user.isActive
                            newUser.age = Int16(user.age)
                            newUser.about = user.about
                            newUser.email = user.email
                            newUser.address = user.address
                            newUser.company = user.company
                            newUser.formattedDate = user.formattedDate
                            
                            for friend in user.friends {
                                let newFriend = CachedFriend(context: moc)
                                newFriend.id = friend.id
                                newFriend.name = friend.name
                                newFriend.user = newUser
                            }
                            
                            try? moc.save()
                        }
                    }
                }
            }
        }
    }
}
