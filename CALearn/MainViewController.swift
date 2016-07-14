//
//  ViewController.swift
//  CALearn
//
//  Created by 吴杰健 on 16/7/13.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var vcTypes = [CAType]()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _initDataSource()
        tableview.tableFooterView = UIView()
    }
    
    private func _initDataSource() {
        let vcDic = [
//            "": "",
            "3D Translation": "tDTranslationViewController"
        ]
        for (key, value) in vcDic {
            vcTypes.append(CAType(name: key, viewControllerName: value))
        }
    }

}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vcTypes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = vcTypes[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = StoryboardHelper.Main()(vcTypes[indexPath.row].viewControllerName)
        vc.title = vcTypes[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
