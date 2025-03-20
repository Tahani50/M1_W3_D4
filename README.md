# SwiftUI API Integration Project

## Overview
This project is a simple SwiftUI application that demonstrates how to interact with an API using Alamofire. It consists of two main views:
- **GetView**: Fetches and displays a list of posts from an API.
- **PostView**: Allows users to create a new post and send it to the API.

## Features
- Fetch data from an API using **GET** requests.
- Display retrieved posts in a **list view**.
- Create a new post using **POST** requests.
- Show **loading indicators** while fetching or posting data.
- Handle **error messages** and display alerts.
- Use **SwiftUI NavigationStack** for seamless navigation.

## Technologies Used
- **SwiftUI**: For building the user interface.
- **Alamofire**: For making network requests.
- **ObservableObject & StateObject**: For managing application state.

## Installation
1. Clone this repository:
   ```sh
   git clone https://github.com/yourusername/swiftui-api-integration.git
   ```
2. Open the project in **Xcode**.
3. Install dependencies using **Swift Package Manager**:
   - Go to `File > Add Packages`
   - Search for **Alamofire** and add it to the project.
4. Run the project on an iOS simulator or a physical device.

## How It Works
### Fetching Posts
1. Open `GetView.swift`.
2. Tap the **Fetch Data** button.
3. The app will fetch posts from `https://jsonplaceholder.typicode.com/posts` and display them in a list.

### Creating a Post
1. Navigate to the `PostView`.
2. Enter a **Title** and **Body** in the text fields.
3. Tap the **Create Post** button.
4. The app will send the post to the API and display the response.

## API Endpoints Used
- **GET** `https://jsonplaceholder.typicode.com/posts` – Fetches a list of posts.
- **POST** `https://jsonplaceholder.typicode.com/posts` – Creates a new post.
