//
//  Note.swift
//  NotesCleanArchitecture
//
//  Created by Rangga Biner on 29/09/24.
//

import Foundation
import SwiftData

@Model
class Note {
    // must have a value if you want to synchronize cloudkit (except optional types)
    var id: UUID = UUID()
    var title: String = ""
    var content: String = ""
    var createdAt: Date = Date.now
    
    init(id: UUID = UUID(), title: String, content: String, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
    }
}
