// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct TrendingOffersInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    sponsors: GraphQLNullable<[String?]> = nil
  ) {
    __data = InputDict([
      "sponsors": sponsors
    ])
  }

  public var sponsors: GraphQLNullable<[String?]> {
    get { __data["sponsors"] }
    set { __data["sponsors"] = newValue }
  }
}
