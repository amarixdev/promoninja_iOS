// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetPodcastCategoriesQuery: GraphQLQuery {
  public static let operationName: String = "GetPodcastCategories"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetPodcastCategories { getPodcastCategories { __typename name podcastId } }"#
    ))

  public init() {}

  public struct Data: PromoninjaSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getPodcastCategories", [GetPodcastCategory?]?.self),
    ] }

    public var getPodcastCategories: [GetPodcastCategory?]? { __data["getPodcastCategories"] }

    /// GetPodcastCategory
    ///
    /// Parent Type: `Category`
    public struct GetPodcastCategory: PromoninjaSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PromoninjaSchema.Objects.Category }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String?.self),
        .field("podcastId", [PromoninjaSchema.ID?]?.self),
      ] }

      public var name: String? { __data["name"] }
      public var podcastId: [PromoninjaSchema.ID?]? { __data["podcastId"] }
    }
  }
}
