import XCTest
@testable import RamdonUserApp

final class ContentViewTests: XCTestCase {

    func loadMockUsers() -> [User] {
        let mockData = """
        [
            {
                "name": {
                    "first": "Luis",
                    "last": "Ramos"
                },
                "email": "luis@example.com",
                "picture": {
                    "thumbnail": "https://randomuser.me/api/portraits/thumb/men/54.jpg",
                    "large": "https://randomuser.me/api/portraits/men/54.jpg"
                },
                "login": {
                    "password": "password123"
                }
            },
            {
                "name": {
                    "first": "John",
                    "last": "Doe"
                },
                "email": "john@example.com",
                "picture": {
                    "thumbnail": "https://randomuser.me/api/portraits/thumb/men/55.jpg",
                    "large": "https://randomuser.me/api/portraits/men/55.jpg"
                },
                "login": {
                    "password": "password456"
                }
            }
        ]
        """.data(using: .utf8)!
        
        let users = try! JSONDecoder().decode([User].self, from: mockData)
        return users
    }

    func testInitialUserList() {
        let viewModel = RamdonUserViewmodel()
        viewModel.users = loadMockUsers()
        viewModel.filteredUsers = viewModel.users
        
        XCTAssertEqual(viewModel.filteredUsers.count, 2, "Initial user list should contain 2 users")
    }
    
    func testFilteredUserList() {
        let viewModel = RamdonUserViewmodel()
        viewModel.users = loadMockUsers()
        viewModel.filteredUsers(query: "Luis")
        
        XCTAssertEqual(viewModel.filteredUsers.count, 1, "Filtered user list should contain 1 user")
        XCTAssertEqual(viewModel.filteredUsers.first?.name.first, "Luis", "The first name of the filtered user should be Luis")
    }
}

