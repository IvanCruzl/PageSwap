import SwiftUI

struct DetalleLibroView: View {
    let libro: Libro
    
    var body: some View {
        VStack {
            Text(libro.titulo)
                .font(.title)
                .padding()
            Text("Autor: \(libro.autor)")
            Text("Sinopsis: \(libro.sinopsis)")
            Text("Idioma: \(libro.idioma)")
            Text("Tipo de Pasta: \(libro.tipoPasta)")
            Spacer()
        }
    }
}
