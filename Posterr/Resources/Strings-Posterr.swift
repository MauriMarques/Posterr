// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// member since %@
  internal static func accountCreateionDateText(_ p1: Any) -> String {
    return L10n.tr("Localization", "account_createion_date_text", String(describing: p1), fallback: "member since %@")
  }
  /// Cancel
  internal static let cancelButtonTitle = L10n.tr("Localization", "cancel_button_title", fallback: "Cancel")
  /// Create
  internal static let createButtonTitle = L10n.tr("Localization", "create_button_title", fallback: "Create")
  /// %@/%@
  internal static func createPostsContentCounterText(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localization", "create_posts_content_counter_text", String(describing: p1), String(describing: p2), fallback: "%@/%@")
  }
  /// What's happening?
  internal static let createPostsContentPlaceholderText = L10n.tr("Localization", "create_posts_content_placeholder_text", fallback: "What's happening?")
  /// Sorry, you have reached the %@ posts per day limit. But no worries, you can continue by tomorrow.
  internal static func createPostsLimitReachedText(_ p1: Any) -> String {
    return L10n.tr("Localization", "create_posts_limit_reached_text", String(describing: p1), fallback: "Sorry, you have reached the %@ posts per day limit. But no worries, you can continue by tomorrow.")
  }
  /// Too many posts for today
  internal static let createPostsLimitReachedTitle = L10n.tr("Localization", "create_posts_limit_reached_title", fallback: "Too many posts for today")
  /// Quote
  internal static let createQuoteButtonTitle = L10n.tr("Localization", "create_quote_button_title", fallback: "Quote")
  /// Repost
  internal static let createRepostButtonTitle = L10n.tr("Localization", "create_repost_button_title", fallback: "Repost")
  /// Localization.strings
  ///   Posterr
  /// 
  ///   Created by Maurício Martinez Marques on 03/09/22.
  internal static let homeScreenTitle = L10n.tr("Localization", "home_screen_title", fallback: "Home")
  /// Ok
  internal static let okButtonTitle = L10n.tr("Localization", "ok_button_title", fallback: "Ok")
  /// posts: %@
  internal static func postsCountText(_ p1: Any) -> String {
    return L10n.tr("Localization", "posts_count_text", String(describing: p1), fallback: "posts: %@")
  }
  /// Nothing to show for now. 
  /// 
  /// 
  ///  Let's create some posts!
  internal static let postsEmptyText = L10n.tr("Localization", "posts_empty_text", fallback: "Nothing to show for now. \n\n\n Let's create some posts!")
  /// Profile
  internal static let profileScreenTtle = L10n.tr("Localization", "profile_screen_ttle", fallback: "Profile")
  /// quotes: %@
  internal static func quotesCountText(_ p1: Any) -> String {
    return L10n.tr("Localization", "quotes_count_text", String(describing: p1), fallback: "quotes: %@")
  }
  /// reposts: %@
  internal static func repostsCountText(_ p1: Any) -> String {
    return L10n.tr("Localization", "reposts_count_text", String(describing: p1), fallback: "reposts: %@")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
