//
//  CalendarViewController.swift
//  myCalander
//
//  Created by junga oh on 2022/08/15.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, SendDataDelegate {
    
    func sendTitle(str: String, color: String) {
        selectedColor = color
        selectedTitle = str
        setUpEvents()
    }
    
    // MARK: - Properties
    @IBOutlet weak var calendarView: FSCalendar!
    var selectedDate: String = ""
    var dateFormatter = DateFormatter()
    
    
    var bee_events: Array<Date> = Array<Date>()
    var honey_events: Array<Date> = Array<Date>()
    var flutter_events: Array<Date> = Array<Date>()
    var redish_events: Array<Date> = Array<Date>()
    var striped_events: Array<Date> = Array<Date>()
    
    var eventStruct: Array<saveEvent> = Array<saveEvent>()
    
    var selectedColor: String? = "Bee"
    var selectedTitle: String? = "제목 없음"
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        loadEvents()
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarViewSet()
        checkLockStatus()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadEvents()
    }
    override func viewDidAppear(_ animated: Bool) {
        loadLockStatus()
    }
    // MARK: - Calendar View UI Set Func
    private func calendarViewSet() {
        self.calendarView.locale = Locale(identifier: "ko_KR")
        self.calendarView.calendarWeekdayView.weekdayLabels[0].text = "S"
        self.calendarView.calendarWeekdayView.weekdayLabels[1].text = "M"
        self.calendarView.calendarWeekdayView.weekdayLabels[2].text = "T"
        self.calendarView.calendarWeekdayView.weekdayLabels[3].text = "W"
        self.calendarView.calendarWeekdayView.weekdayLabels[4].text = "T"
        self.calendarView.calendarWeekdayView.weekdayLabels[5].text = "F"
        self.calendarView.calendarWeekdayView.weekdayLabels[6].text = "S"
        
        self.calendarView.scrollEnabled = true
        self.calendarView.scrollDirection = .horizontal
        
        self.calendarView.appearance.headerTitleFont = UIFont(name: "Noto Sans Oriya", size: 20)
        self.calendarView.appearance.headerTitleColor = UIColor(named: "Striped")
        self.calendarView.appearance.headerDateFormat = "YYYY년 MM월"
        self.calendarView.appearance.headerMinimumDissolvedAlpha = 0.2
        self.calendarView.headerHeight = 60
        self.calendarView.appearance.weekdayTextColor = UIColor(named: "Striped")
        self.calendarView.appearance.titleWeekendColor = UIColor(named: "Redish")
    }
    // MARK: Select Date & Add Event
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter.string(from: date)
        let storyborad = UIStoryboard.init(name: "Main", bundle: nil)
        guard let popVC = storyborad.instantiateViewController(withIdentifier: "AddTaskViewController") as? AddTaskViewController else {return}
        popVC.modalPresentationStyle = .overCurrentContext
        popVC.delegate = self
        self.present(popVC, animated: true, completion: nil)
    }
    // MARK: Changing selected date color
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        appearance.selectionColor = UIColor(named: "Flutter")
        return appearance.selectionColor
    }
    // MARK: '오늘' showing today date
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        switch dateFormatter.string(from: date) {
        case dateFormatter.string(from: Date()):
            return "오늘"
        default:
            return nil
        }
    }
    // MARK: number of Events
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.bee_events.contains(date) {
            return 1
        } else if self.honey_events.contains(date) {
            return 1
        } else if self.redish_events.contains(date) {
            return 1
        } else if self.striped_events.contains(date) {
            return 1
        } else if self.flutter_events.contains(date) {
            return 1
        }
        return 0
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.bee_events.contains(date) {
            return [UIColor.orange]
        } else if self.honey_events.contains(date) {
            return [UIColor.orange]
        } else if self.redish_events.contains(date) {
            return [UIColor.red]
        } else if self.striped_events.contains(date) {
            return [UIColor.blue]
        } else if self.flutter_events.contains(date) {
            return [UIColor.gray]
        }
        return nil
    }
    // MARK: Add Events
    func setUpEvents() {
        //self.calendarView.appearance.eventDefaultColor = UIColor(named: selectedColor!)
        
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let event = dateFormatter.date(from: selectedDate)
        
        switch selectedColor {
        case "Bee": bee_events.append(event!); break
        case "Flutter": flutter_events.append(event!); break
        case "Honey": honey_events.append(event!); break
        case "Redish": redish_events.append(event!); break
        case "Striped": striped_events.append(event!); break
        default: break
        }
        
        eventStruct.append(saveEvent(event: selectedDate, title: selectedTitle!, color: selectedColor!))
        
        dataManager.shared.eventStruct = eventStruct
        
        saveData()
        self.calendarView.reloadData()
    }
    // MARK: - Save/Load UserDefaults
    func saveData() {
        let data = eventStruct.map {
            [
                "event" : $0.event,
                "title" : $0.title,
                "color" : $0.color,
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(data, forKey: "eventStruct")
    }
    func loadData() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "eventStruct") as? [[String : Any]] else { return }
        eventStruct = data.compactMap {
            guard let event = $0["event"] as? String else { return nil }
            guard let title = $0["title"] as? String else { return nil }
            guard let color = $0["color"] as? String else { return nil }
            
            return saveEvent(event: event, title: title, color: color)
        }
        dataManager.shared.eventStruct = eventStruct
    }
    // MARK: load Events dot
    func loadEvents() {
        bee_events.removeAll()
        flutter_events.removeAll()
        honey_events.removeAll()
        redish_events.removeAll()
        striped_events.removeAll()
        
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for index in 0..<dataManager.shared.eventStruct.count {
            
            let event = dateFormatter.date(from: dataManager.shared.eventStruct[index].event)
            
            switch eventStruct[index].color {
            case "Bee": bee_events.append(event!); break
            case "Flutter": flutter_events.append(event!); break
            case "Honey": honey_events.append(event!); break
            case "Redish": redish_events.append(event!); break
            case "Striped": striped_events.append(event!); break
            default: break
            }
        }
        calendarView.reloadData()
    }
    // MARK: load/Compare Password
    func loadLockStatus() {
        let userDefaults = UserDefaults.standard
        guard let password = userDefaults.object(forKey: "password") as? [String] else { return }
        
        dataManager.shared.password = password
        if (dataManager.shared.lockBool == true && dataManager.shared.localLockStatus == true) {
            print(dataManager.shared.lockBool)
            print(dataManager.shared.password)
            let storyborad = UIStoryboard.init(name: "Main", bundle: nil)
            guard let popVC = storyborad.instantiateViewController(withIdentifier: "LockViewController") as? LockViewController else {return}
            popVC.modalPresentationStyle = .fullScreen
            self.present(popVC, animated: true, completion: nil)
            
        } else {
            print("doesn't Lock")
        }
    }
    // MARK: Check Lock Status(initialized when app quited)
    func checkLockStatus() {
        let userDefaults = UserDefaults.standard
        guard let lockStatus = userDefaults.object(forKey: "lockStatus") as? Bool else { return }
        dataManager.shared.lockBool = lockStatus
        dataManager.shared.localLockStatus = lockStatus
    }
}
