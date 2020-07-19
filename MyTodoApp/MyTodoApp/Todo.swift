//
//  Todo.swift
//  MyTodoApp
//
//  Created by 김태형 on 18/07/2020.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

struct Todo: Codable, Equatable {
    let id: Int
    var isDone: Bool
    var detail: String
    var isToday: Bool
    
    mutating func update(isDone: Bool, detail: String, isToday: Bool) {
        self.isDone = isDone
        self.detail = detail
        self.isToday = isToday
    }
    
    // Todo 두 개가 동등한 지 확인.
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

// Todo를 관리하기 위한 매니저
// 가져야할 것
// - Todo List
// - 생성, 삭제, 업데이트, 추가, 저장, 불러오기
class TodoManager {
    static let shared = TodoManager()
    
    static var lastId: Int = 0
    var todos: [Todo] = []
    
    // Todo 생성
    func createTodo(detail: String, isToday: Bool) -> Todo {
        let nextId = TodoManager.lastId + 1
        TodoManager.lastId = nextId
        return Todo(id: nextId, isDone: false, detail: detail, isToday: isToday)
    }
    
    // Todo List에 추가
    func addTodo(todo: Todo) {
        todos.append(todo)
        // 저장
        saveTodo()
    }
    
    // Todo List에 해당 Todo 삭제
    func deleteTodo(_ todo: Todo) {
        // 현재 todo list에서 해당 todo와 아이디가 같은 것만 제외하고 다시 새로 만듦.
        todos = todos.filter { $0.id != todo.id }
        
        // 저장
        saveTodo()
    }
    
    func updateTodo(_ todo: Todo) {
        guard let index = todos.firstIndex(of: todo) else { return }
        
        todos[index].update(isDone: todo.isDone, detail: todo.detail
            , isToday: todo.isToday)
        
        // 저장.
        saveTodo()
    }
    
    func saveTodo() {
        Storage.store(todos, to: .documents, as: "todos.json")
    }
    
    func retriveTodo() {
        todos = Storage.retrive("todos.json", from: .documents, as: [Todo].self) ?? []
        
        let lastId = todos.last?.id ?? 0
        TodoManager.lastId = lastId
    }
}

class TodoViewModel {
    
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
            case .today: return "Today"
            default: return "UpComing"
            }
        }
    }
    
    private let manager = TodoManager.shared
    
    // 직접 TodoManager나 Todo에 접근할 수 없도록 여기서 한 번 Wrapping 한다.
    var todos: [Todo] {
        return manager.todos
    }
    
    var todayTodos: [Todo] {
        return todos.filter { $0.isToday == true}
    }
    
    var upcomingTodos: [Todo] {
        return todos.filter { $0.isToday == false }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addTodo(_ todo: Todo) {
        manager.addTodo(todo: todo)
    }
    
    func deleteTodo(_ todo: Todo) {
        manager.deleteTodo(todo)
    }
    
    func updateTodo(_ todo: Todo) {
        manager.updateTodo(todo)
    }
    
    func loadTasks() {
        manager.retriveTodo()
    }
}
