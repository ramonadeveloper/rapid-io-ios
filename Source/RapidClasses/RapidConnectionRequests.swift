//
//  RapidConnectionRequests.swift
//  Rapid
//
//  Created by Jan on 28/03/2017.
//  Copyright © 2017 Rapid.io. All rights reserved.
//

import Foundation

// MARK: Connect

/// Delegate for informing about connection request result
protocol RapidConnectionRequestDelegate: class {
    func connectionEstablished(_ request: RapidConnectionRequest)
    func connectingFailed(_ request: RapidConnectionRequest, error: RapidErrorInstance)
}

/// Connection request
class RapidConnectionRequest: RapidSerializable {
    
    let shouldSendOnReconnect = false
    
    /// Request should timeout even if `Rapid.timeout` is `nil`
    let alwaysTimeout = true
    
    /// ID associated with an abstract connection
    let connectionID: String
    
    /// Connection result delegate
    internal weak var delegate: RapidConnectionRequestDelegate?
    
    /// Timout delegate
    internal weak var timoutDelegate: RapidTimeoutRequestDelegate?
    
    internal var requestTimeoutTimer: Timer?
    
    init(connectionID: String, delegate: RapidConnectionRequestDelegate) {
        self.connectionID = connectionID
        self.delegate = delegate
    }
    
    // MARK: Rapid serializable
    func serialize(withIdentifiers identifiers: [AnyHashable : Any]) throws -> String {
        return try RapidSerialization.serialize(connection: self, withIdentifiers: identifiers)
    }
    
}

extension RapidConnectionRequest: RapidPriorityRequest {
    
    var priority: RapidRequestPriority {
        return .high
    }
}

extension RapidConnectionRequest: RapidTimeoutRequest {
    
    func eventAcknowledged(_ acknowledgement: RapidServerAcknowledgement) {
        invalidateTimer()
        
        DispatchQueue.main.async {
            self.delegate?.connectionEstablished(self)
        }
    }
    
    func eventFailed(withError error: RapidErrorInstance) {
        invalidateTimer()
        
        DispatchQueue.main.async {
            self.delegate?.connectingFailed(self, error: error)
        }
    }

}

// MARK: Disconnect

/// Disconnection request
class RapidDisconnectionRequest: RapidSerializable, RapidClientEvent {
    
    let shouldSendOnReconnect = false
    
    func serialize(withIdentifiers identifiers: [AnyHashable : Any]) throws -> String {
        return try RapidSerialization.serialize(disconnection: self)
    }
}

// MARK: No operation

/// Empty request for connection test
class RapidEmptyRequest: RapidSerializable, RapidClientEvent {
    
    let shouldSendOnReconnect = false
    
    func serialize(withIdentifiers identifiers: [AnyHashable : Any]) throws -> String {
        return try RapidSerialization.serialize(emptyRequest: self)
    }
}

// MARK: Authorization

class RapidAuthRequest: RapidClientRequest {
    
    let shouldSendOnReconnect = false
    
    let auth: RapidAuthorization
    let handler: RapidAuthHandler?
    
    init(token: String, handler: RapidAuthHandler? = nil) {
        self.auth = RapidAuthorization(token: token)
        self.handler = handler
    }
    
    func eventAcknowledged(_ acknowledgement: RapidServerAcknowledgement) {
        DispatchQueue.main.async {
            RapidLogger.log(message: "Rapid authorized", level: .info)
            
            self.handler?(.success(value: self.auth))
        }
    }
    
    func eventFailed(withError error: RapidErrorInstance) {
        DispatchQueue.main.async {
            RapidLogger.log(message: "Rapid authorization failed", level: .info)
            
            self.handler?(.failure(error: error.error))
        }
    }
}

extension RapidAuthRequest: RapidPriorityRequest {
    
    var priority: RapidRequestPriority {
        return .medium
    }
}

extension RapidAuthRequest: RapidSerializable {
    
    func serialize(withIdentifiers identifiers: [AnyHashable : Any]) throws -> String {
        return try RapidSerialization.serialize(authRequest: self, withIdentifiers: identifiers)
    }
}

class RapidDeauthRequest: RapidClientRequest {
    
    let shouldSendOnReconnect = false
    
    let handler: RapidDeuthHandler?
    
    init(handler: RapidDeuthHandler?) {
        self.handler = handler
    }
    
    func eventAcknowledged(_ acknowledgement: RapidServerAcknowledgement) {
        DispatchQueue.main.async {
            RapidLogger.log(message: "Rapid unauthorized", level: .info)
            
            self.handler?(.success(value: nil))
        }
    }
    
    func eventFailed(withError error: RapidErrorInstance) {
        DispatchQueue.main.async {
            RapidLogger.log(message: "Rapid unauthorization failed", level: .info)
            
            self.handler?(.failure(error: error.error))
        }
    }
}

extension RapidDeauthRequest: RapidSerializable {
    
    func serialize(withIdentifiers identifiers: [AnyHashable : Any]) throws -> String {
        return try RapidSerialization.serialize(authRequest: self, withIdentifiers: identifiers)
    }
}
