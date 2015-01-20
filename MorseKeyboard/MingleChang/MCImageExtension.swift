//
//  MCImageExtension.swift
//  Category_Swift
//
//  Created by admin001 on 14/12/2.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
extension UIImage{
    /*
    将image的缩小或者放大到size，不产生虚边和锯齿
    参数：
        size：CGSize，image设置后的尺寸大小
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetToSize(size:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let lResultImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return lResultImage;
    }
    /*
    将image的透明度设置为alpha
    参数：
        alpha：CGFloat，image设置的透明度
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetToAlpha(alpha:CGFloat)->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0);
        let ctx:CGContext = UIGraphicsGetCurrentContext();
        let area:CGRect = CGRectMake(0, 0, self.size.width, self.size.height);
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -area.size.height);
        CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
        CGContextSetAlpha(ctx, alpha);
        CGContextDrawImage(ctx, area, self.CGImage);
        let lResultImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return lResultImage;
    }
    /*
    将image进行缩放，宽度缩放比例为scaleW，高度缩放比例为scaleH
    参数：
        scaleW：CGFloat，image宽度缩放比例
        scaleH：CGFloat，image高度缩放比例
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetToScaleWidth(scaleW:CGFloat,andScaleWidth scaleH:CGFloat)->UIImage{
        let size:CGSize=CGSizeMake(self.size.width*scaleW, self.size.height*scaleH)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let lResultImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return lResultImage
    }
    /*
    将image进行宽度和高度的同比例缩放
    参数：
    scale：CGFloat，image缩放比例
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetToScale(scale:CGFloat)->UIImage{
        return self.resetToScaleWidth(scale, andScaleWidth: scale)
    }
    /*
    将image进行宽度缩放
    参数：
    scaleW：CGFloat，image宽度缩放比例
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetToScaleWidth(scaleW:CGFloat)->UIImage{
        return self.resetToScaleWidth(scaleW, andScaleWidth: 1.0)
    }
    /*
    将image进行高度缩放
    参数：
    scaleH：CGFloat，image高度缩放比例
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetToScaleHeight(scaleH:CGFloat)->UIImage{
        return self.resetToScaleWidth(1.0, andScaleWidth: scaleH)
    }
    /*
    为image的纹理区域设置颜色
    参数：
        color：UIColor，为image设置的颜色
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetWithColor(color:UIColor)->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx:CGContextRef = UIGraphicsGetCurrentContext()
        let area:CGRect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextScaleCTM(ctx, 1, -1)
        CGContextTranslateCTM(ctx, 0, -area.size.height)
        CGContextSaveGState(ctx)
        CGContextClipToMask(ctx, area, self.CGImage)
        color.set()
        CGContextFillRect(ctx, area)
        CGContextRestoreGState(ctx)
        CGContextSetBlendMode(ctx, kCGBlendModeMultiply)
        CGContextDrawImage(ctx, area, self.CGImage)
        let lResultImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return lResultImage
    }
    /*
    为image的设置遮罩
    参数：
        mask：UIImage，为image设置的遮罩
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetWithMask(mask:UIImage)->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx:CGContextRef = UIGraphicsGetCurrentContext()
        let area:CGRect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextScaleCTM(ctx, 1, -1)
        CGContextTranslateCTM(ctx, 0, -area.size.height)
        let maskRef:CGImageRef = mask.CGImage
        let maskImage:CGImageRef = CGImageMaskCreate(CGImageGetWidth(maskRef),CGImageGetHeight(maskRef),CGImageGetBitsPerComponent(maskRef),CGImageGetBitsPerPixel(maskRef),CGImageGetBytesPerRow(maskRef),CGImageGetDataProvider(maskRef), nil, false)
        let masked:CGImageRef = CGImageCreateWithMask(self.CGImage, maskImage)
        CGContextDrawImage(ctx, area, masked)
        let lResultImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return lResultImage
    }
    /*
    将image的纹理设置到区域rect，但image的尺寸不变，其他区域为透明
    参数：
        rect：CGRect，为image纹理设置的新的frame
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetToRect(rect:CGRect)->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        self.drawInRect(rect)
        let lResultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return lResultImage
    }
    /*
    将image的纹理偏移，但image的尺寸不变，其他区域为透明
    参数：
        offset：CGPoint，为image纹理设置偏移量
    返回值：UIImage，设置之后得到的UIImage对象
    */
    func resetToOffset(offset:CGPoint)->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        self.drawInRect(CGRectMake(offset.x, offset.y, self.size.width, self.size.height))
        let lResultImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return lResultImage
    }
}
//MARK:高斯模糊效果
extension UIImage{
    func applyBlurWithRadius(blurRadius:CGFloat,withTintColor tintColor:UIColor,withSaturationDeltaFactor saturationDeltaFactor:CGFloat,withMaskImage maskImage:UIImage?)->UIImage{
        let imageRect:CGRect = CGRectMake(0, 0, self.size.width, self.size.height)
        
        
        return UIImage();
    }
}