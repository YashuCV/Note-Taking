import SwiftUI

struct AddEditNoteView: View {
    @ObservedObject var viewModel: NotesViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle(viewModel.isEditing ? "Edit Note" : "Add Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                           content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            showAlert = true
                        } else {
                            if viewModel.isEditing {
                                viewModel.updateNote(note: viewModel.editingNote!, newTitle: title, newContent: content)
                            } else {
                                viewModel.addNote(title: title, content: content)
                            }
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .alert(isPresented: $showAlert) {  
                Alert(
                    title: Text("Error"),
                    message: Text("Title and Content cannot be empty."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
