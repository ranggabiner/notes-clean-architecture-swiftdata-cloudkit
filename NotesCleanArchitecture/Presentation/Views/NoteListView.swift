//
//  NoteListView.swift
//  NotesCleanArchitecture
//
//  Created by Rangga Biner on 29/09/24.
//

import SwiftUI

struct NoteListView: View {
    @StateObject var viewModel: NoteListViewModel
    @State private var isAddingNote = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.content)
                                .font(.subheadline)
                                .lineLimit(1)
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        Task {
                            await viewModel.deleteNote(viewModel.notes[index])
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingNote = true }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        Task {
                            await viewModel.loadNotes()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .refreshable {
                await viewModel.loadNotes()
            }
            .sheet(isPresented: $isAddingNote) {
                NoteEditView(viewModel: viewModel, mode: .add)
            }
        }
        .task {
            await viewModel.loadNotes()
        }
    }
}

struct NoteDetailView: View {
    let note: Note
    @ObservedObject var viewModel: NoteListViewModel
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.title)
            Text(note.content)
                .font(.body)
        }
        .padding()
        .navigationBarItems(trailing: Button("Edit") {
            isEditing = true
        })
        .sheet(isPresented: $isEditing) {
            NoteEditView(viewModel: viewModel, mode: .edit(note))
        }
    }
}

struct NoteEditView: View {
    @ObservedObject var viewModel: NoteListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var content = ""
    
    enum Mode: Equatable {
        case add
        case edit(Note)
        
        static func == (lhs: Mode, rhs: Mode) -> Bool {
            switch (lhs, rhs) {
            case (.add, .add):
                return true
            case let (.edit(note1), .edit(note2)):
                return note1.id == note2.id
            default:
                return false
            }
        }
    }
    
    let mode: Mode
    
    init(viewModel: NoteListViewModel, mode: Mode) {
        self.viewModel = viewModel
        self.mode = mode
        
        switch mode {
        case .add:
            _title = State(initialValue: "")
            _content = State(initialValue: "")
        case .edit(let note):
            _title = State(initialValue: note.title)
            _content = State(initialValue: note.content)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
            }
            .navigationTitle(mode == .add ? "Add Note" : "Edit Note")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                saveNote()
            })
        }
    }
    
    private func saveNote() {
        Task {
            switch mode {
            case .add:
                let newNote = Note(title: title, content: content)
                await viewModel.addNote(newNote)
            case .edit(let note):
                note.title = title
                note.content = content
                await viewModel.updateNote(note)
            }
            presentationMode.wrappedValue.dismiss()
        }
    }
}
