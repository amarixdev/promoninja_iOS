// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetTopPicksQuery: GraphQLQuery {
  public static let operationName: String = "GetTopPicks"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetTopPicks($input: TopPicksInput!) { getTopPicks(input: $input) { __typename title imageUrl publisher sponsors { __typename name imageUrl } category { __typename name } } }"#
    ))

  public var input: TopPicksInput

  public init(input: TopPicksInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getTopPicks", [GetTopPick?]?.self, arguments: ["input": .variable("input")]),
    ] }

    public var getTopPicks: [GetTopPick?]? { __data["getTopPicks"] }

    /// GetTopPick
    ///
    /// Parent Type: `Podcast`
    public struct GetTopPick: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Podcast }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("title", String.self),
        .field("imageUrl", String?.self),
        .field("publisher", String?.self),
        .field("sponsors", [Sponsor?]?.self),
        .field("category", [Category?]?.self),
      ] }

      public var title: String { __data["title"] }
      public var imageUrl: String? { __data["imageUrl"] }
      public var publisher: String? { __data["publisher"] }
      public var sponsors: [Sponsor?]? { __data["sponsors"] }
      public var category: [Category?]? { __data["category"] }

      /// GetTopPick.Sponsor
      ///
      /// Parent Type: `Sponsor`
      public struct Sponsor: PromoninjaSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Sponsor }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
          .field("imageUrl", String?.self),
        ] }

        public var name: String? { __data["name"] }
        public var imageUrl: String? { __data["imageUrl"] }
      }

      /// GetTopPick.Category
      ///
      /// Parent Type: `Category`
      public struct Category: PromoninjaSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Category }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
        ] }

        public var name: String? { __data["name"] }
      }
    }
  }
}
