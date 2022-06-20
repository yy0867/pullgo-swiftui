//
//  KeychainTokenManager.swift
//  TokenKit
//
//  Created by 김세영 on 2022/06/20.
//

import Foundation

public final class KeychainTokenManager {
    
    private let keychainAccount: String
    
    public init(account: String = "com.Harry.Pullgo") {
        self.keychainAccount = account
    }
    
    public func readToken() -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: keychainAccount,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true,
        ]
        
        var item: CFTypeRef?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            printDescription(of: status)
            return nil
        }
        
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecValueData as String] as? Data,
              let token = String(data: data, encoding: .utf8) else {
            Log.print("Extract token from item failed.")
            return nil
        }
        
        return token
    }
    
    public func saveOrUpdate(token: String) -> Bool {
        let tokenData = token.data(using: .utf8)!
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: keychainAccount,
            kSecValueData: tokenData,
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return updateToken(tokenData)
        } else {
            printDescription(of: status)
            return false
        }
    }
    
    private func updateToken(_ tokenData: Data) -> Bool {
        let searchQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: keychainAccount,
        ]
        let updateQuery: [CFString: Any] = [kSecValueData: tokenData]
        
        let status = SecItemUpdate(searchQuery as CFDictionary, updateQuery as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else {
            printDescription(of: status)
            return false
        }
    }
    
    public func delete() -> Bool {
        let searchQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: keychainAccount,
        ]
        
        let status = SecItemDelete(searchQuery as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else {
            printDescription(of: status)
            return false
        }
    }
    
    private func printDescription(of status: OSStatus) {
        if let description = SecCopyErrorMessageString(status, nil) {
            Log.print(description as String)
        }
    }
}
