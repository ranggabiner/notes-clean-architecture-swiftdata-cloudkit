//
//  NoteUseCase.swift
//  NotesCleanArchitecture
//
//  Created by Rangga Biner on 29/09/24.
//

import Foundation

struct NoteUseCases {
    let repository: NoteRepository
    
    func getAllNotes() async throws -> [Note] {
        return try await repository.getAllNotes()
    }
    
    func addNote(_ note: Note) async throws {
        try await repository.addNote(note)
    }
    
    func updateNote(_ note: Note) async throws {
        try await repository.updateNote(note)
    }
    
    func deleteNote(_ note: Note) async throws {
        try await repository.deleteNote(note)
    }
}
