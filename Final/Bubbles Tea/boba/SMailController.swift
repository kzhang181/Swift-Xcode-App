//
//  SMailController.swift
//  boba
//
//  Created by Kenneth Zhang on 3/1/24.
//

import MessageUI

class SMailComposerViewController: MFMailComposeViewController {
    init(recipient: [String]?, subject: String = "", email: String = "", message: String = "", messageBodyIsHTML: Bool = false){
        super.init(nibName: nil, bundle: nil)
        setToRecipients(recipient)
        setSubject(subject)
        setMessageBody(message, isHTML: messageBodyIsHTML)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("Coder not implemented")
    }
}

