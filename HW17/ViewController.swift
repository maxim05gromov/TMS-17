//
//  ViewController.swift
//  HW17
//
//  Created by Максим Громов on 13.08.2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    let radius: CGFloat = 30
    let buttonSize: CGFloat = 60
    let buttonSpacing: CGFloat = 10
    let step: CGFloat = 50
    
    lazy var circle = UIView()
    lazy var up = UIImageView()
    lazy var down = UIImageView()
    lazy var left = UIImageView()
    lazy var right =  UIImageView()
    lazy var vstack = UIStackView()
    lazy var hstack = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        circle.backgroundColor = .blue
        circle.frame = .init(x: view.frame.width / 2 - radius, y: view.frame.height / 2 - radius, width: radius * 2, height: radius * 2)
        circle.layer.cornerRadius = radius
        view.addSubview(circle)
        var tag = 0
        for b in [up, down, left, right]{
            b.isUserInteractionEnabled = true
            b.backgroundColor = .systemGray4
            b.clipsToBounds = true
            b.layer.cornerRadius = buttonSize / 2
            b.translatesAutoresizingMaskIntoConstraints = false
            b.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            b.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
            b.contentMode = .scaleAspectFit
            let gesture = UITapGestureRecognizer(target: self, action: #selector(moveCircle))
            b.tag = tag
            tag += 1
            b.addGestureRecognizer(gesture)
            
        }
        
        up.image = UIImage(systemName: "arrow.up")
        down.image = UIImage(systemName: "arrow.down")
        left.image = UIImage(systemName: "arrow.left")
        right.image = UIImage(systemName: "arrow.right")
        up.restorationIdentifier = "up"
        down.restorationIdentifier = "down"
        left.restorationIdentifier = "left"
        right.restorationIdentifier = "right"
        
        vstack.addArrangedSubview(up)
        vstack.addArrangedSubview(hstack)
        vstack.addArrangedSubview(down)
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.spacing = buttonSpacing
        hstack.addArrangedSubview(left)
        hstack.addArrangedSubview(right)
        hstack.axis = .horizontal
        hstack.alignment = .center
        hstack.spacing = buttonSize + 2 * buttonSpacing
        hstack.translatesAutoresizingMaskIntoConstraints = false
        hstack.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        view.addSubview(vstack)
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vstack.widthAnchor.constraint(equalToConstant: 3 * buttonSize + 2 * buttonSpacing).isActive = true
        vstack.heightAnchor.constraint(equalToConstant: 3 * buttonSize + 2 * buttonSpacing).isActive = true
        
    }
    
    @objc func moveCircle(_ sender: UITapGestureRecognizer){
        guard let tag = sender.view?.tag else { return }
        UIView.animate(withDuration: 0.5) {
            switch tag {
                case 0:
                    self.circle.frame.origin.y -= self.step
                case 1:
                    self.circle.frame.origin.y += self.step
                case 2:
                    self.circle.frame.origin.x -= self.step
                case 3:
                    self.circle.frame.origin.x += self.step
                default:
                return
            }
            
            if self.circle.frame.origin.y < 0 {
                self.circle.frame.origin.y = 0
            }
            if self.circle.frame.origin.y + self.circle.frame.height > self.vstack.frame.origin.y {
                self.circle.frame.origin.y = self.vstack.frame.origin.y - self.circle.frame.height
            }
            if self.circle.frame.origin.x < 0 {
                self.circle.frame.origin.x = 0
            }
            if self.circle.frame.origin.x + self.circle.frame.width > self.view.frame.width {
                self.circle.frame.origin.x = self.view.frame.width - self.circle.frame.width
            }
        }
        
    }

}

#Preview{
    ViewController()
}
