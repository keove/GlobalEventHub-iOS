//
//  GlobalEventAppDelegate.swift
//  HobbyDo
//
//  Created by Çağrı Özdeş on 20.05.2019.
//  Copyright © 2019 HobbyDo. All rights reserved.
//

import Foundation
import UIKit

public class GlobalEventHub: UIResponder {
    
    public var map : NSMutableDictionary = NSMutableDictionary()
    
    
    public func addListener(listener:GlobalEventListener,eventName:String) {
        
        var listeners : Array<GlobalEventListener>! = nil
        
        listeners = map.object(forKey: eventName) as? Array<GlobalEventListener>
        
        
        if(listeners != nil) {
            
            var exists : Bool = false
            
            for i in 0..<listeners.count {
                let l : GlobalEventListener = listeners[i]
                let lo : NSObject = (l as? NSObject)!
                let listenerO : NSObject = (listener as? NSObject)!
                
                if lo === listenerO {
                    exists = true
                    break
                }
            }
            
            if(!exists) {
                listeners.append(listener)
            }
            
            map.setValue(listeners, forKey: eventName)
        }
        else {
            var newListeners : Array<GlobalEventListener> = Array<GlobalEventListener>()
            newListeners.append(listener)
            
            map.setValue(newListeners, forKey: eventName)
            
        }
    }
    
    public func removeListener(listener:GlobalEventListener,eventName:String) {
        var listeners : Array<GlobalEventListener>! = nil
        
        listeners = map.object(forKey: eventName) as? Array<GlobalEventListener>
        
        if(listeners != nil) {
            var removeIndex : Int = -1
            
            for i in 0..<listeners.count {
                let l : GlobalEventListener = listeners[i]
                let lo : NSObject = (l as? NSObject)!
                let listenerO : NSObject = (listener as? NSObject)!
                
                if lo === listenerO {
                    removeIndex = i
                }
            }
            
            if(removeIndex != -1) {
                listeners.remove(at: removeIndex)
                map.setValue(listeners, forKey: eventName)
            }
        }
    }
    
    public func clearListeners(eventName:String) {
        var newListeners : Array<GlobalEventListener> = Array<GlobalEventListener>()
        map.setValue(newListeners, forKey: eventName)
    }
    
    public func overrideListeners(listener:GlobalEventListener,eventName:String) {
        clearListeners(eventName: eventName)
        addListener(listener: listener, eventName: eventName)
    }
    
    public func fireEvent(eventName:String,object:Any?,flag:Bool,code:Int) {
        var listeners : Array<GlobalEventListener>! = nil
        
        listeners = map.object(forKey: eventName) as? Array<GlobalEventListener>
        
        if listeners == nil {
            return
        }
        
        for i in 0..<listeners.count {
            let listener : GlobalEventListener = listeners[i]
            listener.onGlobalEvent(eventName: eventName, object: object, flag: flag, code: code)
        }
    }
    
    
    public static func fireEvent(eventName:String,object:Any?,flag:Bool,code:Int) {
        let hub : GlobalEventHub! = UIApplication.shared.delegate as? GlobalEventHub
        hub?.fireEvent(eventName: eventName, object: object, flag: flag, code: code)
    }
    
    public static func addListener(listener:GlobalEventListener,eventName:String) {
        let hub : GlobalEventHub! = UIApplication.shared.delegate as? GlobalEventHub
        hub?.addListener(listener: listener, eventName: eventName)
    }
    
    public static func removeListener(listener:GlobalEventListener,eventName:String) {
        let hub : GlobalEventHub! = UIApplication.shared.delegate as? GlobalEventHub
        hub?.removeListener(listener: listener, eventName: eventName)
    }
    
    public static func clearListeners(eventName:String) {
        let hub : GlobalEventHub! = UIApplication.shared.delegate as? GlobalEventHub
        hub.clearListeners(eventName: eventName)
    }
    
    
    public static func overrideListeners(listener:GlobalEventListener,eventName:String) {
        let hub : GlobalEventHub! = UIApplication.shared.delegate as? GlobalEventHub
        hub?.overrideListeners(listener: listener, eventName: eventName)
    }
    
    
    
}
