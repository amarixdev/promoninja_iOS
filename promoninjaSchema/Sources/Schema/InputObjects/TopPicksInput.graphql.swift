// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct TopPicksInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    podcastTitles: GraphQLNullable<[String?]> = nil
  ) {
    __data = InputDict([
      "podcastTitles": podcastTitles
    ])
  }

  public var podcastTitles: GraphQLNullable<[String?]> {
    get { __data["podcastTitles"] }
    set { __data["podcastTitles"] = newValue }
  }
}
