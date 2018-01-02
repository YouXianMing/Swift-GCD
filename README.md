# Swift-GCD-Program

> 需要Objective-C版本GCD的请移步-[Objective-C版本GCD](https://github.com/YouXianMing/GCD-Program)

```
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
    }
    
    private func gcdQueueUse() {
        
        // Excute in main queue.
        GCDQueue.Main.excute {
            
            print("GCDQueue.Main.excute")
        }
        
        // Excute in global queue.
        GCDQueue.Global().excute {
            
            print("GCDQueue.Global().excute")
        }
        
        // Excute in concurrent queue.
        GCDQueue.Concurrent().excute {
            
            GCDQueue.Global().excuteAndWaitsUntilTheBlockCompletes {
                
                print("🔥 01")
            }
            
            GCDQueue.Global().excuteAndWaitsUntilTheBlockCompletes {
                
                print("🔥 02")
            }
            
            GCDQueue.Global().excuteAndWaitsUntilTheBlockCompletes {
                
                print("🔥 03")
            }
            
            GCDQueue.Global().excuteAndWaitsUntilTheBlockCompletes {
                
                print("🔥 04")
            }
        }
        
        // GCDQueue excute in global queue after delay 2s.
        GCDQueue.Global().excuteAfterDelay(2) {
            
            print("GCDQueue.Global().excuteAfterDelay 2 Seconds")
        }
    }
    
    private func gcdSerialQueueUse() {
        
        let serialQueue = GCDQueue.Serial()
        
        serialQueue.excute {
            
            for i in 0..<10 {
                
                print("🔥" + String(i))
            }
        }
        
        serialQueue.excute {
            
            for i in 0..<10 {
                
                print("❄️" + String(i))
            }
        }
    }
    
    private func gcdConcurrentQueueUse() {
        
        let concurrentQueue = GCDQueue.Concurrent()
        
        concurrentQueue.excute {
            
            for i in 0..<10 {
                
                print("🔥" + String(i))
            }
        }
        
        concurrentQueue.excute {
            
            for i in 0..<10 {
                
                print("❄️" + String(i))
            }
        }
    }
    
    private func gcdGroupNormalUse() {
        
        // Init group.
        let group = GCDGroup()
        
        // Excute in group.
        GCDQueue.Global().excuteInGroup(group) {
            
            print("Do work A.")
        }
        
        // Excute in group.
        GCDQueue.Global().excuteInGroup(group) {
            
            print("Do work B.")
        }
        
        // Excute in group.
        GCDQueue.Global().excuteInGroup(group) {
            
            print("Do work C.")
        }
        
        // Excute in group.
        GCDQueue.Global().excuteInGroup(group) {
            
            print("Do work D.")
        }
        
        // Notify in queue by group.
        group.notifyIn(GCDQueue.Main) {
            
            print("Finish.")
        }
    }
    
    private func gcdGroupEnterAndLeaveUse() {
        
        // Init group.
        let group = GCDGroup()
        
        group.enter()
        group.enter()
        group.enter()
        
        print("Start.")
        
        GCDQueue.ExcuteInGlobalAfterDelay(3) {
            
            print("Do work A.")
            group.leave()
        }
        
        GCDQueue.ExcuteInGlobalAfterDelay(4) {
            
            print("Do work B.")
            group.leave()
        }
        
        GCDQueue.ExcuteInGlobalAfterDelay(2) {
            
            print("Do work C.")
            group.leave()
        }
        
        // Notify in queue by group.
        group.notifyIn(GCDQueue.Main) {
            
            print("Finish.")
        }
    }
    
    private func gcdGroupWaitUse() {
        
        // Init group.
        let group = GCDGroup()
        
        group.enter()
        group.enter()
        
        print("Start.")
        
        GCDQueue.ExcuteInGlobalAfterDelay(3) {
            
            print("Do work A.")
            group.leave()
        }
        
        GCDQueue.ExcuteInGlobalAfterDelay(5) {
            
            print("Do work B.")
            group.leave()
        }
        
        let waitSeconds = arc4random() % 2 == 0 ? 4 : 6
        print("wait \(waitSeconds) seconds.")
        print(group.waitForSeconds(seconds: Float(waitSeconds)))
        print("wait finish.")
        
        // Notify in queue by group.
        group.notifyIn(GCDQueue.Main) {
            
            print("Finish.")
        }
    }

    
    private func gcdSemaphoreWaitForeverUse() {
        
        // Init semaphore.
        let semaphore = GCDSemaphore()
        
        print("start.")
        
        GCDQueue.Global().excute {
            
            semaphore.wait()
            print("Done 1")
            
            semaphore.wait()
            print("Done 2")
        }
        
        GCDQueue.Global().excuteAfterDelay(3) {
            
            semaphore.signal()
        }
        
        GCDQueue.Global().excuteAfterDelay(4) {
            
            semaphore.signal()
        }
    }
    
    private func gcdSemaphoreWaitSecondsUse() {
        
        // Init semaphore.
        let semaphore = GCDSemaphore()
        
        print("start.")
        
        GCDQueue.Global().excute {
            
            _ = semaphore.waitForSeconds(3)
            print("Done")
        }
        
        GCDQueue.Global().excuteAfterDelay(5) {
            
            print("signal")
            semaphore.signal()
        }
    }
    
    private func gcdTimerUse() {
        
        let gcdTimer = GCDTimer(in: GCDQueue.Global(), delay: 2, interval: 3)
        
        print("Start.")
        
        var count : Int = 0
        gcdTimer.setTimerEventHandler {_ in
            
            count += 1
            
            print("\(count)")
            
            if count == 5 {
                
                print("suspend")
                gcdTimer.suspend()
                
                GCDQueue.ExcuteInGlobalAfterDelay(2.0, {
                    
                    print("start")
                    gcdTimer.start()
                })
            }
            
            if count >= 10 {
                
                gcdTimer.destroy()
            }
        }
        
        gcdTimer.setDestroyEventHandler {
            
            print("Destroy event.")
        }
        
        gcdTimer.start()
    }
}
```

