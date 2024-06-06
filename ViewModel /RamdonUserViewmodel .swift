import Foundation

class RamdonUserViewmodel: ObservableObject {
    @Published var filteredUsers: [User] = []
    @Published var users: [User] = []
    
    private let url: URL
    
    init(url: URL = URL(string: "https://randomuser.me/api?results=20")!) {
        self.url = url
        Task {
            LoadData()
        }
    }
    func LoadData() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(RamdomUserResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.users = decodedResponse.results
                        self.filteredUsers = self.users
                    }
                    return
                }
            }
            print("error al decodificar datos")
        }.resume()
    }
    
    func filteredUsers(query: String) {
        if query.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { user in
                user.name.first.lowercased().contains(query.lowercased())
            }
        }
    }
}
