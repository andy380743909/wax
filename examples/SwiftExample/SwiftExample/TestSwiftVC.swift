//
//  TestSwiftVC.swift
//  TestSwift
//
//  Created by junzhan on 15/9/28.
//  Copyright © 2015年 taobao.com. All rights reserved.
//

import UIKit

import UIKit

@objcMembers
class TestASwiftClass: NSObject {

    dynamic var aBool: Bool = true
    dynamic var aInt: UInt = 0
    dynamic var aFloat: Float = 123.45
    dynamic var aDouble: Double = 1234.567
    dynamic var aString: String = "abc"
    dynamic var aObject: AnyObject?

    dynamic func testReturnVoid(with view: UIView) {
        print("Function: \(#function)")
        // This will intentionally call a missing selector to test Lua bridge safety
//        perform(Selector(("testNoExistMethod")), with: nil, afterDelay: 0)
    }
}

@objcMembers
class TestSwiftVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    dynamic var aBool: Bool = true
    dynamic var aInt: UInt = 0
    dynamic var aFloat: Float = 123.45
    dynamic var aDouble: Double = 1234.567
    dynamic var aString: String = "abc"
    dynamic var aObject: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TestSwiftVC"
        setupTableView()
        callTestASwiftClass()
        Self.testClassReturnVoid(aBool: true,
                                 aInteger: 123,
                                 aFloat: 123.456,
                                 aDouble: 1234.567,
                                 aString: "abc",
                                 aObject: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Function: \(#function)")
    }

    dynamic func callTestASwiftClass() {
        let obj = TestASwiftClass()
        obj.testReturnVoid(with: view)
    }

    dynamic func setupTableView() {
        let tableView = UITableView(frame: CGRect(x: 0,
                                                  y: 60,
                                                  width: view.bounds.width,
                                                  height: view.bounds.height),
                                    style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = "this is cell \(indexPath.row)"
        return cell
    }

    // MARK: - Test Methods

    dynamic func testReturnVoid(with view: UIView) {
        print("Function: \(#function)")
    }

    dynamic class func testClassReturnVoid(aBool: Bool,
                                           aInteger: UInt,
                                           aFloat: Float,
                                           aDouble: Double,
                                           aString: String,
                                           aObject: AnyObject) {
        print("Function: \(#function)")
    }

    dynamic class func testClassReturnVoid(with aObject: AnyObject) {
        print("Function: \(#function)")
    }

    func testReturnTuple(aBOOL: Bool, aInteger: UInt, aFloat: Float)
        -> (Bool, UInt, Float) {
        (aBOOL, aInteger, aFloat)
    }

    func testReturnVoid(with aCharacter: Character) {}
}
