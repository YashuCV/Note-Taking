import SwiftUI

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    @Published var isEditing = false
    @Published var editingNote: Note?
    @Published var editingTitle = ""
    @Published var editingContent = ""

    init() {
        self.notes = Persistence.load()
    }

    func addNote(title: String, content: String) {
        let newNote = Note(id: UUID(), title: title, content: content, isCompleted: false)
        notes.append(newNote)
        Persistence.save(notes: notes)
    }

    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        Persistence.save(notes: notes)
    }

    func toggleCompletion(for note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isCompleted.toggle()
            Persistence.save(notes: notes)
        }
    }

    func updateNote(note: Note, newTitle: String, newContent: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].title = newTitle
            notes[index].content = newContent
            Persistence.save(notes: notes)
        }
    }
}
