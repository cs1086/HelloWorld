//
//  CustomView.swift
//  helloWorld
//
//  Created by SJ on 2022/7/4.
//

import UIKit

class CustomView: UIView {

    @IBAction func customClick(_ sender: UIButton) {
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoer:NSCoder){
        super.init(coder: aDecoer)
    }
    func loadXib(){
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "CustomView", bundle: bundle)
            ///透過nib來取得xibView
            let xibView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
            addSubview(xibView)
            ///設置xibView的Constraint
            xibView.translatesAutoresizingMaskIntoConstraints = false
            xibView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            xibView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            xibView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            xibView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
