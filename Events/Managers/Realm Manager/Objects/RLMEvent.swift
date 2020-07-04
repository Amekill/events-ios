//
//  RLMEvent.swift
//  Events
//
//  Created by Alexey Kostenko on 6/18/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm

class RLMEvent {
    
    let disposeBag = DisposeBag()
    
    private func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(RLMEventModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    private func getRealmObject() -> Realm {
        let fileURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.events.database")!
            .appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: fileURL)
        
        return try! Realm(configuration: config)
    }
    
    func saveEvent(_ event: EventModel) {
        let realm = getRealmObject()
        let id = incrementID()
        let model = RLMEventModel(
            id: id,
            name: event.name ?? "",
            category: event.category ?? .other,
            date: event.date ?? Date(),
            image: "\(id)",
            notifications: event.notifications ?? .never,
            dateFormat: event.dateFormat
        )
        
        if let image = event.image {
            ImageHelper.saveImageInDocumentDirectory(image: image, fileName: "\(id)")
        }
        
        Observable.from([model])
            .subscribe(
                realm.rx.add()
            )
        .disposed(by: disposeBag)
    }
    
    func deleteEvent(withId id: Int) {
        let realm = getRealmObject()
        let event = realm.objects(RLMEventModel.self).filter("id = \(id)")
        
        Observable.collection(from: event)
            .subscribe(realm.rx.delete())
        .disposed(by: disposeBag)
        
        ImageHelper.deleteImageFromDocumentDirectory(fileName: "\(id)")
    }
    
    func getEvents(sortBy: SettingsContentType.SortType, onSuccess: @escaping ([RLMEventModel]) -> Void) -> Observable<([Results<RLMEventModel>.ElementType], RealmChangeset)> {
        return Observable.create { observer in
            let realm = self.getRealmObject()
            
            var events: Results<RLMEventModel> {
                switch sortBy {
                case .date:
                    return realm.objects(RLMEventModel.self).sorted(byKeyPath: "date", ascending: false)
                case .last:
                    return realm.objects(RLMEventModel.self).sorted(byKeyPath: "id", ascending: false)
                }
            }
            
            Observable.arrayWithChangeset(from: events)
                .subscribe(onNext: { array, changes in
                    if let changes = changes {
                        observer.onNext((array, changes))
                    } else {
                        onSuccess(array)
                    }
                })
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func updateEvent(_ event: EventModel) {
        let realm = getRealmObject()
        let id = "\(event.id ?? 0)"
        
        let model = RLMEventModel(
            id: event.id ?? 0,
            name: event.name ?? "",
            category: event.category ?? .other,
            date: event.date ?? Date(),
            image: id,
            notifications: event.notifications ?? .never,
            dateFormat: event.dateFormat
        )
        
        if let image = event.image {
            ImageHelper.saveImageInDocumentDirectory(image: image, fileName: id)
        }
        
        Observable.from([model])
            .subscribe(
                realm.rx.add(update: .modified, onError: nil)
            )
        .disposed(by: disposeBag)
    }
}
