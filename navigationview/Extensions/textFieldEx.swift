//
//  textFieldEx.swift
//  vcb_client
//
//  Created by Billy Cole on 5/5/23.
//

import UIKit

extension UITextField {
  /*
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
       
        next?.touchesBegan(touches, with: event)
       print("UIView touchesBegan")
     //   hideKeyboardWhenTappedAround()
        //view.endEditing(true)
        
    }
 */
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
       
        next?.touchesMoved(touches, with: event)
       
        print("UIButton touchesMoved")
       
    }
   
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
       
        next?.touchesEnded(touches, with: event)
       
        print("UIView touchesEnded")
         
        // Piston_Count.endEditing(true)
    }
   
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
       
        next?.touchesCancelled(touches, with: event)
       
        print("UIButton touchesCancelled")
       
    }
   
    open override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        super.touchesEstimatedPropertiesUpdated(touches)
       
        next?.touchesEstimatedPropertiesUpdated(touches)
       
        print("UIButton touchesEstimatedPropertiesUpdated")
       
    }
}

