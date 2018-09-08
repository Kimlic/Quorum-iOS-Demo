//
//  ViewController.swift
//  ios-quorum
//
//  Created by Dmytro Nasyrov on 5/21/18.
//  Copyright © 2018 Pharos Production Inc. for Kimlic. All rights reserved.
//

import UIKit
import Quorum

class ViewController: UIViewController {
    
    // Variables
    
    private lazy var configCustom = Web3Config(scheme: "http", host: "127.0.0.1", port: 22000, path:"", networkId: 10)
    private lazy var configKimlic = Web3Config(scheme: "http", host: "51.141.120.215", port: 22000, path:"", networkId: 10)
    private lazy var quorumManager = Quorum(configCustom)
    
    @IBOutlet weak var imageView: UIImageView!

    // Life
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        demo()
        kimlic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Private
    
    private func kimlic() {
        let accountStorageAdapter = try! AccountStorageAdapter(address: "0xBA5fA42b2E69258F7aD5b551F90DD3E2242f2637")
        let mnemonic = try! Quorum.mnemonic()
        print("MNEMONIC: ", mnemonic, "\n")
        print("USER ADDR: \(quorumManager.accountAddress())")
        try! Quorum.keystoreWith(mnemonic: mnemonic)

        do {
            let value = "+380997762791"
            let type = "phone"
            let param = "'{\"\(type)\":\"\(value.sha256())\"}'"
            let params = [param, type] as [Any]
            let method = accountStorageAdapter.transactions.setFieldMainData
            let receiptSet = try quorumManager.send(contract: accountStorageAdapter, method: method, params: params)
            print("RECEIPT SET: ", receiptSet, "\n")
        } catch let err {
            print("CATCH: ", err, "\n")
        }
    }
    
    private func demo() {
        let simpleStorageContract = try! SimpleStorageContract(address: "0x5fbdbafb16c542cd8ec87ed6e62498bfa1206cd0")
        
        let mnemonic = try! Quorum.mnemonic()
        print("MNEMONIC: ", mnemonic, "\n")
        try! Quorum.keystoreWith(mnemonic: mnemonic)

        let value = try! quorumManager.call(contract: simpleStorageContract, method: simpleStorageContract.getters.getValue)
        print("STORED VALUE: ", value, "\n")

        do {
            let receiptSet = try quorumManager.send(contract: simpleStorageContract, method: simpleStorageContract.transactions.setValue, params: [10])
            print("RECEIPT SET: ", receiptSet, "\n")
        } catch let err {
            print("CATCH: ", err, "\n")
        }

        let newValue = try! quorumManager.call(contract: simpleStorageContract, method: "get")
        print("NEW STORED VALUE: ", newValue, "\n")
        
        do {
            let receiptSetDefault = try quorumManager.send(contract: simpleStorageContract, method: simpleStorageContract.transactions.setDefaultValue)
            print("RECEIPT SETDEFAULT: ", receiptSetDefault, "\n")
        } catch let err {
            print("CATCH: ", err, "\n")
        }
        
        let newNewValue = try! quorumManager.call(contract: simpleStorageContract, method: "get")
        print("NEW NEW STORED VALUE: ", newNewValue, "\n")
    }
}

