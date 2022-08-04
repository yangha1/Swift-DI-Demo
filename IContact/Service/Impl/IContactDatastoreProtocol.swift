//
//  IContactDatastoreProtocol.swift
//  IContact
//
//  Created by Harvey on 2022/8/3.
//

import Foundation

enum DBError: Error{
    case db, data
}

protocol IContactDatastoreProtocol {
    func getAllContact(_ callback:(Result<Array<ILocalContactProtocol>, DBError>) -> Void) -> Void
}

