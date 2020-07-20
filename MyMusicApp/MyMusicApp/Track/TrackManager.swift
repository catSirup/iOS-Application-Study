//
//  TrackManager.swift
//  MyMusicApp
//
//  Created by 김태형 on 21/07/2020.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit
import AVFoundation

class TrackManager {
    static let shared = TrackManager()
    
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todaysTrack: AVPlayerItem?
    
    init() {
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todaysTrack = self.tracks.randomElement()
    }
    
    func loadTracks() -> [AVPlayerItem] {
        // ".mp3" 인 파일들을 가져온다.
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        
        // 가져온 파일들을 AVPlayerItem으로 변환해서 저장.
        let items = urls.map { url in
            return AVPlayerItem(url: url)
        }
        
        return items
    }
    
    func track(at index: Int) -> Track? {
        let playerItem = tracks[index]
        return playerItem.convertToTrack()
    }
    
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        // nil 제거 후 AVPlayerItem -> Track으로 변경해서 저장.
        let trackList: [Track] = tracks.compactMap { $0.convertToTrack() }
        
        // trackList들을 albumName으로 묶음.
        let albumDict = Dictionary(grouping: trackList, by: { (track) in
            track.albumName
        })
        var albums: [Album] = []
        for (key, value) in albumDict {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        
        return albums
    }
    
    func loadOtherTodayTrack() {
        self.todaysTrack = self.tracks.randomElement()
    }
}
