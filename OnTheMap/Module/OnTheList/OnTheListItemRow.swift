//
//  OnTheListRow.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import SwiftUI

struct OnTheListItemRow: View {

  var studentLocation: StudentLocationModel

  var body: some View {
    VStack(alignment: .leading, spacing: 10.0) {

      HStack {
        Text("\(studentLocation.firstName ?? "") \(studentLocation.lastName ?? "" )")
        .font(.title)
        .bold()
        Spacer()
      }

      Text(studentLocation.mapString ?? "")
        .font(.system(size: 14))
        .lineLimit(2)
    }
    .padding(.all)
    .frame(width: UIScreen.main.bounds.width - 32)
    .background(Color.random.opacity(0.3))
    .cornerRadius(10)
  }

}

struct OnTheListItemRow_Previews: PreviewProvider {
  static var previews: some View {
    OnTheListItemRow(studentLocation: StudentLocationModel(
      firstName: "John Emi",
      lastName: "Doe",
      longitude: -122.083851,
      latitude: 37.386052,
      mapString: "Mountain View, CA",
      mediaURL: "https://udacity.com",
      uniqueKey: "654376",
      objectId: "ID10",
      createdAt: "2019-05-17T00:53:33.941Z",
      updatedAt: "2022-05-20T04:20:49.505Z")
    )
  }
}
