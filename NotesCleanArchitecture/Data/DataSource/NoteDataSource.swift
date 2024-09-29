//
//  NoteDataSource.swift
//  NotesCleanArchitecture
//
//  Created by Rangga Biner on 29/09/24.
//

protocol NoteDataSource {
    func fetchAllNotes() async throws -> [Note]
    func insert(_ note: Note) async throws
    func update(_ note: Note) async throws
    func delete(_ note: Note) async throws
}
