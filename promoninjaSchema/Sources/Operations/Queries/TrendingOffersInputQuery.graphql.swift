// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class TrendingOffersInputQuery: GraphQLQuery {
  public static let operationName: String = "TrendingOffersInput"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query TrendingOffersInput($input: TrendingOffersInput!) { getTrendingOffers(input: $input) { __typename imageUrl summary offer name } }"#
    ))

  public var input: TrendingOffersInput

  public init(input: TrendingOffersInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getTrendingOffers", [GetTrendingOffer?]?.self, arguments: ["input": .variable("input")]),
    ] }

    public var getTrendingOffers: [GetTrendingOffer?]? { __data["getTrendingOffers"] }

    /// GetTrendingOffer
    ///
    /// Parent Type: `Sponsor`
    public struct GetTrendingOffer: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Sponsor }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("imageUrl", String?.self),
        .field("summary", String?.self),
        .field("offer", String?.self),
        .field("name", String?.self),
      ] }

      public var imageUrl: String? { __data["imageUrl"] }
      public var summary: String? { __data["summary"] }
      public var offer: String? { __data["offer"] }
      public var name: String? { __data["name"] }
    }
  }
}
