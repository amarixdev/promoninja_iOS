// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LiveSearchPodcastQuery: GraphQLQuery {
  public static let operationName: String = "LiveSearchPodcast"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query LiveSearchPodcast($input: String!) { liveSearchPodcast(input: $input) { __typename title publisher imageUrl } }"#
    ))

  public var input: String

  public init(input: String) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("liveSearchPodcast", [LiveSearchPodcast?]?.self, arguments: ["input": .variable("input")]),
    ] }

    public var liveSearchPodcast: [LiveSearchPodcast?]? { __data["liveSearchPodcast"] }

    /// LiveSearchPodcast
    ///
    /// Parent Type: `Podcast`
    public struct LiveSearchPodcast: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Podcast }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("title", String.self),
        .field("publisher", String?.self),
        .field("imageUrl", String?.self),
      ] }

      public var title: String { __data["title"] }
      public var publisher: String? { __data["publisher"] }
      public var imageUrl: String? { __data["imageUrl"] }
    }
  }
}
