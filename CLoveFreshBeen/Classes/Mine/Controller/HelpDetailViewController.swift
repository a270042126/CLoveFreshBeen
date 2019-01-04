//
//  HelpDetailViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/4.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class HelpDetailViewController: UIViewController {

    private var questionTableView: LFBTableView?
    private var questions: [Question]?
    private var lastOpenIndex = -1
    private var isOpenCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        navigationItem.title = "常见问题"
        view.backgroundColor = UIColor.white
        buildQuestionTableView()
        loadHelpData()
    }
    
    private func buildQuestionTableView() {
        questionTableView = LFBTableView(frame: view.bounds, style: UITableView.Style.plain)
        questionTableView?.backgroundColor = UIColor.white
        questionTableView?.register(HelpHeadView.self, forHeaderFooterViewReuseIdentifier: "headView")
        questionTableView?.sectionHeaderHeight = 50
        questionTableView!.delegate = self
        questionTableView!.dataSource = self
        questionTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        view.addSubview(questionTableView!)
    }
    
    private func loadHelpData() {
        HttpTool.loadQuestions { (models) in
            self.questions = models
            self.questionTableView?.reloadData()
        }
    }
}

extension HelpDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lastOpenIndex == section && isOpenCell {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AnswerCell.answerCell(tableView: tableView)
        cell.question = questions![indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if lastOpenIndex == indexPath.section && isOpenCell {
            return questions![indexPath.section].cellHeight
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headView") as? HelpHeadView
        headView!.tag = section
        headView?.delegate = self
        let question = questions![section]
        headView?.question = question
        
        return headView!
    }
}

extension HelpDetailViewController: HelpHeadViewDelegate{
    func headViewDidClck(headView: HelpHeadView) {
        if lastOpenIndex != -1 && lastOpenIndex != headView.tag && isOpenCell {
            let headView = questionTableView?.headerView(forSection: lastOpenIndex) as? HelpHeadView
            headView?.isSelected = false
            
            let deleteIndexPaths = [IndexPath(row: 0, section: lastOpenIndex)]
            isOpenCell = false
            questionTableView?.deleteRows(at: deleteIndexPaths, with: UITableView.RowAnimation.automatic)
        }
        
        
        if lastOpenIndex == headView.tag && isOpenCell {
            let deleteIndexPaths = [IndexPath(row: 0, section: lastOpenIndex)]
            isOpenCell = false
            questionTableView?.deleteRows(at: deleteIndexPaths, with: UITableView.RowAnimation.automatic)
            return
        }
        
        lastOpenIndex = headView.tag
        isOpenCell = true
        let insertIndexPaths = [IndexPath(row: 0, section: headView.tag)]
        questionTableView?.insertRows(at: insertIndexPaths, with: UITableView.RowAnimation.top)
    }
}
