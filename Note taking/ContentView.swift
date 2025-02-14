import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = NotesViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all) 

                List {
                    ForEach(viewModel.notes) { note in
                        NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(note.title)
                                        .font(.custom("AvenirNext-Bold", size: 20))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(note.isCompleted ? .gray : .black)
                                        .strikethrough(note.isCompleted, color: .gray)

                                    Text(note.content)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                if note.isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteNote)
                }
                .background(Color.clear)
            }
            .navigationTitle("Notes")
            .navigationBarItems(trailing:
                NavigationLink(destination: AddEditNoteView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .clipShape(Circle()) 
                }
            )
        }
    }
}
