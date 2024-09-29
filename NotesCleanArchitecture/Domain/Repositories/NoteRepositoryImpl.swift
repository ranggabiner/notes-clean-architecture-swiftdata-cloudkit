//
//  NoteRepositoryImpl.swift
//  NotesCleanArchitecture
//
//  Created by Rangga Biner on 29/09/24.
//

import Foundation
import SwiftData

class NoteRepositoryImpl: NoteRepository {
    private let dataSource: NoteDataSource
    
    init(dataSource: NoteDataSource) {
        self.dataSource = dataSource
    }
    
    func getAllNotes() async throws -> [Note] {
        return try await dataSource.fetchAllNotes()
    }
    
    func addNote(_ note: Note) async throws {
        try await dataSource.insert(note)
    }
    
    func updateNote(_ note: Note) async throws {
        try await dataSource.update(note)
    }
    
    func deleteNote(_ note: Note) async throws {
        try await dataSource.delete(note)
    }
}
