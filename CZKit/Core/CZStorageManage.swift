//
//  CZStorageManage.swift
//  letaoshijie
//
//  Created by udream3 on 2021/3/31.
//
import Foundation
import UIKit
import WebKit

public struct CZStorageManage {
    
    /// 将对象写入偏好设置
    /// - Parameters:
    ///   - object: 对象
    ///   - key: 自定义key
    public static func writeUserDefault(object: Any, key: String) -> Bool {
        var data: Data? = nil
        if #available(iOS 11.0, *) {
            guard let d = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true) else { return false }
            data = d
        } else {
            data = NSKeyedArchiver.archivedData(withRootObject: object)
        }
        guard data != nil else { return false }
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
        return true
    }
    
    /// 读取偏好设置中的对象
    /// - Parameters:
    ///   - key: 自定义key
    /// - Returns: 对象
    public static func readUserDefault(key: String) -> Any? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        guard let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) else { return nil }
        return object
    }
    
    /// 判断文件或文件夹是否存在
    /// - Parameter filePath: 文件路径
    /// - Returns: 是否存在
    public static func isFileExist(filePath: String) -> Bool {
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    /// 创建文件夹
    /// - Parameter folderPath: 文件路径
    /// - Returns: 是否成功
    public static func createFolder(folderPath: String) -> Bool {
        guard !isFileExist(filePath: folderPath) else { return false }
        guard let _ = try? FileManager.default.createDirectory(at: URL(fileURLWithPath: folderPath), withIntermediateDirectories: true, attributes: nil) else {
            return false
        }
        return true
    }
    
    /// 数据归档
    /// - Parameters:
    ///   - object: 归档对象
    ///   - filePath: 文件路径
    /// - Returns: 是否成功
    public static func archiver(object: Any, filePath: String) -> Bool {
        if #available(iOS 11.0, *) {
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true) else { return false }
            guard let _ = try? data.write(to: URL(fileURLWithPath: filePath)) else { return false }
            return true
        } else {
            return NSKeyedArchiver.archiveRootObject(object, toFile: filePath)
        }
    }
    
    /// 数据解档
    /// - Parameter filePath: 文件路径
    /// - Returns: 解档对象
    public static func unarchiver(filePath: String) -> Any? {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return nil }
        guard let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) else { return nil }
        return object
    }
    
    /// 删除文件或者文件夹
    /// - Parameter filePath: 文件路径
    /// - Returns: 是否成功
    public static func removeFileOrFolder(filePath: String) -> Bool {
        if let _ = try? FileManager.default.removeItem(atPath: filePath) { return true }
        return false
    }
    
    /// 获取文件夹中的指定文件名称数组
    /// - Parameters:
    ///   - folderPath: 文件夹路径
    ///   - filetype: 空/nil：获取文件中的所有文件 , 指定文件 例如.plist
    /// - Returns: 文件名称数组
    public static func getFolderSpecifyFlieNames(folderPath: String, fileType: String? = nil) -> [String] {
        guard let files = try? FileManager.default.contentsOfDirectory(atPath: folderPath) else { return [] }
        guard fileType != nil, fileType?.isEmpty == false else { return files }
        return files.filter{ $0.hasSuffix(fileType!) == true }
    }
    
    
    /// 获取缓存大小
    public static var cacheSize: Float {
        var totalSize: Float = 0.0
        guard isFileExist(filePath: CZApplicationManage.cachesPath) else { return totalSize }
        guard let childrenPath = FileManager.default.subpaths(atPath: CZApplicationManage.cachesPath) else { return totalSize }
        for path in childrenPath {
            let childPath = CZApplicationManage.cachesPath.appending("/").appending(path)
            if let attr: NSDictionary = try? FileManager.default.attributesOfItem(atPath: childPath) as NSDictionary {
                let fileSize = attr["NSFileSize"] as? Float ?? 0
                totalSize += fileSize
            }
        }
        return totalSize / 1024.0 / 1024.0
    }
    
    /// 清除缓存
    public static func removeCache(complete: @escaping (() -> Void)) {
        DispatchQueue.global().async {
            let files = FileManager.default.subpaths(atPath: CZApplicationManage.cachesPath) ?? []
            for file in files {
                let path = CZApplicationManage.cachesPath.appending("/\(file)")
                if isFileExist(filePath: path) { if let _ = try? FileManager.default.removeItem(atPath: path) {} }
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: { complete() })
        }
    }
    
    /// 删除所有偏好设置
    public static func removeAllUserDefault() -> Void {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    /// 删除指定key的偏好设置
    public static func removeObjectUserDefault(key: String) -> Void {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    /// 删除WKWebView缓存
    public static func removeWkWebViewCache() {
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: { (records) in
            for record in records{ WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {}) }
        })
    }
    
    /// 删除 LaunchScreen 缓存
    public static func removeLaunchScreenCache() -> Bool {
        guard let _ = try? FileManager.default.removeItem(atPath: NSHomeDirectory() + "/Library/SplashBoard") else { return false }
        return true
    }
}
