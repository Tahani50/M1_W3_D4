//
//  PViewModel.swift
//  M1_W3_D4
//
//  Created by Taibah Valley Academy on 3/19/25.
//

import Foundation
import Alamofire

// Extending PostView with a ViewModel class to handle API requests for creating a post
extension PostView {
    
    // ViewModel class that conforms to ObservableObject for management
    class PViewModel: ObservableObject {
        // Published properties to track user input and API responses
        @Published var titleName: String = "" // Stores the title input from the user
        @Published var body: String = "" // Stores the body content input from the user
        @Published var postResponse: PostResponse? // Stores the response from the API after posting
        @Published var isLoading: Bool = false // Indicates whether the request is in progress
        @Published var showErrorAlert: Bool = false // Controls the visibility of an error alert
        @Published var errorMessage: String = "" // Stores error messages for display

       
        private let urlString = "https://jsonplaceholder.typicode.com/posts"
        
        // Function to create a new post
        func createPost() {
            isLoading = true // Set loading state to true to show activity indicator
            
            // Parameters to be sent in the POST request body
            let parameters: [String: Any] = [
                "title": titleName,
                "body": body
            ]
            
            
            print("\n=============================")
            print("API REQUEST INITIATED")
            print("URL: \(urlString)")
            print("Method: POST")
            print("Parameters: \(parameters)")
            print("=============================\n")
            
            // Making a POST request using Alamofire
            AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate() // Ensures a valid HTTP response
                .responseDecodable(of: PostResponse.self) { response in
                    DispatchQueue.main.async { // Ensure UI updates on the main thread
                        self.isLoading = false // Reset loading state after response
                        
                        
                        print("\n=============================")
                        print("API RESPONSE RECEIVED")
                        print("Status Code: \(response.response?.statusCode ?? -1)")
                        print("=============================")
                        
                        // Handling response result
                        switch response.result {
                        case .success(let data):
                            self.postResponse = data // Store the successful API response
                            
                            print("\nSUCCESS: Post Created")
                            print("=============================\n")
                            
                        case .failure(let error):
                            // Handle failure case
                            self.errorMessage = "Failed to send data: \(error.localizedDescription)"
                            self.showErrorAlert = true
                            
                            
                            print("\nERROR: Failed to send data")
                            print("Error Description: \(error.localizedDescription)")
                            
                            // If response contains data, log raw JSON response
                            if let data = response.data, let rawJSON = String(data: data, encoding: .utf8) {
                                print("Raw JSON Response:\n\(rawJSON)")
                            }
                        }
                    }
                }
        }
    }
}
