//
//  CZObjectWritePlist.swift
//  Random
//
//  Created by yu mingming on 2020/5/12.
//  Copyright © 2020 刘超正. All rights reserved.
//

import UIKit

class CZObjectStore: NSObject {
    static let standard = CZObjectStore()
    private override init() {}
    
    private let fileManager = FileManager()
    
    /// 将对象写入偏好设置
    /// - Parameters:
    ///   - object: 对象
    ///   - key: 自定义key
    public func cz_objectWriteUserDefault(object: Any, key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    /// 读取偏好设置中的对象
    /// - Parameters:
    ///   - key: 自定义key
    /// - Returns: 对象
    public func cz_readObjectInUserDefault(key: String) -> Any? {
        if let data = UserDefaults.standard.data(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: data)
        }
        return nil
    }
    
    
    /// 判断文件或文件夹是否存在
    /// - Parameter filePath: 文件路径
    /// - Returns: 是否存在
    public func cz_isFileExist(filePath: String) -> Bool {
        return fileManager.fileExists(atPath: filePath)
    }
    
    /// 创建文件夹
    /// - Parameter folderPath: 文件路径
    /// - Returns: 是否成功
    public func cz_createFolder(folderPath: String) -> Bool {
        if !cz_isFileExist(filePath: folderPath) {
            do {
                try fileManager.createDirectory(at: URL(fileURLWithPath: folderPath), withIntermediateDirectories: true,
                attributes: nil)
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    /// 数据归档
    /// - Parameters:
    ///   - object: 归档对象
    ///   - filePath: 文件路径
    /// - Returns: 是否成功
    public func cz_archiver(object: Any, filePath: String) -> Bool {
        return NSKeyedArchiver.archiveRootObject(object, toFile: filePath)
    }
    
    /// 数据解档
    /// - Parameter filePath: 文件路径
    /// - Returns: 解档对象
    public func cz_unarchiver(filePath: String) -> Any? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
    }
    
    /// 删除文件或者文件夹
    /// - Parameter filePath: 文件路径
    /// - Returns: 是否成功
    public func cz_removeFileOrFolder(filePath: String) -> Bool {
        do {
            try FileManager().removeItem(atPath: filePath)
            return true
        } catch  {
            return false
        }
    }
}
