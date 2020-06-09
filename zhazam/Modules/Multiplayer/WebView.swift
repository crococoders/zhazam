//
//  WebView.swift
//  zhazam
//
//  Created by Adlet on 6/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import WebKit

class MultiplayerWebView: WKWebView {

    var accessoryView: UIView?

    override var inputAccessoryView: UIView? {
        // remove/replace the default accessory view
        return accessoryView
    }

}
