import SwiftUI

struct ContentView: View {
    @State private var isPresentingSecondView = false

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Salmon"), Color("lightOrange")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    Spacer()
                    Image("logo_app")
                        .padding(.bottom,60)
                    Image("Title")
                    Spacer()
                }
                Button(action: {
                    self.isPresentingSecondView.toggle()                        }) {
                                HStack {
                                    Image("logo_google")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 46, height: 46)
                                    Text("Iniciar Sesión con Google")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .padding(.horizontal, 10)
                                    Spacer()
                                }
                                .frame(width: 294, height: 57)
                                .background(Color.white)
                                .cornerRadius(50)
                            
                            }
                        .padding(20)
                        .fullScreenCover(isPresented: $isPresentingSecondView) {
                            Inicio()
                        }
                
            }
        }
       
    }
}

#Preview {
    ContentView()
}
