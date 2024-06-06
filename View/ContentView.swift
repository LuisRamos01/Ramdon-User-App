
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = RamdonUserViewmodel()
    @State private var searchQuery = ""
    var body: some View {
        NavigationView {
            VStack{
                List(viewModel.filteredUsers, id: \.email){ user in
                    NavigationLink {
                        DetailView_(user: user)
                    } label: {
                        HStack{
                            AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:50, height: 50)
                                    .cornerRadius(25)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50,height: 50)
                            }
                            VStack(alignment: .leading) {
                                Text("nombre: \(user.name.first) \(user.name.last)")
                                    .font(.system(size: 20))
                                    .lineLimit(1)
                                Text("email: \(user.email)")
                                    .font(.system(size: 20)).lineLimit(1)
                            }
                            
                        }
                    }
                }.searchable(text: $searchQuery, prompt: "buscar usuarios").onChange(of: searchQuery, perform: {query in viewModel.filteredUsers(query: query)
                })
                .navigationTitle("Lista de Usuarios")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

