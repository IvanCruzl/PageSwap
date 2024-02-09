import SwiftUI

struct Libro: Identifiable, Hashable {
    var id: Int
    var titulo: String
    var autor: String
    var sinopsis: String
    var idioma: String
    var tipoPasta: String
    
    // Implementación de la función hash(into:) requerida por Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(titulo)
        hasher.combine(autor)
        hasher.combine(sinopsis)
        hasher.combine(idioma)
        hasher.combine(tipoPasta)
    }
}

struct DetalleLibroView: View {
    let libro: Libro
    @State private var isPresentingSecondView = false
    @State private var isPresentingCompraView = false
    @State private var mostrarMensaje = false
    @State private var tiempoRestante = 8
    @State private var mostrarInicio = false
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
                                    Image("bag")
                                        .resizable()
                                        .frame(width: 24,height: 28.87)
                                    
                                    }.padding(.leading,5)
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
        }.overlay(
            Group {
                if mostrarMensaje {
                    VStack {
                        Text("Agregado a la bolsa!")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
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

struct Inicio: View {
    @State private var libros = [
            Libro(id: 1, titulo: "Cien años de soledad", autor: "Gabriel García Márquez", sinopsis: "La novela narra la historia de la familia Buendía a lo largo de siete generaciones en el pueblo ficticio de Macondo.", idioma: "Español", tipoPasta: "Blanda"),
            Libro(id: 2, titulo: "To Kill a Mockingbird", autor: "Harper Lee", sinopsis: "La historia de un abogado que defiende a un hombre negro acusado de violación en los años 30 en Alabama, visto a través de los ojos de sus hijos.", idioma: "Inglés", tipoPasta: "Dura"),
            Libro(id: 3, titulo: "Harry Potter and the Philosopher's Stone", autor: "J.K. Rowling", sinopsis: "El libro sigue las aventuras de un joven mago, Harry Potter, y sus amigos Hermione Granger y Ron Weasley, quienes son estudiantes en Hogwarts School of Witchcraft and Wizardry.", idioma: "Inglés", tipoPasta: "Dura"),
            Libro(id: 4, titulo: "El principito", autor: "Antoine de Saint-Exupéry", sinopsis: "La historia sigue a un joven príncipe que viaja de un planeta a otro, conociendo a varios adultos en el camino.", idioma: "Francés", tipoPasta: "Blanda")
        ]
    @State private var libros2 = [
        Libro(id: 1, titulo: "Orgullo y prejuicio", autor: "Jane Austen", sinopsis: "La historia de amor entre Elizabeth Bennet y Mr. Darcy en la Inglaterra del siglo XIX.", idioma: "Inglés", tipoPasta: "Blanda"),
        Libro(id: 2, titulo: "Jane Eyre", autor: "Charlotte Brontë", sinopsis: "La historia de una joven huérfana que se convierte en institutriz y se enamora de su empleador, Mr. Rochester.", idioma: "Inglés", tipoPasta: "Dura"),
        Libro(id: 3, titulo: "Besos de cereza", autor: "Lorraine Cocó", sinopsis: "Una novela sobre segundas oportunidades y el poder del amor verdadero.", idioma: "Español", tipoPasta: "Blanda"),
        Libro(id: 4, titulo: "Un amor", autor: "Alejandro Palomas", sinopsis: "La historia de un hombre que recibe una inesperada visita que cambiará su vida para siempre.", idioma: "Español", tipoPasta: "Dura")
    ]
    @State private var libros3 = [
        Libro(id: 1, titulo: "Drácula", autor: "Bram Stoker", sinopsis: "La historia del Conde Drácula y su intento de trasladarse de Transilvania a Inglaterra para difundir la maldición de los no muertos.", idioma: "Inglés", tipoPasta: "Blanda"),
        Libro(id: 2, titulo: "El resplandor", autor: "Stephen King", sinopsis: "La historia de un hombre que acepta un trabajo de cuidador de un hotel aislado durante el invierno, donde sufre de visiones paranormales y la creciente influencia maligna del hotel.", idioma: "Inglés", tipoPasta: "Dura"),
        Libro(id: 3, titulo: "It", autor: "Stephen King", sinopsis: "La historia de un grupo de amigos que se reúnen en su ciudad natal para enfrentarse a la criatura conocida como Pennywise, que ha estado aterrorizando a la ciudad durante siglos.", idioma: "Inglés", tipoPasta: "Dura"),
        Libro(id: 4, titulo: "Frankenstein", autor: "Mary Shelley", sinopsis: "La historia del joven científico Victor Frankenstein, quien crea un ser humano a partir de cadáveres y lo trae a la vida, solo para enfrentar las terribles consecuencias de su creación.", idioma: "Inglés", tipoPasta: "Blanda")
    ]

    
        @State private var seleccionado: Int = 0
        @State private var libroSeleccionado: Libro?
        
        var body: some View {
            TabView(selection: $seleccionado) {
                VStack {
                    ScrollView(){
                        VStack(alignment: .leading){
                            Text("Recomendado para ti")
                                .bold()
                                .font(.title2)
                                .padding(.leading,20)
                                
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    ForEach(libros) { libro in
                                        Button(action: {
                                            self.libroSeleccionado = libro
                                        }) {
                                            Image(libro.titulo)
                                                .resizable()
                                                .scaledToFill()
                                        }.frame(width: 358, height: 486)
                                            .cornerRadius(20)
                                            .padding(5)
                                            
                                    }
                                }
                                .padding(.leading)
                            }
                            .navigationTitle("Libros")
                            .sheet(item: $libroSeleccionado) { libro in
                                DetalleLibroView(libro: libro)
                            }
                        }.padding(.top)
                        VStack(alignment: .leading){
                            Text("Romance")
                                .bold()
                                .font(.title2)
                                .padding(.leading,20)
                                
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    ForEach(libros2) { libro in
                                        Button(action: {
                                            self.libroSeleccionado = libro
                                        }) {
                                            Image(libro.titulo)
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
                            .sheet(item: $libroSeleccionado) { libro in
                                DetalleLibroView(libro: libro)
                            }
                        }.padding(.top)
                        VStack(alignment: .leading){
                            Text("Horror")
                                .bold()
                                .font(.title2)
                                .padding(.leading,20)
                                
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    ForEach(libros3) { libro in
                                        Button(action: {
                                            self.libroSeleccionado = libro
                                        }) {
                                            Image(libro.titulo)
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
                            .sheet(item: $libroSeleccionado) { libro in
                                DetalleLibroView(libro: libro)
                            }
                        }.padding(.top)
                        
                        
                    }
                    
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Inicio")
                }
                .tag(0)
                TradeView(libro:nil)
                .tabItem {
                    Image("trade_arrow")
                        .renderingMode(.template)
                        .foregroundColor(seleccionado == 1 ? .black : .gray)
                    Text("Trade")
                }
                .tag(1)
                    
                
                Text("Contenido de la pestaña 3")
                    .tabItem {
                        Image(systemName: "plus.app")
                            .renderingMode(.template)
                            .foregroundColor(seleccionado == 1 ? .black : .gray)
                        Text("Add")
                    }
                    .tag(2)
                BagView()
                    .tabItem {
                        Image("bag")
                            .renderingMode(.template)
                            .foregroundColor(seleccionado == 1 ? .black : .gray)
                        Text("Otro")
                    }
                    .tag(3)
                
                Text("Coming Soon...")
                    .tabItem {
                        Image(systemName: "person")
                            .renderingMode(.template)
                            .foregroundColor(seleccionado == 1 ? .black : .gray)
                        Text("Perfil")
                    }
                    .tag(4)
            }
        }
    
}



struct DetalleCompraView: View {
    let libro: Libro
    @State private var mostrarMensaje = false
    @State private var tiempoRestante = 8
    @State private var mostrarInicio = false
    var body: some View {
        VStack (alignment: .center){
            Text("Detalles de la compra")
                .bold()
                .font(.title)
                .padding()
            HStack(alignment: .top){
                Image(libro.titulo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 129,height: 175)
                VStack(alignment:.leading){
                    Text(libro.titulo)
                        .font(.system(size: 24))
                    Text("de: " + libro.autor)
                        .font(.system(size: 15))
                }
            }.padding(20)
            Spacer()
            Button("Comprar") {
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
            .frame(width: 320,height: 60)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("Salmon"), Color("lightOrange")]), startPoint: .leading, endPoint: .trailing) // Definir el degradado
            )
            .clipShape(Capsule())
            Spacer()
        }.overlay(
            Group {
                if mostrarMensaje {
                    VStack {
                        Text("Compra completada!")
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Inicio()
    }
}
