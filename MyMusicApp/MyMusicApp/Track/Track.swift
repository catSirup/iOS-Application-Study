//
//  Track.swift
//  MyMusicApp
//
//  Created by 김태형 on 21/07/2020.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

struct Track {
    let title: String
    let artist: String
    let albumName: String
    let artwork: UIImage
    
    init(title: String, artist: String, albumName: String, artwork: UIImage) {
        self.title = title
        self.artist = artist
        self.albumName = albumName
        self.artwork = artwork
    }
}

struct Album {
    let title: String
    let tracks: [Track]
    
    var thumbnail: UIImage? {
        return tracks.first?.artwork
    }
    
    var artist: String? {
        return tracks.first?.artist
    }
    
    init(title:String, tracks: [Track]) {
        self.title = title
        self.tracks = tracks
    }
}
