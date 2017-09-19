//
//  ViewController.swift
//  Swift-GCD
//
//  Created by YouXianMing on 2017/9/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // gcdQueueUse()
        // gcdGroupUse()
        // gcdSemaphoreUse()
    }
    
    private func gcdQueueUse() {
        
        // Excute in main queue.
        GCDQueue.mainQueue.excute {
            
            print("GCDQueue.mainQueue.excute")
        }
        
        // Excute in global queue.
        GCDQueue.globalQueue().excute {
            
            print("GCDQueue.globalQueue().excute")
        }
        
        // Excute in concurrent queue.
        GCDQueue.concurrentQueue().excute {
            
            GCDQueue.globalQueue().excuteAndWaitsUntilTheBlockCompletes {
                
                print("GCDQueue.globalQueue().excuteAndWaitsUntilTheBlockCompletes 01")
            }
            
            GCDQueue.globalQueue().excuteAndWaitsUntilTheBlockCompletes {
                
                print("GCDQueue.globalQueue().excuteAndWaitsUntilTheBlockCompletes 02")
            }
            
            GCDQueue.globalQueue().excuteAndWaitsUntilTheBlockCompletes {
                
                print("GCDQueue.globalQueue().excuteAndWaitsUntilTheBlockCompletes 03")
            }
            
            GCDQueue.globalQueue().excuteAndWaitsUntilTheBlockCompletes {
                
                print("GCDQueue.globalQueue().excuteAndWaitsUntilTheBlockCompletes 04")
            }
        }
        
        // GCDQueue excute in global queue after delay 2s.
        GCDQueue.globalQueue().excuteAfterDelaySeconds(2) {
            
            print("GCDQueue.globalQueue().excuteAfterDelaySeconds(2)")
        }
    }
    
    private func gcdGroupUse() {
        
        // Init group.
        let group = GCDGroup()
        
        // Excute in group.
        GCDQueue.globalQueue().excuteInGroup(group) {
            
            print("1")
        }
        
        // Excute in group.
        GCDQueue.globalQueue().excuteInGroup(group) {
            
            print("2")
        }
        
        // Excute in group.
        GCDQueue.globalQueue().excuteInGroup(group) {
            
            print("3")
        }
        
        // Excute in group.
        GCDQueue.globalQueue().excuteInGroup(group) {
            
            print("4")
        }
        
        // Notify in queue by group.
        group.notifyInQueue(GCDQueue.mainQueue) {
            
            print("Done")
        }
    }
    
    private func gcdSemaphoreUse() {
        
        // Init semaphore.
        let semaphore = GCDSemaphore()
        
        print("start.")
        
        GCDQueue.globalQueue().excute {
            
            semaphore.waitForever()
            print("Done 1")
            
            semaphore.waitForever()
            print("Done 2")
        }
        
        GCDQueue.globalQueue().excuteAfterDelaySeconds(3) {
            
            semaphore.signal()
        }
        
        GCDQueue.globalQueue().excuteAfterDelaySeconds(4) {
            
            semaphore.signal()
        }
    }
}

