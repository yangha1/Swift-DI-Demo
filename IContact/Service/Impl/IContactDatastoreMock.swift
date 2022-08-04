//
//  IContactDatastoreMock.swift
//  IContact
//
//  Created by Harvey on 2022/8/3.
//

import Foundation

class IContactDatastoreMock: IContactDatastoreProtocol {
    
    lazy var dataDict = [
        [
            "name":"contact_1",
            "phoneNumber":"1234567890"
        ],
        [
            "name":"contact_2",
            "phoneNumber":"1234567891"
        ],
        [
            "name":"contact_3",
            "phoneNumber":"1234567880"
        ],
        [
            "name":"contact_4",
            "phoneNumber":"1234567892"
        ],
        [
            "name":"contact_5",
            "phoneNumber":"1234565892"
        ],
        [
            "name":"contact_6",
            "phoneNumber":"1234567893"
        ],
        [
            "name":"contact_7",
            "phoneNumber":"1234567894"
        ],
        [
            "name":"contact_8",
            "phoneNumber":"1434567893"
        ],
        [
            "name":"contact_9",
            "phoneNumber":"1234567895"
        ],
        [
            "name":"contact_10",
            "phoneNumber":"1234567896"
        ],
        [
            "name":"contact_11",
            "phoneNumber":"1224567896"
        ],
        [
            "name":"contact_12",
            "phoneNumber":"1454567897"
        ],
        [
            "name":"contact_13",
            "phoneNumber":"1234567897"
        ],
        [
            "name":"contact_14",
            "phoneNumber":"1234567898"
        ],
        [
            "name":"contact_15",
            "phoneNumber":"1234568998"
        ],
        [
            "name":"contact_16",
            "phoneNumber":"1234567899"
        ],
    ]
    
    func getAllContact(_ callback: (Result<Array<ILocalContactProtocol>, DBError>) -> Void) {
        
        var array = Array<ILocalContactProtocol>()
        dataDict.forEach { dict in
            let contact = ILocalContact(name: dict["name"]!, phoneNumber: dict["phoneNumber"]!)
            array.append(contact)
        }
        callback(Result.success(array))
        
    }
}
