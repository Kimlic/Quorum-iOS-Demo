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
    
    private lazy var configCustom = Web3Config(scheme: "http", host: "127.0.0.4", port: 22005, networkId: 10)
    private lazy var configLocal = Web3ParamsLocalhost()    
    private lazy var quorumManager = Quorum(configCustom)
    private lazy var simpleStorageContract = SimpleStorageContract(address: "0xa29495d736697ced921cf5fca1ea38dd9337755c")

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        quorum()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func quorum() {
        let mnemonic = try! Quorum.mnemonic()
        print("MNEMONIC: ", mnemonic, "\n")
        try! Quorum.keystoreWith(mnemonic: mnemonic)

        let value = try! quorumManager.call(contract: simpleStorageContract, method: simpleStorageContract.getters.getValue)
        print("STORED VALUE: ", value, "\n")

        let receiptSet = try! quorumManager.send(contract: simpleStorageContract, method: simpleStorageContract.transactions.setValue, params: [10])
        print("RECEIPT SET: ", receiptSet, "\n")

        let newValue = try! quorumManager.call(contract: simpleStorageContract, method: "get")
        print("NEW STORED VALUE: ", newValue, "\n")
        
        let receiptSetDefault = try! quorumManager.send(contract: simpleStorageContract, method: simpleStorageContract.transactions.setDefaultValue)
        print("RECEIPT SETDEFAULT: ", receiptSetDefault, "\n")
        
        let newNewValue = try! quorumManager.call(contract: simpleStorageContract, method: "get")
        print("NEW NEW STORED VALUE: ", newNewValue, "\n")
    }
}

