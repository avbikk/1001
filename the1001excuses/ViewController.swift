//
//  ViewController.swift
//  the1001excuses
//
//  Created by Alsu Bikkulova on 28/12/2019.
//  Copyright © 2019 Alsu Bikkulova. All rights reserved.
//

import UIKit

/// Идентификатор ячейки
let reuseIdentifier = "Cell"

/// Main ViewController
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    /// Коллекция с данными
    var excuseSelectionCollectionView = ExcuseSelectionCollectionViewController()
    /// Параметр для хранения моделей
    var viewModels: [ExcusesViewModel] = []
    var imageView = UIImageView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createExcusesViewModel()
        createExcuseSelectionCollectionView()
        addApplicationTitle()
    }
    
    /// Создание моделей
    func createExcusesViewModel() {
        let viewModelEnglish = ExcusesViewModel(themeTitle: "Английский",
                                                themeColor: SemanticColors.brilliantAzure,
                                                themeExcuses: ["Аврал, ничего не успеваю"
                                                    ,"Нужно купить всем подарки к новому году"
                                                    ,"Мне же нужно ещё сдать все отчетности!"
                                                    ,"Надо доделать все дела!"
                                                    ,"Написать списки и вишлисты"
                                                    ,"Устал, с 1-го января начну"])
        
        let viewModelDiploma = ExcusesViewModel(themeTitle: "Диплом",
                                                themeColor: SemanticColors.electricBlue,
                                                themeExcuses: [
                                                    "Уже нет времени! Я ничего не успею"
                                                    ,"Там осталось только написать, у меня уже все сделано!"
                                                    ,"Он все равно никому не нужен!"
                                                    ,"А Билл Гейтс с Цукербергом тоже не закончили, чем я хуже?"])
        let viewModelJustBecause = ExcusesViewModel(themeTitle: "Просто",
                                                themeColor: SemanticColors.diamond,
                                                themeExcuses: ["Не сегодня!"
                                                    ,"Не могу думать об этом сегодня, подумаю об этом завтра!"
                                                    ,"Ой, все"
                                                    ,"Некогда"
                                                    ,"Не сейчас"
                                                    ,"Нет денег"])
        let viewModelLearnSwift = ExcusesViewModel(themeTitle: "Swift",
                                                themeColor: SemanticColors.scarlet,
                                                themeExcuses: ["Не сегодня!"
                                                    ,"Не могу думать об этом сегодня, подумаю об этом завтра!"
                                                    ,"Ой, все"
                                                    ,"Фича фриз сегодня!"
                                                    ,"Ну давай, спроси меня о чем-то! О чем-то легком, конечно же)"
                                                    ,"Багу нашли, срочно чинить!"
                                                    ,"Зачем этот Swift вообще нужен?"
                                                    ,"Багу нашли, срочно чинить!"
                                                    ,"Зачем этот Swift вообще нужен?"
                                                    ,"Я вас вообще не понимаю, SWIFT - это международная система переводов денег, что там учить то?"
                                                    ,"Некогда"
                                                    ,"Не сейчас"
                                                    ,"Нет денег"])
        viewModels = [viewModelEnglish, viewModelDiploma, viewModelJustBecause,
                      viewModelEnglish, viewModelDiploma, viewModelLearnSwift,
                      viewModelEnglish, viewModelDiploma, viewModelJustBecause]
    }
    
    /// Выставление параметров для коллекции
    func createExcuseSelectionCollectionView() {
        excuseSelectionCollectionView.collectionView.frame = self.view.frame
        excuseSelectionCollectionView.collectionView.dataSource = self
        excuseSelectionCollectionView.collectionView.delegate = self
        self.view.addSubview(excuseSelectionCollectionView.collectionView!)
    }
    
    
    /// Data source методы
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ExcusesCircularCollectionViewCell
        
        // Applying model
        cell.backgroundColor = viewModels[indexPath.row].themeColor
        cell.addThemeLabel(themeTitle: viewModels[indexPath.row].themeTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPathRow = indexPath.row
        let theme = viewModels[indexPathRow].themeTitle
        let excuse = viewModels[indexPathRow].themeExcuses.randomElement() ?? viewModels[indexPathRow].themeExcuses[0]
        showExcuseAlert(theme: theme, excuse: excuse)
    }
    
    /// Private методы
    func showExcuseAlert(theme: String, excuse: String) {
        let excuseAlert = UIAlertController(title: "Тема отмазульки: "+theme.lowercased()+"\n\n"+excuse, message: nil, preferredStyle: .alert)
        let excuseAlertAction = UIAlertAction(title: "Ну ладно", style: .default, handler: nil)
        excuseAlert.addAction(excuseAlertAction)
        present(excuseAlert, animated: true, completion: nil)
    }

    func addApplicationTitle() {
        let titleLabel = UILabel(frame: view.frame)
        titleLabel.text = "Выбери тему отмазульки!"
        titleLabel.textColor = SemanticColors.titleBlueColor
        titleLabel.font = UIFont(name: "Arial", size: 30)
        view.addSubview(titleLabel)
        applyConstraintForTopObject(object: titleLabel)
    }
    
    func applyConstraintForTopObject(object: UIView) {
        object.translatesAutoresizingMaskIntoConstraints = false
        object.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        object.bottomAnchor.constraint(lessThanOrEqualTo: excuseSelectionCollectionView.collectionView.topAnchor).isActive = true
        object.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        object.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}

/// Класс колекции
class ExcuseSelectionCollectionViewController: UICollectionViewController {
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.collectionView.collectionViewLayout = ExcusesCircularCollectionViewLayout()
        self.collectionView.backgroundColor = SemanticColors.collectionViewBackgroundColor
        self.collectionView.register(ExcusesCircularCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(collectionViewLayout: ExcusesCircularCollectionViewLayout())
    }
}
