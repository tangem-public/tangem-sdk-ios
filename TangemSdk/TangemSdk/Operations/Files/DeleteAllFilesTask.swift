//
//  DeleteAllFilesTask.swift
//  TangemSdk
//
//  Created by Andrew Son on 10/12/20.
//  Copyright © 2020 Tangem AG. All rights reserved.
//

import Foundation

/// Task for deleting all files from card.
final class DeleteAllFilesTask: CardSessionRunnable {
    func run(in session: CardSession, completion: @escaping CompletionResult<SuccessResponse>) {
        deleteFile(session: session, completion: completion)
    }
    
    private func deleteFile(session: CardSession, completion: @escaping CompletionResult<SuccessResponse>) {
        let command = DeleteFileCommand(fileIndex: 0)
        
        command.run(in: session) { (result) in
            switch result {
            case .success:
                self.deleteFile(session: session, completion: completion)
            case .failure(let error):
                if case .errorProcessingCommand = error {
                    completion(.success(SuccessResponse(cardId: session.environment.card?.cardId ?? "")))
                    return
                }
                
                completion(.failure(error))
            }
        }
    }
    
}
