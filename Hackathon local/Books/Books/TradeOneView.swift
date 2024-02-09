import SwiftUI
struct TradeOneView: View {
    @State private var selectedBookFirstList: Libro?
    @State private var selectedBookSecondList: Libro?
    @State private var isPresentingInicioView = false
    @State private var isDetailInterchangeViewPresented = false


    let firstListBooks = [
        Libro(id: 1, titulo: "Orgullo y prejuicio", autor: "Jane Austen", sinopsis: "La historia de amor entre Elizabeth Bennet y Mr. Darcy en la Inglaterra del siglo XIX.", idioma: "Inglés", tipoPasta: "Blanda"),
        Libro(id: 2, titulo: "Jane Eyre", autor: "Charlotte Brontë", sinopsis: "La historia de una joven huérfana que se convierte en institutriz y se enamora de su empleador, Mr. Rochester.", idioma: "Inglés", tipoPasta: "Dura"),
        Libro(id: 3, titulo: "Besos de cereza", autor: "Lorraine Cocó", sinopsis: "Una novela sobre segundas oportunidades y el poder del amor verdadero.", idioma: "Español", tipoPasta: "Blanda"),
        Libro(id: 4, titulo: "Un amor", autor: "Alejandro Palomas", sinopsis: "La historia de un hombre que recibe una inesperada visita que cambiará su vida para siempre.", idioma: "Español", tipoPasta: "Dura"),
        Libro(id: 5, titulo: "Cien años de soledad", autor: "Gabriel García Márquez", sinopsis: "La novela narra la historia de la familia Buendía a lo largo de siete generaciones en el pueblo ficticio de Macondo.", idioma: "Español", tipoPasta: "Blanda"),
        Libro(id: 6, titulo: "To Kill a Mockingbird", autor: "Harper Lee", sinopsis: "La historia de un abogado que defiende a un hombre negro acusado de violación en los años 30 en Alabama, visto a través de los ojos de sus hijos.", idioma: "Inglés", tipoPasta: "Dura"),
        Libro(id: 7, titulo: "Harry Potter and the Philosopher's Stone", autor: "J.K. Rowling", sinopsis: "El libro sigue las aventuras de un joven mago, Harry Potter, y sus amigos Hermione Granger y Ron Weasley, quienes son estudiantes en Hogwarts School of Witchcraft and Wizardry.", idioma: "Inglés", tipoPasta: "Dura"),
        Libro(id: 8, titulo: "El principito", autor: "Antoine de Saint-Exupéry", sinopsis: "La historia sigue a un joven príncipe que viaja de un planeta a otro, conociendo a varios adultos en el camino.", idioma: "Francés", tipoPasta: "Blanda")
    ]

    let secondListBooks = [
        Libro(id: 1, titulo: "Cien años de soledad", autor: "Gabriel García Márquez", sinopsis: "La novela narra la historia de la familia Buendía a lo largo de siete generaciones en el pueblo ficticio de Macondo.", idioma: "Español", tipoPasta: "Blanda"),
        Libro(id: 2, titulo: "Jane Eyre", autor: "Charlotte Brontë", sinopsis: "La historia de una joven huérfana que se convierte en institutriz y se enamora de su empleador, Mr. Rochester.", idioma: "Inglés", tipoPasta: "Dura"),
        Libro(id: 3, titulo: "Besos de cereza", autor: "Lorraine Cocó", sinopsis: "Una novela sobre segundas oportunidades y el poder del amor verdadero.", idioma: "Español", tipoPasta: "Blanda")
    ]

    var body: some View {
        VStack(alignment: .leading) {

            HStack {
                Button(action: {
                    isPresentingInicioView.toggle()
                }) {
                    Image(systemName: "house")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 28.87)
                        .padding(20)
                }
                .fullScreenCover(isPresented: $isPresentingInicioView) {
                    Inicio()
                }
                Spacer()
            }.padding(.top,80)

            Text("Selecciona un libro")
                .font(.title)
                .bold()
                .padding(.top, 30)
                .padding(.leading, 20)

            Text("Libros disponibles")
                .font(.title2)
                .bold()
                .padding(.top, 10)
                .padding(.leading, 20)

            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(firstListBooks) { book in
                        Button(action: {
                            selectedBookFirstList = book
                        }) {
                            Image(book.titulo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 96, height: 131)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.leading)
                }
            }

            Text("Libros disponibles a intercambiar")
                .font(.title2)
                .bold()
                .padding(.top, 10)
                .padding(.leading, 20)

            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(secondListBooks) { book in
                        Button(action: {
                            selectedBookSecondList = book
                        }) {
                            Image(book.titulo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 96, height: 131)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.leading)
                }
            }
            Button(action: {
                isDetailInterchangeViewPresented.toggle()
            }) {
                Text("Intercambio de: \(selectedBookFirstList?.titulo ?? "") y \(selectedBookSecondList?.titulo ?? "")")
            }
            .sheet(isPresented: $isDetailInterchangeViewPresented) {
                if let book1 = selectedBookFirstList, let book2 = selectedBookSecondList {
                    DetailInterchangeView(selectedBook1: book1, selectedBook2: book2)
                } else {
                    Text("Por favor selecciona un libro de cada lista.")
                }
            }
            .padding()
            Spacer()

        }
        .ignoresSafeArea()
        .background(Color.white)
    }
}

struct DetailInterchangeView: View {
    let selectedBook1: Libro
    let selectedBook2: Libro
    @State private var mostrarMensaje = false
    @State private var tiempoRestante = 8
    @State private var mostrarInicio = false
    var body: some View {
        VStack {
            Spacer()
            Text("Detalles del intercambio")
                .bold()
                .font(.title)
                .padding()
            Spacer()
            HStack {
                Image(selectedBook1.titulo)
                    .resizable()
                    .frame(width: 100, height: 150)
                
                Image("trade_arrow")
                    .padding([.leading, .trailing], 20)

                Image(selectedBook2.titulo)
                    .resizable()
                    .frame(width: 100, height: 150)
            }
            .padding()
            Spacer()
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
            .padding(.top, 40)
            
            Spacer()
            
            Spacer()
        }.overlay(
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

struct TradeOneView_Previews: PreviewProvider {
    static var previews: some View {
        TradeOneView()
    }
}
