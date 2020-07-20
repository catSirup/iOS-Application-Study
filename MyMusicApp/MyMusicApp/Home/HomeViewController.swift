//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by 김태형 on 20/07/2020.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let trackManager = TrackManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension HomeViewController: UICollectionViewDataSource {
    // 몇 개 보여줄 것인지.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 트랙 갯수만큼 카운트.
        return trackManager.tracks.count
    }
    
    // 셀 어떻게 표시할 지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollectionViewCell", for: indexPath) as? TrackCollectionViewCell else { return UICollectionViewCell() }
        
        let track = trackManager.track(at: indexPath.item)
        cell.updateUI(item: track)
        
        return cell
    }
    
    // 헤더뷰 표시
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let item = trackManager.todaysTrack else { return UICollectionReusableView() }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else { return UICollectionReusableView() }
            
            header.update(with: item)
            header.tapHandler = { item -> Void in
                // Player 스토리보드를 찾아 PlayerVC 가져오기.
                let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
                guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
                
                playerVC.simplePlayer.replaceCurrentItem(with: item)
                self.present(playerVC, animated: true, completion: nil)
            }
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playerStoryBoard = UIStoryboard.init(name: "Player", bundle: nil)
        guard let playerVC = playerStoryBoard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
        
        let item = trackManager.tracks[indexPath.item]
        playerVC.simplePlayer.replaceCurrentItem(with: item)
        present(playerVC, animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing: CGFloat = 20
        let margine: CGFloat = 20
        let width = (collectionView.bounds.width - itemSpacing - margine * 2) / 2
        let height = width + 60
        
        return CGSize(width: width, height: height)
    }
}


