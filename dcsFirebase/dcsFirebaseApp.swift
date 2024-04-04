//
//  dcsFirebaseApp.swift
//  dcsFirebase
//
//  Created by جبران on 13/01/2024.
//

import SwiftUI
import FirebaseCore
import SwiftData
private struct SafeAreaInsetsEnvironmentKey: EnvironmentKey {
    static let defaultValue: (top: CGFloat, bottom: CGFloat) = (0, 0)
}

extension EnvironmentValues {
    var safeAreaInsets: (top: CGFloat, bottom: CGFloat) {
        get { self[SafeAreaInsetsEnvironmentKey.self] }
        set { self[SafeAreaInsetsEnvironmentKey.self] = newValue }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
@main
struct dcsFirebaseApp: App {
   
    @State private var safeAreaInsets: (top: CGFloat, bottom: CGFloat) = (0, 0)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("log_status") var logStatus: Bool = false
    let container:ModelContainer = {
        let schema = Schema([ToDoItem.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    var body: some Scene {
        WindowGroup {
            if logStatus{
              
            ContentView()
                .environment(\.safeAreaInsets, safeAreaInsets)
                
            
            }else{
                LoginView()
            }
    }
    .modelContainer(container)
    }
}
