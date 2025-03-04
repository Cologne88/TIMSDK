//
//  RoomMainViewController.swift
//  TUIRoomKit
//
//  Created by aby on 2022/12/27.
//  Copyright © 2022 Tencent. All rights reserved.
//

import UIKit
#if TXLiteAVSDK_TRTC
import TXLiteAVSDK_TRTC
#elseif TXLiteAVSDK_Professional
import TXLiteAVSDK_Professional
#endif

protocol RoomMainViewModelFactory {
    func makeRoomMainViewModel() -> RoomMainViewModel
}

class RoomMainViewController: UIViewController {
    let rootView: RoomMainRootView
    let viewModel: RoomMainViewModel
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    init(roomMainViewModelFactory: RoomMainViewModelFactory) {
        self.viewModel = roomMainViewModelFactory.makeRoomMainViewModel()
        self.rootView = RoomMainRootView(viewModel: viewModel, viewFactory: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let isLandscape = size.width > size.height
        let param = TRTCVideoEncParam()
        if isLandscape {
            param.resMode = .landscape
        } else {
            param.resMode = .portrait
        }
        EngineManager.createInstance().roomEngine.getTRTCCloud().setVideoEncoderParam(param)
        rootView.updateRootViewOrientation(isLandscape: isLandscape)
    }
    
    deinit {
        debugPrint("deinit \(self)")
    }
}
