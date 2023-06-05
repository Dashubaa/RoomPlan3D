/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view controller for the app's first screen that explains what to do.
*/

import UIKit
import AVFoundation
import AVKit
class OnboardingViewController: UIViewController {
    @IBOutlet var existingScanView: UIView!
    @IBOutlet var scan: UIButton!
    @IBOutlet var roomScanningOutlet: UILabel!
    @IBOutlet var GalleryOutlet: UIButton!
    @IBOutlet var videoPlayer: UIView!
    
    var vvideoPlayer:AVPlayer?
       var videoPlayerLayer:AVPlayerLayer?
       var playerLooper:NSObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        //playVideo()
    }
    func playVideo(){
               let bundlePath = Bundle.main.path(forResource: "test", ofType: "MP4")
               guard bundlePath != nil else {
                   return
               }
               
               let url = URL(fileURLWithPath: bundlePath!)
            
               let item = AVPlayerItem(url: url)
             
               vvideoPlayer = AVQueuePlayer(items: [item])
         
               playerLooper = AVPlayerLooper(player: vvideoPlayer! as! AVQueuePlayer, templateItem: item)
               
           
               videoPlayerLayer = AVPlayerLayer(player: vvideoPlayer)
               videoPlayerLayer?.player?.volume = 0
          
               videoPlayerLayer!.frame = view.bounds
               videoPlayerLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
               view.layer.addSublayer(videoPlayerLayer!)
               
               vvideoPlayer?.play()
        
        videoPlayer.bringSubviewToFront(scan)
        videoPlayer.bringSubviewToFront(roomScanningOutlet)
        videoPlayer.bringSubviewToFront(GalleryOutlet)
    }
    @IBAction func startScan(_ sender: UIButton) {
        if let viewController = self.storyboard?.instantiateViewController(
            withIdentifier: "RoomCaptureViewNavigationController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }
}
