import SwiftUI

struct LibrosIntercambio: Identifiable, Hashable {
    let id = UUID() // Genera un identificador único para cada instancia
    let libroInicial: Libro
    let libroSeleccionado: Libro
    
    // Implementación de la función hash(into:) requerida por Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TradeView: View {
    @State private var isPresentingSecondView = false
    let libro: Libro?
    let librosDisponibles = [
        Libro(id: 1, titulo: "Cien años de soledad", autor: "Gabriel García Márquez", sinopsis: "La novela narra la historia de la familia Buendía a lo largo de siete generaciones en el pueblo ficticio de Macondo.", idioma: "Español", tipoPasta: "Blanda"),
        Libro(id: 2, titulo: "Jane Eyre", autor: "Charlotte Brontë", sinopsis: "La historia de una joven huérfana que se convierte en institutriz y se enamora de su empleador, Mr. Rochester.", idioma: "Inglés", tipoPasta: "Dura"),
        Libro(id: 3, titulo: "Besos de cereza", autor: "Lorraine Cocó", sinopsis: "Una novela sobre segundas oportunidades y el poder del amor verdadero.", idioma: "Español", tipoPasta: "Blanda")
    ]
    @State private var librosIntercambio: LibrosIntercambio?
    
    var body: some View {
        if let libro = libro {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        self.isPresentingSecondView.toggle()
                    }) {
                        Image(systemName: "house")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 28.87)
                            .padding(20)
                    }
                    .fullScreenCover(isPresented: $isPresentingSecondView) {
                        Inicio()
                    }
                    Spacer()
                }
                Text("Intercambiar")
                    .font(.title)
                    .bold()
                    .padding(.top,30)
                    .padding(.leading,20)

                
                HStack(alignment: .top){
                    Image(libro.titulo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 129, height: 175)
                        .padding(.leading,20)
                    
                    VStack(alignment: .leading) {
                        Text(libro.titulo)
                            .font(.system(size: 24))
                        Text("de: " + libro.autor)
                            .font(.system(size: 15))
                        
                    }
                }
                Image("Line").padding(20)
                Text("Libro a Intercambiar")
                    .bold()
                    .font(.title2)
                    .padding()
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(librosDisponibles) { librose in
                            Button(action: {
                                self.librosIntercambio = LibrosIntercambio(libroInicial: libro, libroSeleccionado: librose)
                            }) {
                                Image(librose.titulo)
                                    .resizable()
                                    .scaledToFill()
                            }.frame(width: 96, height: 131)
                                .cornerRadius(20)
                                .padding(5)
                                
                        }
                    }
                    .padding(.leading)
                }
                .navigationTitle("Libros")
                .sheet(item: $librosIntercambio) { librosIntercambio in
                    DetalleIntercambioView(librosIntercambio: librosIntercambio)
                }
                Spacer()
            }
        } else {
            TradeOneView()
        }
    }
}


struct DetalleIntercambioView: View {
    let librosIntercambio: LibrosIntercambio
    @State private var mostrarMensaje = false
    @State private var tiempoRestante = 8
    @State private var mostrarInicio = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Solicitud Enviada")
                .font(.title)
                .bold()
                .padding(.bottom, 80)
            
            HStack {
                Image(librosIntercambio.libroInicial.titulo)
                    .resizable()
                    .frame(width: 100, height: 150)
                Image("trade_arrow")
                    .padding([.leading, .trailing], 20)
                Image(librosIntercambio.libroSeleccionado.titulo)
                    .resizable()
                    .frame(width: 100, height: 150)
                
            }.padding(.bottom, 80)
            
            Button("Aceptar") {
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
            }
            .foregroundColor(.white)
            .padding()
            .frame(width: 130, height: 40)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("Salmon"), Color("lightOrange")]), startPoint: .leading, endPoint: .trailing))
            .clipShape(Capsule())
            
            Spacer()
        }
        .padding()
        .overlay(
            Group {
                if mostrarMensaje {
                    VStack {
                        Text("Completado!")
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


struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleLibro = Libro(id: 1, titulo: "Cien años de soledad", autor: "Gabriel García Márquez", sinopsis: "La novela narra la historia de la familia Buendía a lo largo de siete generaciones en el pueblo ficticio de Macondo.", idioma: "Español", tipoPasta: "Blanda")

        TradeView(libro: sampleLibro)
    }
}


