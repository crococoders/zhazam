//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try font.validate()
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `testBlue`.
    static let testBlue = Rswift.ColorResource(bundle: R.hostingBundle, name: "testBlue")
    
    /// `UIColor(named: "testBlue", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func testBlue(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.testBlue, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 1 fonts.
  struct font: Rswift.Validatable {
    /// Font `AvenirNext-Regular`.
    static let avenirNextRegular = Rswift.FontResource(fontName: "AvenirNext-Regular")
    
    /// `UIFont(name: "AvenirNext-Regular", size: ...)`
    static func avenirNextRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: avenirNextRegular, size: size)
    }
    
    static func validate() throws {
      if R.font.avenirNextRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'AvenirNext-Regular' could not be loaded, is 'AvenirNext-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 2 images.
  struct image {
    /// Image `Image`.
    static let image = Rswift.ImageResource(bundle: R.hostingBundle, name: "Image")
    /// Image `jobs`.
    static let jobs = Rswift.ImageResource(bundle: R.hostingBundle, name: "jobs")
    
    /// `UIImage(named: "Image", bundle: ..., traitCollection: ...)`
    static func image(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.image, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "jobs", bundle: ..., traitCollection: ...)`
    static func jobs(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.jobs, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 2 localization keys.
    struct localizable {
      /// en translation: Hello %@
      /// 
      /// Locales: en, ru, uk
      static let testWithSymbol = Rswift.StringResource(key: "Test.withSymbol", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru", "uk"], comment: nil)
      /// en translation: Hello World
      /// 
      /// Locales: en, ru, uk
      static let test = Rswift.StringResource(key: "Test", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru", "uk"], comment: nil)
      
      /// en translation: Hello %@
      /// 
      /// Locales: en, ru, uk
      static func testWithSymbol(_ value1: String) -> String {
        return String(format: NSLocalizedString("Test.withSymbol", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// en translation: Hello World
      /// 
      /// Locales: en, ru, uk
      static func test(_: Void = ()) -> String {
        return NSLocalizedString("Test", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ViewController
      
      let bundle = R.hostingBundle
      let name = "Main"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
