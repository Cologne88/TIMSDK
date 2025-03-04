//
//  InviteUserButton.swift
//  TUICallKit
//
//  Created by vincepzhang on 2023/2/15.
//

import Foundation
import TUICore

class InviteUserButton: UIView {
    
    let viewModel = InviteUserButtonViewModel()
    let mediaTypeObserver = Observer()
    let inviteUserButton: UIButton = {
    let inviteUserButton = UIButton(type: .system)
    return inviteUserButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateImage()
        registerObserveState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        viewModel.mediaType.removeObserver(mediaTypeObserver)
    }
    
    //MARK: UI Specification Processing
    private var isViewReady: Bool = false
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if isViewReady { return }
        constructViewHierarchy()
        activateConstraints()
        bindInteraction()
        isViewReady = true
    }

    func constructViewHierarchy() {
        addSubview(inviteUserButton)
    }

    func activateConstraints() {
        inviteUserButton.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }

    func bindInteraction() {
        inviteUserButton.addTarget(self, action: #selector(clickButton(sender: )), for: .touchUpInside)
    }

    // MARK:  Action Event
    @objc func clickButton(sender: UIButton) {
        viewModel.inviteUser()
    }
    
    // MARK: Register TUICallState Observer && Update UI
    func registerObserveState() {
        TUICallState.instance.mediaType.addObserver(mediaTypeObserver) { [weak self] newValue, _ in
            guard let self = self else { return }
            self.updateImage()
        }
    }

    func updateImage() {
        if viewModel.mediaType.value == .audio {
            if let image = TUICallKitCommon.getBundleImage(name: "ic_add_user_dark") {
                inviteUserButton.setBackgroundImage(image, for: .normal)
            }
        } else if viewModel.mediaType.value == .video {
            if let image = TUICallKitCommon.getBundleImage(name: "ic_add_user") {
                inviteUserButton.setBackgroundImage(image, for: .normal)
            }
        }
    }
}
