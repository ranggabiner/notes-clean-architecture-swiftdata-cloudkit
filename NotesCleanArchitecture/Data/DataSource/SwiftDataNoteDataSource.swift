//
//  SwiftDataNoteDataSource.swift
//  NotesCleanArchitecture
//
//  Created by Rangga Biner on 29/09/24.
//

import Foundation
import SwiftData

class SwiftDataNoteDataSource: NoteDataSource {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchAllNotes() async throws -> [Note] {
        let descriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        return try context.fetch(descriptor)
    }
    
    func insert(_ note: Note) async throws {
        context.insert(note)
        try context.save()
    }
    
    func update(_ note: Note) async throws {
        try context.save()
    }
    
    func delete(_ note: Note) async throws {
        context.delete(note)
        try context.save()
    }
}

