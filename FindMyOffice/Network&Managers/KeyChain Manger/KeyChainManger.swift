//
//  KeyChainManger.swift
//  FindMyOffice
//
//  Created by Emincan on 29.08.2022.
//

import Foundation
import Security


class KeyChainManager {
    
    enum KeyChainError: Error{
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    func saveToChain(mail:String,password:Data)
        throws {
            let query: [String:AnyObject] = [kSecAttrAccount as String: mail as AnyObject,
                                             kSecValueData as String: password as AnyObject,
                                             kSecClass as String: kSecClassGenericPassword
            ]
            let status = SecItemAdd(query as CFDictionary, nil )
            guard status != errSecDuplicateItem else{
                throw KeyChainError.duplicateEntry
            }
            guard status == errSecSuccess else {
                throw  KeyChainError.unknown(status)
            }
            print("saved")
        }

    
    func getFromChain(mail:String)
         -> Data? {
            let query: [String:AnyObject] = [kSecAttrAccount as String: mail as AnyObject,
                                             kSecReturnData as String: kCFBooleanTrue,
                                             kSecClass as String: kSecClassGenericPassword,
                                             kSecMatchLimit as String: kSecMatchLimitOne
            ]
            var result: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &result)
           
            print("Read Status \(status)")
            return result as? Data
        }
    
    

}
