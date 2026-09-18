# swiftui-demo

SwiftUI 视图生命周期 & 前后台状态（scenePhase）示例工程。

## 说明
`onAppear` / `onDisappear` 由**视图树的插入与移除**驱动，App 退到后台**不会**触发 `onDisappear`；
监听前后台必须用 `@Environment(\.scenePhase)` 或 `UIApplication` 通知。

## 环境
- Xcode 26 / iOS 17+

## 运行
```bash
git clone https://github.com/rw02511911/swiftui-demo.git
cd swiftui-demo
open SwiftUIDemo.xcodeproj
```

## 目录
| 文件 | 内容 |
|---|---|
| `AppearDisappearDemo.swift` | 导航 / TabView / sheet 下的触发时机对比 |
| `ScenePhaseDemo.swift` | 前后台监听（active / inactive / background） |
| `EffectiveVisibilityModifier.swift` | 组合出「真正可见」的封装，可直接拷走用 |

## License
MIT
