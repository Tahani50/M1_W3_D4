//
//  GViewModel.swift
//  M1_W3_D4
//
//  Created by Taibah Valley Academy on 3/19/25.
//

import Foundation
import Alamofire

// Extending GetView with a ViewModel class for managing API calls
extension GetView {
    
    // ViewModel class conforming to ObservableObject for management
    class GViewModel: ObservableObject {
        // Published properties to notify UI when data changes
        @Published var titleName: String = ""
        @Published var body: String = ""
        @Published var isLoading: Bool = false // Tracks loading state
        @Published var showErrorAlert: Bool = false // Controls error alert visibility
        @Published var errorMessage: String = "" // Stores error messages
        @Published var posts: [GetResponse] = [] // Stores fetched posts
        
        // Function to fetch data from API
        func fetchData() {
            let urlString = "https://jsonplaceholder.typicode.com/posts"
            
            
            print("\n=============================")
            print("API REQUEST INITIATED")
            print("URL: \(urlString)")
            print("Method: GET")
            print("=============================\n")
            
            isLoading = true // Set loading state to true
            
            // Making a GET request using Alamofire
            AF.request(urlString, method: .get)
                .validate() // Ensures a valid HTTP response
                .responseDecodable(of: [GetResponse].self) { response in
                    DispatchQueue.main.async { // Ensure UI updates on the main thread
                        self.isLoading = false // Reset loading state
                        
                       
                        print("\n=============================")
                        print("API RESPONSE RECEIVED")
                        print("Status Code: \(response.response?.statusCode ?? -1)") // Logs HTTP status code
                        print("=============================")
                        
                        // Handling response result
                        switch response.result {
                        case .success(let data):
                            self.posts = data // Assign fetched data to posts
                            
                            print("\nSUCCESS: Data Fetched")
                            
                        case .failure(let error):
                            // Handle failure case
                            self.errorMessage = "Failed to fetch data. Error: \(error.localizedDescription)"
                            self.showErrorAlert = true
                            
                           
                            print("\nERROR: Failed to fetch data")
                            print("Error Description: \(error.localizedDescription)")
                            
                            // If response contains data, log raw JSON response
                            if let data = response.data, let rawJSON = String(data: data, encoding: .utf8) {
                                print("Raw JSON Response:\n\(rawJSON)")
                            }
                            print("=============================\n")
                        }
                    }
                }
        }
    }
}
