//
//  TrackCollectionHeaderView.swift
//  MyMusicApp
//
//  Created by 김태형 on 21/07/2020.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit
import AVFoundation

class TrackCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: AVPlayerItem?
    var tapHandler: ((AVPlayerItem) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = 4
    }
    
    func update(with item: AVPlayerItem) {
        self.item = item
        guard let track = item.convertToTrack() else { return }
        
        self.thumbnailImageView.image = track.artwork
        self.descriptionLabel.text = "Today's Pick is \(track.artist)'s album - \(track.albumName), Let's Listen."
    }
    
    @IBAction func cardTapped(_ sender: Any) {
        // todays Item이 있는지 확인.
        guard let todaysItem = item else { return }
        tapHandler?(todaysItem)
    }
}
