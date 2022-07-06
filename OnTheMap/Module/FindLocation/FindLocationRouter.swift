//
//  FindLocationRouter.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 23/06/22.
//

import Foundation
import SwiftUI

class FindLocationRouter {

  func showView() -> some View {
    let usecase = Injection.init().provideFindLocation()
    let viewModel = FindLocationViewModel(usecase)
    return FindLocationView(viewModel: viewModel)
  }

}
