import IdeaAPIDescriptor

// case API名 = その説明

@IdeaAPIDescriptor
enum FeatureForIdea: String, Codable, CaseIterable {
    case WatchKit = "Apple Watch用のアプリを作れるよ！"
    case WeatherKit = "天気の情報を使えるよ！"
    case Vision = "画像処理とかができるよ！"
    case API名 = "説明"
}

// 使い方
print(FeatureForIdea.WatchKit.name()) //WatchKit
print(FeatureForIdea.WeatherKit.description()) //天気の情報を使えるよ！
print(FeatureForIdea.from(name: "Vision")!.name()) //Vision
print(FeatureForIdea.from(name: "API名")!.description()) //説明
print(FeatureForIdea.allCases.randomElement()!)



