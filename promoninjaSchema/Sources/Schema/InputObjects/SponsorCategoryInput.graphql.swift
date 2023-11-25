// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct SponsorCategoryInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    sponsor: GraphQLNullable<String> = nil,
    category: GraphQLNullable<String> = nil,
    offset: GraphQLNullable<Int> = nil,
    pageSize: GraphQLNullable<Int> = nil
  ) {
    __data = InputDict([
      "sponsor": sponsor,
      "category": category,
      "offset": offset,
      "pageSize": pageSize
    ])
  }

  public var sponsor: GraphQLNullable<String> {
    get { __data["sponsor"] }
    set { __data["sponsor"] = newValue }
  }

  public var category: GraphQLNullable<String> {
    get { __data["category"] }
    set { __data["category"] = newValue }
  }

  public var offset: GraphQLNullable<Int> {
    get { __data["offset"] }
    set { __data["offset"] = newValue }
  }

  public var pageSize: GraphQLNullable<Int> {
    get { __data["pageSize"] }
    set { __data["pageSize"] = newValue }
  }
}
