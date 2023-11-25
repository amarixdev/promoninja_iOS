// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct PodcastInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    sponsor: GraphQLNullable<SponsorInput> = nil,
    podcast: GraphQLNullable<String> = nil,
    category: GraphQLNullable<String> = nil,
    image: GraphQLNullable<String> = nil,
    publisher: GraphQLNullable<String> = nil,
    description: GraphQLNullable<String> = nil,
    backgroundColor: GraphQLNullable<String> = nil,
    externalUrl: GraphQLNullable<String> = nil,
    offer: GraphQLNullable<[OfferInput?]> = nil
  ) {
    __data = InputDict([
      "sponsor": sponsor,
      "podcast": podcast,
      "category": category,
      "image": image,
      "publisher": publisher,
      "description": description,
      "backgroundColor": backgroundColor,
      "externalUrl": externalUrl,
      "offer": offer
    ])
  }

  public var sponsor: GraphQLNullable<SponsorInput> {
    get { __data["sponsor"] }
    set { __data["sponsor"] = newValue }
  }

  public var podcast: GraphQLNullable<String> {
    get { __data["podcast"] }
    set { __data["podcast"] = newValue }
  }

  public var category: GraphQLNullable<String> {
    get { __data["category"] }
    set { __data["category"] = newValue }
  }

  public var image: GraphQLNullable<String> {
    get { __data["image"] }
    set { __data["image"] = newValue }
  }

  public var publisher: GraphQLNullable<String> {
    get { __data["publisher"] }
    set { __data["publisher"] = newValue }
  }

  public var description: GraphQLNullable<String> {
    get { __data["description"] }
    set { __data["description"] = newValue }
  }

  public var backgroundColor: GraphQLNullable<String> {
    get { __data["backgroundColor"] }
    set { __data["backgroundColor"] = newValue }
  }

  public var externalUrl: GraphQLNullable<String> {
    get { __data["externalUrl"] }
    set { __data["externalUrl"] = newValue }
  }

  public var offer: GraphQLNullable<[OfferInput?]> {
    get { __data["offer"] }
    set { __data["offer"] = newValue }
  }
}
