//
//  AuthManager.swift
//  Spotify
//
//  Created by Akash G Krishnan on 21/09/21.
//

import Foundation


final class AuthManager {
    
    struct Constants {
        static let ClientID  = "2c292812ac44434ab2d9bc372339a0c1"
        static let ClientSecret  = "fa4dd2f50a3c48bc8dafdd2ab3544610"
    }
    

    static let shared = AuthManager()
    
    private init() {}
    var isSignedIn : Bool {
        return false
    }
    
    private var accessToken : String? {
        return nil
    }
    
    private var refreshToken : String? {
        return nil
    }
    
    private var tokenExpirationDate : Date? {
        return nil
    }
    
    private var shouldRefreshToken : Bool {
        return false
    }

}
