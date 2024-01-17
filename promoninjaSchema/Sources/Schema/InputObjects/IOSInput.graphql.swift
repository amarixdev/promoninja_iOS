// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct IOSInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    isTrendingPage: GraphQLNullable<Bool> = nil,
    isPodcastCategoryPage: GraphQLNullable<Bool> = nil
  ) {
    __data = InputDict([
      "isTrendingPage": isTrendingPage,
      "isPodcastCategoryPage": isPodcastCategoryPage
    ])
  }

  public var isTrendingPage: GraphQLNullable<Bool> {
    get { __data["isTrendingPage"] }
    set { __data["isTrendingPage"] = newValue }
  }

  public var isPodcastCategoryPage: GraphQLNullable<Bool> {
    get { __data["isPodcastCategoryPage"] }
    set { __data["isPodcastCategoryPage"] = newValue }
  }
}
