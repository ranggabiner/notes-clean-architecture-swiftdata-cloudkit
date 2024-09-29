//
//  NoteListViewModel.swift
//  NotesCleanArchitecture
//
//  Created by Rangga Biner on 29/09/24.
//

import Foundation

@MainActor
class NoteListViewModel: ObservableObject {
    @Published var notes: [Note] = []
    private let useCases: NoteUseCases
    
    init(useCases: NoteUseCases) {
        self.useCases = useCases
    }
    
    func loadNotes() async {
        do {
            notes = try await useCases.getAllNotes()
        } catch {
            print("Error loading notes: \(error)")
        }
    }
    
    func addNote(_ note: Note) async {
        do {
            try await useCases.addNote(note)
            await loadNotes()
        } catch {
            print("Error adding note: \(error)")
        }
    }
    
    func updateNote(_ note: Note) async {
        do {
            try await useCases.updateNote(note)
            await loadNotes()
        } catch {
            print("Error updating note: \(error)")
        }
    }
    
    func deleteNote(_ note: Note) async {
        do {
            try await useCases.deleteNote(note)
            await loadNotes()
        } catch {
            print("Error deleting note: \(error)")
        }
    }
}
