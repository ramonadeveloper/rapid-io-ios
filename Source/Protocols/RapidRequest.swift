//
//  RapidRequest.swift
//  Rapid
//
//  Created by Jan Schwarz on 17/03/2017.
//  Copyright © 2017 Rapid.io. All rights reserved.
//

import Foundation

/// Protocol ensuring serialization to JSON string
protocol RapidSerializable {
    func serialize(withIdentifiers identifiers: [AnyHashable: Any]) throws -> String
}

/// Protocol describing events that can be sent to the server
protocol RapidSocketEvent {}

/// Protocol describing socket events that wait for a server response
protocol RapidRequest: class, RapidSocketEvent {
    func eventAcknowledged(_ acknowledgement: RapidSocketAcknowledgement)
    func eventFailed(withError error: RapidErrorInstance)
}

/// Protocol describing socket events that inform server and do not wait for a server response
protocol RapidClientEvent: RapidSocketEvent {}

/// `RapidRequest` that implements timeout
protocol RapidTimeoutRequest: RapidRequest {
    /// Request should timeout even if `Rapid.timeout` is `nil`
    var alwaysTimeout: Bool { get }
    
    /// Request was enqued an timeout countdown should begin
    ///
    /// - Parameters:
    ///   - timeout: Number of seconds before timeout occurs
    ///   - delegate: Timeout delegate
    func requestSent(withTimeout timeout: TimeInterval, delegate: RapidTimeoutRequestDelegate)
    
    /// Stop countdown because request is no more valid
    func invalidateTimer()
}

/// Delegate for informing about timout
protocol RapidTimeoutRequestDelegate: class {
    func requestTimeout(_ request: RapidTimeoutRequest)
}