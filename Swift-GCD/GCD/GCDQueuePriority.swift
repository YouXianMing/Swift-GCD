//
//  GCDQueuePriority.swift
//  Swift-GCD
//
//  Created by YouXianMing on 2017/9/20.
//  Copyright © 2017年 TechCode. All rights reserved.
//

import UIKit

enum GCDQueuePriority {
    
    case BackgroundPriority       // DISPATCH_QUEUE_PRIORITY_BACKGROUND
    case LowPriority              // DISPATCH_QUEUE_PRIORITY_LOW
    case DefaultPriority          // DISPATCH_QUEUE_PRIORITY_DEFAULT
    case HighPriority             // DISPATCH_QUEUE_PRIORITY_HIGH
    
    case userInteractive
    case unspecified
    
    func getDispatchQoSClass() -> DispatchQoS.QoSClass {
        
        var qos: DispatchQoS.QoSClass
        
        switch self {
            
        case GCDQueuePriority.BackgroundPriority:
            qos = .background
            break
            
        case GCDQueuePriority.LowPriority:
            qos = .utility
            break
            
        case GCDQueuePriority.DefaultPriority:
            qos = .default
            break
            
        case GCDQueuePriority.HighPriority:
            qos = .userInitiated
            break
            
        case GCDQueuePriority.userInteractive:
            qos = .userInteractive
            break
            
        case GCDQueuePriority.unspecified:
            qos = .unspecified
            break
        }
        
        return qos
    }
    
    func getDispatchQoS() -> DispatchQoS {
        
        var qos: DispatchQoS
        
        switch self {
            
        case GCDQueuePriority.BackgroundPriority:
            qos = .background
            break
            
        case GCDQueuePriority.LowPriority:
            qos = .utility
            break
            
        case GCDQueuePriority.DefaultPriority:
            qos = .default
            break
            
        case GCDQueuePriority.HighPriority:
            qos = .userInitiated
            break
            
        case GCDQueuePriority.userInteractive:
            qos = .userInteractive
            break
            
        case GCDQueuePriority.unspecified:
            qos = .unspecified
            break
        }
        
        return qos
    }
}
