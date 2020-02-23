//
//  Router.swift
//  TraysSwiftUI
//
//  Created by Abhishek Chandrashekar on 21/02/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import Foundation
import Combine

struct Reducer<State, Action> {
    typealias Change = (inout State) -> Void
    let reduce: (State, Action) -> AnyPublisher<Change, Never>
}

extension Reducer {
    static func sync(_ fun: @escaping (inout State) -> Void) -> AnyPublisher<Change, Never> {
        Just(fun).eraseToAnyPublisher()
    }
}

final class Store<State, Action>: ObservableObject {

    @Published private(set) var state: State
    private let reducer: Reducer<State, Action>
    private var cancellables: Set<AnyCancellable> = []

    init(initialState: State, reducer: Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    func send(_ action: Action) {
        reducer
            .reduce(state, action)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: perform)
            .store(in: &cancellables)
    }

    private func perform(change: Reducer<State, Action>.Change) {
        change(&state)
    }

}
