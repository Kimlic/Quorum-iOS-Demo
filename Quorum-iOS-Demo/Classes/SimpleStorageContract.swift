//
//  SimpleStorageContract.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 6/9/18.
//  Copyright © 2018 Pharos Production Inc for Kimlic. All rights reserved.
//

import Foundation
import Quorum

struct SimpleStorageContract: QuorumContract {

    struct Getters {
        let getValue = "get"
    }
    
    struct Transactions {
        let setValue = "set"
        let setDefaultValue = "setEmpty"
    }
    
    let address: String
    let ABI: String
    let getters = Getters()
    let transactions = Transactions()
    
    init(address: String) throws {
        self.address = address
        
        ABI = "[{\"constant\": true,\"inputs\": [],\"name\": \"storedData\",\"outputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"inputs\": [{\"name\": \"initVal\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"constructor\"},{\"constant\": false,\"inputs\": [{\"name\": \"x\",\"type\": \"uint256\"}],\"name\": \"set\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [],\"name\": \"setEmpty\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"get\",\"outputs\": [{\"name\": \"retVal\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},]"
    }
}
