//
//  CZPhotoManager.swift
//  UdreamPlus
//
//  Created by udream3 on 2021/3/26.
//  Copyright © 2021 chaozheng. All rights reserved.
//

import Foundation
import UIKit
import Photos

public struct CZPhotoManager {
    
    /// 保存图片到相册
    public static func saveImageToAlbum(image: UIImage, completion: ( (Bool, PHAsset?) -> Void )? ) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        if status == .denied || status == .restricted {
            completion?(false, nil)
            return
        }
        var placeholderAsset: PHObjectPlaceholder? = nil
        PHPhotoLibrary.shared().performChanges({
            let newAssetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            placeholderAsset = newAssetRequest.placeholderForCreatedAsset
        }) { (suc, error) in
            DispatchQueue.main.async {
                if suc {
                    let asset = getAsset(from: placeholderAsset?.localIdentifier)
                    completion?(suc, asset)
                } else {
                    completion?(false, nil)
                }
            }
        }
    }
    
    /// 保存视频到相册
    public static func saveVideoToAlbum(url: URL, completion: ( (Bool, PHAsset?) -> Void )? ) {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .denied || status == .restricted {
            completion?(false, nil)
            return
        }
        var placeholderAsset: PHObjectPlaceholder? = nil
        PHPhotoLibrary.shared().performChanges({
            let newAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
            placeholderAsset = newAssetRequest?.placeholderForCreatedAsset
        }) { (suc, error) in
            DispatchQueue.main.async {
                if suc {
                    let asset = getAsset(from: placeholderAsset?.localIdentifier)
                    completion?(suc, asset)
                } else {
                    completion?(false, nil)
                }
            }
        }
    }
    
    private static func getAsset(from localIdentifier: String?) -> PHAsset? {
        guard let id = localIdentifier else { return nil }
        let result = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil)
        return result.firstObject
    }
    
    /// 视频格式转换
    /// - Parameters:
    ///   - asset: AVAsset
    ///   - storagePath: 转码成功保存的路径 CZCommon.cz_tmpPath + "\(fileName).mp4"
    ///   - outputFileType: 转码后的格式
    ///   - presetName: 视频压缩质量
    ///   1、AVAssetExportPreset640x480：设置视频分辨率640x480
    ///   2、 AVAssetExportPreset960x540：设置视频分辨率960x540
    ///   3、AVAssetExportPreset1280x720：设置视频分辨率1280x720
    ///   4、AVAssetExportPreset1920x1080：设置视频分辨率1920x1080
    ///   5、AVAssetExportPreset3840x2160：设置视频分辨率3840x2160
    ///   6、AVAssetExportPresetLowQuality：低质量
    ///   7、AVAssetExportPresetMediumQuality：中等质量
    ///   8、AVAssetExportPresetHighestQuality：高质量
    ///   - completion: 转换完成回调
    public static func localVideoTranscode(asset: AVAsset, storagePath: String, outputFileType: AVFileType = .mp4, presetName: String = AVAssetExportPresetMediumQuality, completion: @escaping (_ filePath: String) -> Void) {
        let newVideoPath = URL(fileURLWithPath: storagePath)
        let exporter = AVAssetExportSession(asset: asset, presetName: presetName)!
        exporter.outputURL = newVideoPath
        exporter.outputFileType = outputFileType
        exporter.shouldOptimizeForNetworkUse = true
        exporter.exportAsynchronously(completionHandler: {
            completion(newVideoPath.relativePath)
        })
    }
    
    /// 获取mp4视频首帧图片
    public static func getMp4VideoFirstPicture(url: String) -> UIImage? {
        guard let videoURL = URL(string: url)  else { return nil }
        let avAsset = AVURLAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(1, preferredTimescale: 1)
        var actualTime:CMTime = CMTimeMake(value: 0,timescale: 0)
        guard let imageRef:CGImage = try? generator.copyCGImage(at: time, actualTime: &actualTime) else { return nil }
        return UIImage(cgImage: imageRef)
    }
}
