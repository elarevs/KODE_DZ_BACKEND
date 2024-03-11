//
//  SensorViewController.swift
//  DZ KODE BackEnd
//
//  Created by Artem Elchev on 11.03.2024.
//

import UIKit

final class SensorViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    private var sensors = [SensorData]()
    var timeout = TimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSensorData()
    }
    
}

extension SensorViewController {
    private func fetchSensorData() {
        networkManager.fetchSensorData(timeout: timeout) { [weak self] result in
            switch result {
            case .success(let sensors):
                self?.sensors = sensors
            case .failure(let error):
                print("Error in fetchSensorData: \(error.localizedDescription)")
            }
        }
    }
    
}

//print("good")
