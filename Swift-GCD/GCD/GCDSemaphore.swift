//
//  GCDSemaphore.swift
//  Swift-GCD
//
//  Created by YouXianMing on 2017/9/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

import UIKit

class GCDSemaphore {

    private let dispatchSemaphore : DispatchSemaphore
    
    init(initialSignal : Int = 0) {
        
        self.dispatchSemaphore = DispatchSemaphore(value: initialSignal)
    }
    
    // MARK: Singal
    
    func signal() {
        
        self.dispatchSemaphore.signal()
    }
    
    // MARK: Wait
    
    func waitForever() {
        
        self.dispatchSemaphore.wait()
    }
    
    func waitForSeconds(_ seconds : Int) -> DispatchTimeoutResult {
        
        return self.dispatchSemaphore.wait(timeout: DispatchTime.now() + .seconds(seconds))
    }
    
    func waitForMilliseconds(_ milliseconds : Int) -> DispatchTimeoutResult {
        
        return self.dispatchSemaphore.wait(timeout: DispatchTime.now() + .milliseconds(milliseconds))
    }
}
