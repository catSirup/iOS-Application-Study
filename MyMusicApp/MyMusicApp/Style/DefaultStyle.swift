//
//  DefaultStyle.swift
//  MyMusicApp
//
//  Created by 김태형 on 21/07/2020.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

public enum DefaultStyle {
    public enum Colors {
        public static let tint: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor { traitCollction in
                    if traitCollction.userInterfaceStyle == .dark {
                        return .white
                    } else {
                        return .black
                    }
                }
            } else {
                return .black
            }
        }()
    }
}
