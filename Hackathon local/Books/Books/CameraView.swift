
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraView>) {

    }
}

struct CamerasView: View {
    @State private var isShown = false
    @State private var image: UIImage?
    @State private var isPresentingSecondView = false

    var body: some View {
        VStack {
            Button(action: {
                self.isPresentingSecondView.toggle()
                    }) {
                        Image(systemName:"house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)

                        }.padding(.trailing,5)
                .fullScreenCover(isPresented: $isPresentingSecondView) {
                   Inicio()}
                .offset(x: -145, y: -90)
            Text("Subir Libro")
                .font(.system(size: 35))
                .fontWeight(.bold)
                .padding(.top, -60)
                .padding(.leading, -100)
            
                

            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 4)
                    .frame(width: 300, height: 400)
                    .padding()

                Button(action: {
                    self.isShown.toggle()
                }) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 260, height: 60)
                        .foregroundColor(Color(red: 254/255, green: 139/255, blue: 136/255))
                        .overlay(
                            Text("Tomar Foto")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .bold()
                        )
                }
            }
        }
        .sheet(isPresented: $isShown, onDismiss: loadImage) {
            CameraView(isShown: self.$isShown, image: self.$image)
        }
    }

    func loadImage() {
        // Implementa aquí la lógica para cargar la imagen en la aplicación
        // Puedes almacenarla, procesarla, etc.
    }
}

struct CamerasView_Previews: PreviewProvider {
    static var previews: some View {
        CamerasView()
    }
}
