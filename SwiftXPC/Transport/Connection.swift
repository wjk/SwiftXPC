//
//  Connection.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import dispatch
import XPC

public final class XPCConnection : XPCObject {
    public class func createAnonymousConnection() -> XPCConnection {
        return XPCConnection(nativePointer: xpc_connection_create(nil, nil))
    }
    
    public convenience init(name: String) {
        self.init(name: name, queue: nil)
    }
    
    public convenience init(name: String, queue: dispatch_queue_t?) {
        let namePtr = name.cStringUsingEncoding(NSUTF8StringEncoding)
        self.init(nativePointer: xpc_connection_create(namePtr!, queue))
    }
    
    public convenience init(endpoint: XPCEndpoint) {
        self.init(nativePointer: xpc_connection_create_from_endpoint(endpoint.objectPointer))
    }
    
    public func setTargetQueue(queue: dispatch_queue_t?) {
        xpc_connection_set_target_queue(objectPointer, queue)
    }
    
    public func setHandler(block: (XPCObject) -> ()) {
        xpc_connection_set_event_handler(objectPointer) {
            ptr in
            block(XPCObject(nativePointer: ptr))
        }
    }
    
    public func suspend() {
        xpc_connection_suspend(objectPointer)
    }
    
    public func resume() {
        xpc_connection_resume(objectPointer)
    }
    
    public func sendMessage(message: XPCDictionary) {
        xpc_connection_send_message(objectPointer, message.objectPointer)
    }
    
    public func sendMessage(message: XPCDictionary, replyHandler: (XPCObject) -> ()) {
        xpc_connection_send_message_with_reply(objectPointer, message.objectPointer, nil) {
            obj in
            replyHandler(XPCObject(nativePointer: obj))
        }
    }
    
    public func sendBarrier(barrier: () -> ()) {
        xpc_connection_send_barrier(objectPointer) {
            barrier()
        }
    }
    
    public func cancel() {
        xpc_connection_cancel(objectPointer)
    }
    
    // MARK: Properties
    
    public var name: String? {
    get {
        let ptr = xpc_connection_get_name(objectPointer)
        if ptr != nil {
            return String.fromCString(ptr)
        } else {
            return nil
        }
    }
    }
    
    public var effectiveUserIdOfRemotePeer : Int {
    get {
        return Int(xpc_connection_get_euid(objectPointer))
    }
    }
    
    public var effectiveGroupIdOfRemotePeer : Int {
    get {
        return Int(xpc_connection_get_egid(objectPointer))
    }
    }
    
    public var processIdOfRemotePeer : Int {
    get {
        return Int(xpc_connection_get_pid(objectPointer))
    }
    }
    
    public var auditSessionIdOfRemotePeer : Int {
    get {
        return Int(xpc_connection_get_asid(objectPointer))
    }
    }
}

extension XPCDictionary {
    public var remoteConnection: XPCConnection {
    get {
        return XPCConnection(nativePointer: xpc_dictionary_get_remote_connection(objectPointer))
    }
    }
    
    // Note: Due to the underlying implementation, this method will only work once.
    // Subsequent calls will return nil. In addition, if the receiver does not have
    // a reply context, this method will always return nil.
    public func createReply() -> XPCDictionary? {
        let ptr = xpc_dictionary_create_reply(objectPointer)
        if ptr == nil { return nil }
        
        return XPCDictionary(nativePointer: ptr)
    }
}
