//
//  FunctionalOperators.swift
//  Composable2048
//
//  Created by Tornike on 08/09/2023.
//

import Foundation

precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

public func |> <A,B>(x: A, f:(A) -> B) -> B {
    return f(x)
}
