//
//  StoryboardHelper.swift
//  CALearn
//
//  Created by 吴杰健 on 16/7/13.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

import Foundation
import UIKit

class StoryboardHelper {
    
    class func Main() -> (String -> UIViewController) {
        return vcBlockWithStoryboardId("Main")
    }
 
    private class func vcBlockWithStoryboardId(id: String) -> (String -> UIViewController) {
        return { vcId in
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(vcId)
        }

    }
    
}