//
//  GetView.swift
//  M1_W3_D4
//
//  Created by Taibah Valley Academy on 3/19/25.
//

import SwiftUI

// View to display and fetch posts from API
struct GetView: View {
    
    // ViewModel instance to manage API calls
    @StateObject private var viewModel = GViewModel()
    
    var body: some View {
        // NavigationStack to allow navigation to other views
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        // Button to fetch data from API
                        Button("Fetch Data") {
                            viewModel.fetchData() // Calls the fetchData function
                        }
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Spacer() // Pushes elements apart
                        
                        // Navigation link to PostView
                        NavigationLink(destination: PostView()) {
                            Text("Post to API")
                                .padding()
                                .background(.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    Spacer() // Pushes content to the top
                    
                    // Conditional view rendering based on loading state
                    if viewModel.isLoading {
                        // Show a loading indicator when data is being fetched
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(2) // Increases the size of the loader
                    } else {
                        // Display a list of fetched posts
                        List {
                            ForEach(viewModel.posts, id: \.id) { item in
                                VStack(alignment: .leading) {
                                    Text(item.title) // Display post title
                                        .font(.headline)
    
                                    Text(item.body) // Display post body
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    
                    Spacer() // Pushes content towards the center
                }
                .padding() 
            }
        }
        // Display alert in case of an API error
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
