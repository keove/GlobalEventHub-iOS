//
//  GlobalEventListener.swift
//  HobbyDo
//
//  Created by Çağrı Özdeş on 20.05.2019.
//  Copyright © 2019 HobbyDo. All rights reserved.
//

import Foundation

protocol GlobalEventListener {
    
    func onGlobalEvent(eventName:String,object:Any?,flag:Bool,code:Int)
}
