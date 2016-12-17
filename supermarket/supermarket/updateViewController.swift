//
//  updateViewController.swift
//  supermarket
//
//  Created by apple on 2016/10/7.
//  Copyright © 2016年 zoujiahong. All rights reserved.
//

import UIKit
import Firebase

class updateViewController: UIViewController {

    var markets : market?
    var key : String?
    var nametextfield : UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    var pricetextfield : UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    var namelabel : UILabel = {
        let label = UILabel()
        label.text = "商品民称:"
        return label
    }()
    var pricelabel : UILabel = {
        let label = UILabel()
        label.text = "商品价格:"
        return label
    }()
    var imageview : UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    lazy var sendbutton : UIButton = {
        let button = UIButton()
        button.setTitle("send", forState: .Normal)
        button.addTarget(self, action: #selector(send), forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.blueColor()
        button.layer.cornerRadius = 40
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(imageview)
        self.view.addSubview(namelabel)
        self.view.addSubview(pricelabel)
        self.view.addSubview(nametextfield)
        self.view.addSubview(pricetextfield)
        self.view.addSubview(sendbutton)
        setupui()
    }
    func send (){
        let name = nametextfield.text
        let price = pricetextfield.text
        let value :[String:AnyObject] = ["name":name!,
                                         "price":price!]
        let ref = FIRDatabase.database().reference().child("supermarket").child(key!)
        ref.updateChildValues(value)
        navigationController?.popViewControllerAnimated(true)
    }

    func setupui(){
        namelabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(100)
            make.left.equalTo(self.view.snp_left).offset(20)
            make.size.equalTo(CGSizeMake(80, 20))
        }
        pricelabel.snp_makeConstraints { (make) in
            make.top.equalTo(namelabel.snp_bottom).offset(20)
            make.left.equalTo(self.view.snp_left).offset(20)
            make.size.equalTo(CGSizeMake(80, 20))
        }
        nametextfield.text = markets?.name
        nametextfield.snp_makeConstraints { (make) in
            make.top.equalTo(namelabel.snp_top)
            make.left.equalTo(namelabel.snp_right)
            make.size.equalTo(CGSizeMake(100, 20))
        }
        pricetextfield.text = markets?.price
        pricetextfield.snp_makeConstraints { (make) in
            make.top.equalTo(pricelabel.snp_top)
            make.left.equalTo(pricelabel.snp_right)
            make.size.equalTo(CGSizeMake(100, 20))
        }
        let imageurl = markets?.imageurl
        imageview.kf_setImageWithURL(NSURL(string: imageurl! as String)!,placeholderImage:nil);
        imageview.snp_makeConstraints { (make) in
            make.top.equalTo(namelabel.snp_top)
            make.right.equalTo(self.view.snp_right).offset(8)
            make.size.equalTo(CGSizeMake(80, 80))
        }
        sendbutton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.bottom.equalTo(self.view.snp_bottom).offset(-100)
            make.size.equalTo(CGSizeMake(80, 80))
        }
        
        
        
    }
    
    
    
    
    
    
    
}
