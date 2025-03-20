//
//  PostView.swift
//  M1_W3_D4
//
//  Created by Taibah Valley Academy on 3/19/25.
//

import SwiftUI

// View to allow users to create a new post
struct PostView: View {
    
    // ViewModel instance to manage API calls
    @StateObject private var viewModel = PViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Form for user input fields
                VStack {
                    Form {
                        // TextField for entering post title
                        TextField("Enter Post Title", text: $viewModel.titleName)
                            .padding()
                        
                        // TextField for entering post body
                        TextField("Enter Post Body", text: $viewModel.body)
                            .padding()
                        
                        // Button to trigger the API request to create a post
                        Button("Create Post") {
                            viewModel.createPost() // Calls the API function
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity) // Expands button width
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .frame(height: 300) // Limit the form height
                
                // Show a loading indicator when request is in progress
                if viewModel.isLoading {
                    ProgressView("Sending Post...") // Loading message
                }
                
                // Display response details when post is successfully created
                if let post = viewModel.postResponse {
                    VStack {
                        Text("Post Created!") // Success message
                            .font(.headline)
                            .foregroundColor(.green) // Green color for success indication
                        Text("Title: \(post.title)")
                        Text("Body: \(post.body)")
                    }
                    .padding()
                }
            }
            .navigationTitle("Post API")
            .padding()
            
            // Display alert in case of an error
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
