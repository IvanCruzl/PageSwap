
import SwiftUI

struct Book {
    var name: String
    var author: String
    var synopsis: String
}

struct UploadView: View {
    @State private var book = Book(name: "", author: "", synopsis: "")
    @State private var mostrarMensaje = false
    @State private var tiempoRestante = 8
    @State private var mostrarInicio = false
    @State private var isPresentingSecondView = false
    var body: some View {
        VStack{
            NavigationView {
                Form {
                    Section(header: Text("Nombre")) {
                        TextField("Nombre del libro", text: $book.name)
                    }

                    Section(header: Text("Autor")) {
                        TextField("Autor del libro", text: $book.author)
                    }

                    Section(header: Text("Sinopsis")) {
                        TextEditor(text: $book.synopsis)
                            .frame(height: 100)
                    }
                }
                .navigationBarTitle("Subir Libro")
                .background(Color.clear) // Establecer el color de fondo del formulario como transparente
            }
            
            Button(action: {
                mostrarMensaje.toggle()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    if tiempoRestante > 0 {
                        tiempoRestante -= 1
                    } else {
                        timer.invalidate()
                        mostrarMensaje = false
                        mostrarInicio = true
                    }
                }
            }) {
                Text("Subir libro")
                    .bold()
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("Salmon"), Color("lightOrange")]), startPoint: .leading, endPoint: .trailing) // Definir el degradado
                    )

                    .cornerRadius(30)
            }.frame(width: 310,height: 60)
                .offset(y:-180)
            Button(action: {
                self.isPresentingSecondView.toggle()
                    }) {
                        Image(systemName:"camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24,height: 28.87)

                        }.padding(.trailing,5)
                .fullScreenCover(isPresented: $isPresentingSecondView) {
                    CamerasView()}
                .offset(x:135, y:-670)
            Spacer()
        }.background(Color("GrayGood")) // Establecer el color de fondo del VStack como transparente
            .overlay(
                Group {
                    if mostrarMensaje {
                        VStack {
                            Text("Se subió el libro")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                                
                            Image(systemName: "hand.thumbsup")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.bottom)
                        }.background(Color("Salmon"))
                            .opacity(0.9)
                            .cornerRadius(10)
                            .padding()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                mostrarMensaje = false
                                mostrarInicio = true
                            }
                        }
                    }
                }
            )
            .background(
                Color.clear
                    .fullScreenCover(isPresented: $mostrarInicio) {
                        Inicio()
                    }
            )
        
    }
}


struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
