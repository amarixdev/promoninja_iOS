// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct SponsorInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    name: String,
    url: GraphQLNullable<String> = nil,
    description: GraphQLNullable<String> = nil,
    image: GraphQLNullable<String> = nil,
    baseUrl: GraphQLNullable<String> = nil,
    category: GraphQLNullable<String> = nil,
    summary: GraphQLNullable<String> = nil,
    promoCode: GraphQLNullable<String> = nil,
    offer: GraphQLNullable<String> = nil,
    isCategoryPage: GraphQLNullable<Bool> = nil
  ) {
    __data = InputDict([
      "name": name,
      "url": url,
      "description": description,
      "image": image,
      "baseUrl": baseUrl,
      "category": category,
      "summary": summary,
      "promoCode": promoCode,
      "offer": offer,
      "isCategoryPage": isCategoryPage
    ])
  }

  public var name: String {
    get { __data["name"] }
    set { __data["name"] = newValue }
  }

  public var url: GraphQLNullable<String> {
    get { __data["url"] }
    set { __data["url"] = newValue }
  }

  public var description: GraphQLNullable<String> {
    get { __data["description"] }
    set { __data["description"] = newValue }
  }

  public var image: GraphQLNullable<String> {
    get { __data["image"] }
    set { __data["image"] = newValue }
  }

  public var baseUrl: GraphQLNullable<String> {
    get { __data["baseUrl"] }
    set { __data["baseUrl"] = newValue }
  }

  public var category: GraphQLNullable<String> {
    get { __data["category"] }
    set { __data["category"] = newValue }
  }

  public var summary: GraphQLNullable<String> {
    get { __data["summary"] }
    set { __data["summary"] = newValue }
  }

  public var promoCode: GraphQLNullable<String> {
    get { __data["promoCode"] }
    set { __data["promoCode"] = newValue }
  }

  public var offer: GraphQLNullable<String> {
    get { __data["offer"] }
    set { __data["offer"] = newValue }
  }

  public var isCategoryPage: GraphQLNullable<Bool> {
    get { __data["isCategoryPage"] }
    set { __data["isCategoryPage"] = newValue }
  }
}
