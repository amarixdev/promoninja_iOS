// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct OfferInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    sponsor: String,
    promoCode: String,
    url: String
  ) {
    __data = InputDict([
      "sponsor": sponsor,
      "promoCode": promoCode,
      "url": url
    ])
  }

  public var sponsor: String {
    get { __data["sponsor"] }
    set { __data["sponsor"] = newValue }
  }

  public var promoCode: String {
    get { __data["promoCode"] }
    set { __data["promoCode"] = newValue }
  }

  public var url: String {
    get { __data["url"] }
    set { __data["url"] = newValue }
  }
}
