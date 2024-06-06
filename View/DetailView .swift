
import SwiftUI

struct DetailView_: View {
    
    @State var user: User
    @State private var newPassWord: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack{
            Text("Profile Information")
                .font(.system(size: 40))
                .lineLimit(10)
                .padding(.top)
                .font(.headline)
            Spacer()
            AsyncImage(url: URL(string: user.picture.large)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 270, height: 270)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
                    .frame(width: 50,height: 50)
            }
            
            Spacer()
            VStack{
                
                Text("nombre: \(user.name.first)")
                    .font(.system(size: 28))
                    .lineLimit(10)
                
                Text("apellido: \(user.name.last)")
                    .font(.system(size: 28))
                    .lineLimit(10)
                
                Text("Email: \(user.email)")
                    .font(.system(size: 28))
                    .lineLimit(1)
                
                Text("Contraseña: \(user.login.password)")
                    .font(.system(size: 28))
                    .lineLimit(10)
                
                TextField("Cambiar Contraseña", text: $newPassWord).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    updateUser(email: user.email, password: newPassWord)
                    user.login.password = newPassWord
                    showAlert = true
                }) {
                    Text("Cambiar Contraseña")
                        .font(.system(size:22))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Contraseña Actualizada"), message: Text("La Contraseña ha sido cambiada con exito"), dismissButton: .default(Text("OK")))
                }
            }
        }
        .padding(10)
    }
}

func updateUser(email: String, password: String) {
    
    UserDefaults.standard.set(password, forKey:email)
}
struct DetailView__Previews: PreviewProvider {
    static var previews: some View {
        DetailView_(user: User(name: Name(first: "luis", last: "ramos"), email: "lerhb23@gmail.com", login: Login(password: "2399"), picture: Picture(large: "https://randomuser.me/api/portraits/women/7.jpg", thumbnail: "")))
    }
}
