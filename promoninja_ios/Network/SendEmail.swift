import SwiftUI

struct ContactMessage: Codable {
    var message: String
}


enum ReportType: String {
    case invalidURL
    case expiredPromotion
}


func sendEmail(reportType: ReportType, podcastTitle: String, sponsorTitle: String ) {
    
    
    
    // Endpoint URL
    guard let url = URL(string: "https://feedbackserver-uj36.onrender.com/send-email") else {
        print("Invalid URL")
        return
    }
    
    let message = "\(reportType.rawValue) for \(podcastTitle) x \(sponsorTitle)"
    
    // Create the request data
    let contactMessage = ContactMessage(message: message)
    
    // Serialize your request data to JSON
    guard let jsonData = try? JSONEncoder().encode(contactMessage) else {
        print("Error: Trying to convert model to JSON data")
        return
    }

    // Create a URLRequest and set its properties
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = jsonData
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    // Perform the request
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            // Handle error
            print("Error sending request: \(error)")
            return
        }
        // Handle response
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            print("Email sent successfully")
        } else {
            print("Email not sent")
        }
    }.resume()
}
