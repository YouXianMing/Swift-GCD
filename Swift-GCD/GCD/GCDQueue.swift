//
//  GCDQueue.swift
//  Swift-GCD
//
//  Created by YouXianMing on 2017/9/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

import UIKit

class GCDQueue {
    
    enum GCDQueuePriority {
        
        case background, utility, `default`, userInitiated, userInteractive, unspecified
    }
    
    public let dispatchQueue : DispatchQueue
    
    private init(dispatchQueue : DispatchQueue) {
        
        self.dispatchQueue = dispatchQueue
    }
    
    // MARK: globalQueue & mainQueue
    
    public class var mainQueue : GCDQueue {
        
        return GCDQueue.init(dispatchQueue: DispatchQueue.main)
    }
    
    public class func globalQueue(_ priority : GCDQueuePriority = .default) -> GCDQueue {
        
        var qos: DispatchQoS.QoSClass
        
        switch priority {
            
        case GCDQueuePriority.background:
            qos = .background
            break
            
        case GCDQueuePriority.utility:
            qos = .utility
            break
            
        case GCDQueuePriority.`default`:
            qos = .default
            break
            
        case GCDQueuePriority.userInitiated:
            qos = .userInitiated
            break
            
        case GCDQueuePriority.userInteractive:
            qos = .userInteractive
            break

        case GCDQueuePriority.unspecified:
            qos = .unspecified
            break
        }
        
        return GCDQueue.init(dispatchQueue: DispatchQueue.global(qos: qos))
    }
    
    // MARK: concurrentQueue & serialQueue
    
    public class func concurrentQueue(_ label : String = "", _ priority : GCDQueuePriority = .default) -> GCDQueue {
        
        var qos: DispatchQoS
        
        switch priority {
            
        case GCDQueuePriority.background:
            qos = .background
            break
            
        case GCDQueuePriority.utility:
            qos = .utility
            break
            
        case GCDQueuePriority.`default`:
            qos = .default
            break
            
        case GCDQueuePriority.userInitiated:
            qos = .userInitiated
            break
            
        case GCDQueuePriority.userInteractive:
            qos = .userInteractive
            break
            
        case GCDQueuePriority.unspecified:
            qos = .unspecified
            break
        }
        
        return GCDQueue.init(dispatchQueue: DispatchQueue(label: label, qos: qos, attributes: .concurrent))
    }
    
    public class func serialQueue(_ label : String = "", _ priority : GCDQueuePriority = .default) -> GCDQueue {
        
        var qos: DispatchQoS
        
        switch priority {
            
        case GCDQueuePriority.background:
            qos = .background
            break
            
        case GCDQueuePriority.utility:
            qos = .utility
            break
            
        case GCDQueuePriority.`default`:
            qos = .default
            break
            
        case GCDQueuePriority.userInitiated:
            qos = .userInitiated
            break
            
        case GCDQueuePriority.userInteractive:
            qos = .userInteractive
            break
            
        case GCDQueuePriority.unspecified:
            qos = .unspecified
            break
        }
        
        return GCDQueue.init(dispatchQueue: DispatchQueue(label: label, qos: qos))
    }
    
    // MARK: Excute
    
    public func excute(_ excute : @escaping ()-> Void) {
        
        dispatchQueue.async(execute: excute)
    }
    
    public func excuteAfterDelayMilliseconds(_ milliseconds : Int, _ excute : @escaping ()-> Void) {
        
        dispatchQueue.asyncAfter(deadline: DispatchTime.now() + .milliseconds(milliseconds), execute: excute)
    }
    
    public func excuteAfterDelaySeconds(_ seconds : Int, _ excute : @escaping ()-> Void) {
        
        dispatchQueue.asyncAfter(deadline: DispatchTime.now() + .seconds(seconds), execute: excute)
    }
    
    public func excuteAndWaitsUntilTheBlockCompletes(_ excute : @escaping ()-> Void) {
        
        dispatchQueue.sync(execute: excute)
    }
    
    public func excuteInGroup(_ group : GCDGroup, _ excute : @escaping ()-> Void) {
        
        group.enter()
        dispatchQueue.async(group: group.dispatchGroup) {
            
            excute()
            group.leave()
        }
    }
}
