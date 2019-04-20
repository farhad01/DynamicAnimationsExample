//
//  FAPopupController.swift
//  DynamicAnimationsExample
//
//  Created by farhad jebelli on 4/20/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class FAPopupController: UIViewController {
    
    var indicator: PopupIndicatorView!
    
    let topMargin: CGFloat = 25
    let collapsedHeight: CGFloat = 70
    var containerView: UIView!
    var animation: UIDynamicAnimator!
    var attachment: UIAttachmentBehavior!
    var push: UIPushBehavior!
    
    var isOpen: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContainerView()
        setupGestureRecognizers()
        setupIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBehaviers()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        
    }
    
    func setupIndicator() {
        indicator = PopupIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        indicator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
    }
    
    func setupGestureRecognizers() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        containerView.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        containerView.addGestureRecognizer(tap)
    }
    
    func setupContainerView() {
        containerView = UIView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: view.frame.height - topMargin - collapsedHeight).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1, constant: -topMargin).isActive = true
        
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupBehaviers() {
        animation = UIDynamicAnimator(referenceView: view)
        
        let item = UIDynamicItemBehavior(items: [containerView])
        item.allowsRotation = false
        
        
        animation.addBehavior(item)
        
        attachment = UIAttachmentBehavior(item: containerView, offsetFromCenter: UIOffset(horizontal: -(containerView.bounds.width / 2), vertical: -(containerView.bounds.height / 2)), attachedToAnchor: CGPoint(x: 0, y: view.frame.height - collapsedHeight))
        attachment.length = 0
        attachment.damping = 1
        attachment.frequency = 1.5
        
        animation.addBehavior(attachment)
        
        push = UIPushBehavior(items: [containerView], mode: .continuous)
        push.angle = .pi / 2
        
        push.magnitude = 0
        animation.addBehavior(push)
        
        let collision = UICollisionBehavior(items: [containerView])
        collision.addBoundary(withIdentifier: NSString(string: "left"), from: CGPoint(x: -1, y: 0), to: CGPoint(x: -1, y: view.frame.height))
        collision.addBoundary(withIdentifier: NSString(string: "right"), from: CGPoint(x: view.frame.width + 1, y: 0), to: CGPoint(x: view.frame.height + 1, y: view.frame.height))
        animation.addBehavior(collision)
        
    }
    
    @objc func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let location = recognizer.location(in: self.view)
        if isOpen {
            switch recognizer.state {
            case .changed:
                push.magnitude = translation.y * 4
                if translation.y > 200 {
                    indicator.isStraight = true
                } else {
                    indicator.isStraight = false
                }
            case .ended:
                push.magnitude = 0
                if translation.y > 200 {
                    close()
                }
            default:
                break
            }
        } else {
            switch recognizer.state {
            case .changed:
                attachment.anchorPoint = CGPoint(x: 0, y: location.y)
            case .ended:
                open()
            default:
                break
            }
        }
    }
    
    func open() {
        attachment.anchorPoint = CGPoint(x: 0, y: view.safeAreaInsets.top + topMargin)
        isOpen = true
        indicator.isStraight = false
    }
    
    func close() {
        attachment.anchorPoint = CGPoint(x: 0, y: view.frame.height - collapsedHeight)
        isOpen = false
        indicator.isStraight = true
    }
    
    @objc func handleTap(recognizer:UITapGestureRecognizer) {
        if !isOpen {
            open()
        }
    }

}
