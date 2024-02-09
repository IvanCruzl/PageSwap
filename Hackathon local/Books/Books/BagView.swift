import SwiftUI

struct BagView: View {
    @State private var selectedBook: Libro?
    
    let libros: [Libro] = [
        Libro(id: 1, titulo: "Cien años de soledad", autor: "Gabriel García Márquez", sinopsis: "La novela narra la historia de la familia Buendía a lo largo de siete generaciones en el pueblo ficticio de Macondo.", idioma: "Español", tipoPasta: "Blanda"),
        Libro(id: 2, titulo: "Jane Eyre", autor: "Charlotte Brontë", sinopsis: "La historia de una joven huérfana que se convierte en institutriz y se enamora de su empleador, Mr. Rochester.", idioma: "Inglés", tipoPasta: "Dura"),
        Libro(id: 3, titulo: "Besos de cereza", autor: "Lorraine Cocó", sinopsis: "Una novela sobre segundas oportunidades y el poder del amor verdadero.", idioma: "Español", tipoPasta: "Blanda")
    ]

    var body: some View {
        NavigationView {
            List(libros) { libro in
                Button(action: {
                    selectedBook = libro
                }) {
                    HStack {
                        Image(libro.titulo)
                            .resizable()
                            .frame(width: 50, height: 70)
                        VStack(alignment:.leading){
                            Text(libro.titulo)
                                .bold()
                                .foregroundColor(.black)
                            Text(libro.autor)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Tu Bolsa")
            .sheet(item: $selectedBook) { book in
                DetalleLibrosView(libro: book)
            }
        }
    }
}

struct DetalleLibrosView: View {
    let libro: Libro
    @State private var isPresentingSecondView = false
    @State private var isPresentingCompraView = false

    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Image(libro.titulo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 129,height: 175)
                VStack(alignment:.leading){
                    Text(libro.titulo)
                        .font(.system(size: 24))
                    Text("de: " + libro.autor)
                        .font(.system(size: 15))
                    
                    HStack{
                        Button("$150") {
                            self.isPresentingCompraView.toggle()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 130,height: 40)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color("Salmon"), Color("lightOrange")]), startPoint: .leading, endPoint: .trailing) // Definir el degradado
                        )
                        .clipShape(Capsule())
                        .fullScreenCover(isPresented: $isPresentingCompraView) {
                                        DetalleCompraView(libro: libro)
                                    }
                        
                        Button(action: {
                            self.isPresentingSecondView.toggle()
                                }) {
                                    Image("trade_arrow")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24,height: 28.87)

                                    }.padding(.trailing,5)
                            .fullScreenCover(isPresented: $isPresentingSecondView) {
                                            TradeView(libro: libro)
                                        }
  
                    }
                    
                }
            }.padding(20)
            Image("Line").padding()
            Text("Sinopsis:")
                .font(.headline)
                .bold()
                .padding(.leading,30)
                .padding(.bottom,10)
            Text(libro.sinopsis)
                .padding([.leading,.trailing],30)
                .multilineTextAlignment(.leading)
            Image("Line").padding()
            Text("Detalles:")
                .font(.headline)
                .bold()
                .padding(.leading,30)
                .padding(.bottom,10)
            Text("Idioma: \(libro.idioma)")
                .padding([.leading,.trailing],30)
            Text("Tipo de Pasta: \(libro.tipoPasta)")
                .padding([.leading,.trailing],30)
            Spacer()
        }
    }
}


struct BagView_Previews: PreviewProvider {
    static var previews: some View {
        BagView()
    }
}
