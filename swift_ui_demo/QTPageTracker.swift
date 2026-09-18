//
//  QTPageTracker.swift
//  swift_ui_demo
//
//  QTCommon 页面追踪 SwiftUI 插件
//  提供声明式接口，将 SwiftUI 视图与 QTCommon 手动页面采集对接。
//


import SwiftUI
import QTCommon

// MARK: - 静态方法

/// QTCommon 页面追踪器
///
/// 可在 SwiftUI 视图外部、按钮点击回调、网络请求回调等任意时机调用。
///
/// 用法示例：
/// ```swift
/// // 手动上报页面 PV
/// QTPageTracker.beginPage("home_page")
/// QTPageTracker.endPage("home_page")
///
/// // 任意时机更新页面属性（如按钮点击后）
/// QTPageTracker.updateProperties(["user_id": "12345"], forPage: "home_page")
/// ```
public enum QTPageTracker {

    // MARK: - 页面状态

    /// 逻辑上当前正在展示的页面（用于前后台恢复计时）
    private static var currentPageName: String?

    /// 是否处于后台状态
    private static var isInBackground = false

    // MARK: - 页面 PV

    /// 手动开始页面 PV 统计
    public static func beginPage(_ pageName: String) {
        currentPageName = pageName
        QTMobClick.beginLogPageView(pageName)
        #if DEBUG
        print("[QTPageTracker] begin page: \(pageName)")
        #endif
    }

    /// 手动结束页面 PV 统计
    public static func endPage(_ pageName: String) {
        if currentPageName == pageName {
            currentPageName = nil
        }
        QTMobClick.endLogPageView(pageName)
        #if DEBUG
        print("[QTPageTracker] end page: \(pageName)")
        #endif
    }

    /// 更新页面属性，可在任意时机调用
    ///
    /// - Parameters:
    ///   - properties: 页面自定义属性字典
    ///   - pageName: 页面编码（要和当前界面编码保持一致）
    public static func updateProperties(_ properties: [String: Any], forPage pageName: String) {
        guard !properties.isEmpty else { return }
        UMSpm.updatePageProperties(pageName, properties: properties)
        #if DEBUG
        print("[QTPageTracker] update properties for page: \(pageName), properties: \(properties)")
        #endif
    }

    // MARK: - 前后台切换

    /// App 进入后台：结束当前页面计时，避免后台时间被累计到页面浏览时长
    public static func appDidEnterBackground() {
        guard !isInBackground else { return }
        isInBackground = true
        if let pageName = currentPageName {
            QTMobClick.endLogPageView(pageName)
            #if DEBUG
            print("[QTPageTracker] end page (background): \(pageName)")
            #endif
        }
    }

    /// App 返回前台：根据逻辑当前页恢复页面计时
    public static func appWillEnterForeground() {
        guard isInBackground else { return }
        isInBackground = false
        if let pageName = currentPageName {
            QTMobClick.beginLogPageView(pageName)
            #if DEBUG
            print("[QTPageTracker] begin page (foreground): \(pageName)")
            #endif
        }
    }
}

// MARK: - 页面编码协议（用于规范页面编码定义）
/// 声明可被 QTCommon 追踪的页面编码
///
/// 可选协议，建议集中管理页面编码，减少拼写错误。
///
/// 用法示例：
/// struct HomeView: View {
/// >     var body: some View {
/// >         Text("首页")
/// >             .qtPage("home_page")
/// >     }
/// > }
public protocol QTPageTrackable {
    var qtPageName: String { get }
}

// MARK: - View Modifier
struct QTPageTrackModifier: ViewModifier {
    let pageName: String

    func body(content: Content) -> some View {
        content
            .onAppear {
                QTPageTracker.beginPage(pageName)
            }
            .onDisappear {
                QTPageTracker.endPage(pageName)
            }
    }
}

// MARK: - View Extensions
extension View {

    /// 为当前视图绑定一个 QTCommon 页面编码，自动在 onAppear/onDisappear 时上报 PV
    ///
    /// - Parameter name: 页面编码，如 `"home_page"`
    public func qtPage(_ name: String) -> some View {
        modifier(QTPageTrackModifier(pageName: name))
    }
}
