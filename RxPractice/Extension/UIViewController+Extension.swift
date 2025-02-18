//
//  UIViewController+Extension.swift
//  RxPractice
//
//  Created by 권우석 on 2/18/25.
//
import UIKit



extension UIViewController {
    func showAlert(message: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "취소", style: .default) { action in
            completionHandler()
        }
        
        alert.addAction(button)
        
        present(alert, animated: true)
    }
    
    
    
}



