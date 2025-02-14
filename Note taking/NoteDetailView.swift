import SwiftUI

struct NoteDetailView: View {
    var note: Note
    @ObservedObject var viewModel: NotesViewModel
    @State private var isEditing = false
    @State private var tempTitle = ""
    @State private var tempContent = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if isEditing {
                Form {
                    Section {
                        TextField("Title", text: $tempTitle)
                            .font(.custom("AvenirNext-Bold", size: 18))

                        TextEditor(text: $tempContent)
                            .frame(minHeight: 200)
                    }
                }
            } else {
                Text(note.title)
                    .font(.custom("AvenirNext-Bold", size: 24))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .strikethrough(note.isCompleted, color: .gray)

                Text(note.content)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Spacer()

                Button(note.isCompleted ? "Mark as Incomplete" : "Mark as Completed") {
                    viewModel.toggleCompletion(for: note)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(note.isCompleted ? Color.orange : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(1), radius: 5, x: 0, y: 2)
                .padding()
            }
        }
        .onAppear {
            tempTitle = note.title
            tempContent = note.content
        }
        .navigationTitle(isEditing ? "Edit Note" : "Note Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button("Save") {
                        viewModel.updateNote(note: note, newTitle: tempTitle, newContent: tempContent)
                        isEditing = false
                    }
                } else {
                    Button(action: {
                        isEditing = true
                        tempTitle = note.title
                        tempContent = note.content
                    }) {
                        Image(systemName: "square.and.pencil")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}
