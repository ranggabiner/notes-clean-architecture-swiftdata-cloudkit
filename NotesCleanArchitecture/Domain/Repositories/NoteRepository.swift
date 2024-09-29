//
//  NoteRepository.swift
//  NotesCleanArchitecture
//
//  Created by Rangga Biner on 29/09/24.
//

import Foundation

protocol NoteRepository {
    func getAllNotes() async throws -> [Note]
    func addNote(_ note: Note) async throws
    func updateNote(_ note: Note) async throws
    func deleteNote(_ note: Note) async throws
}
