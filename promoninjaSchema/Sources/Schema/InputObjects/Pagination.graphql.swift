// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct Pagination: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    offset: GraphQLNullable<Int> = nil,
    pageSize: GraphQLNullable<Int> = nil,
    offerPage: GraphQLNullable<Bool> = nil,
    path: GraphQLNullable<Bool> = nil
  ) {
    __data = InputDict([
      "offset": offset,
      "pageSize": pageSize,
      "offerPage": offerPage,
      "path": path
    ])
  }

  public var offset: GraphQLNullable<Int> {
    get { __data["offset"] }
    set { __data["offset"] = newValue }
  }

  public var pageSize: GraphQLNullable<Int> {
    get { __data["pageSize"] }
    set { __data["pageSize"] = newValue }
  }

  public var offerPage: GraphQLNullable<Bool> {
    get { __data["offerPage"] }
    set { __data["offerPage"] = newValue }
  }

  public var path: GraphQLNullable<Bool> {
    get { __data["path"] }
    set { __data["path"] = newValue }
  }
}
