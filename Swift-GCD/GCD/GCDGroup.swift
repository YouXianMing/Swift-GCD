//
//  GCDGroup.swift
//  Swift-GCD
//
//  Created by YouXianMing on 2017/9/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

import UIKit

class GCDGroup {

    public let dispatchGroup : DispatchGroup
    
    init() {
        
        self.dispatchGroup = DispatchGroup()
    }
    
    func notifyInQueue(_ queue : GCDQueue, execute: @escaping () -> Void) {
        
        self.dispatchGroup.notify(queue: queue.dispatchQueue, execute: execute)
    }
    
    func enter() {
        
        self.dispatchGroup.enter()
    }
    
    func leave() {
        
        self.dispatchGroup.leave()
    }
    
    func wait() {
        
        // todo
    }
}
