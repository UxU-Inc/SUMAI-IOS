//
//  EmailHelper.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/19.
//

import Foundation
import MessageUI

class EmailHelper: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailHelper()
    private override init() {
        //
    }
    
    func sendEmail(subject:String, body:String, to:String){
        if !MFMailComposeViewController.canSendMail() {
            let alert = UIAlertController(title: "메일 계정을 찾을 수 없습니다.", message: "메일 계정을 설정해주세요.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                EmailHelper.getRootViewController()?.dismiss(animated: true, completion: nil)
            }
            let settingAction = UIAlertAction(title: "설정하기", style: .default) { _ in
                EmailHelper.getRootViewController()?.dismiss(animated: true, completion: nil)
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            }
            
            alert.addAction(okAction)
            alert.addAction(settingAction)
            
            EmailHelper.getRootViewController()?.present(alert, animated: true)
            return //EXIT
        }
        
        let picker = MFMailComposeViewController()
        
        picker.setSubject(subject)
        picker.setMessageBody(body, isHTML: true)
        picker.setToRecipients([to])
        picker.mailComposeDelegate = self
        
        EmailHelper.getRootViewController()?.present(picker, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailHelper.getRootViewController()?.dismiss(animated: true, completion: nil)
    }
    
    static func getRootViewController() -> UIViewController? {
        //        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController
        
        // OR If you use SwiftUI 2.0 based WindowGroup try this one
        UIApplication.shared.windows.first?.rootViewController
    }
}
