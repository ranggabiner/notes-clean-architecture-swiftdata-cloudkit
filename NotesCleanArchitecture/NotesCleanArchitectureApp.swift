//
//  NotesCleanArchitectureApp.swift
//  NotesCleanArchitecture
//
//  Created by Rangga Biner on 28/09/24.
//

import SwiftUI
import SwiftData

@main
struct NotesCleanArchitectureApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Note.self)
        } catch {
            fatalError("Failed to create ModelContainer for Note: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            let context = container.mainContext
            let dataSource = SwiftDataNoteDataSource(context: context)
            let repository = NoteRepositoryImpl(dataSource: dataSource)
            let useCases = NoteUseCases(repository: repository)
            let viewModel = NoteListViewModel(useCases: useCases)
            
            NoteListView(viewModel: viewModel)
        }
        .modelContainer(container)
    }
}

