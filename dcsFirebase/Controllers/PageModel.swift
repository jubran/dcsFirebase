//
//  PageModel.swift
//  figmaSwift
//
//  Created by جبران on 02/01/2024.
//


import Foundation
import SwiftUI

struct Page: Identifiable, Equatable {
    
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int

    
   

    
    static var samplePage = Page(name: "Title Example", description: "This is a sample description for the purpose of debugging", imageUrl: "work", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "اضافة ملاحظة", description: "إضافة ملاحظة فنية مهمة يتم تثبيتها في الواجهة الرئيسية للتطبيق مع امكانية تحديد زمن لانتهاء الحدث  او ملاحظة بسيطة تظهر في الاشعارات", imageUrl: "cowork", tag: 0),
        Page(name: "أولويات التشغيل ، القدرات المتاحة", description: "مشاهدة او تحديث أولويات التشغيل ، القدرات المتاحة للوحدات و المنقيات", imageUrl: "work", tag: 1),
        Page(name: "سجل الوردية", description: "إضافة الأحداث اليومية تشغيل - ايقاف - تحويل للوحدات ، المنقيات ، التفريغ ، خزانات الوقود", imageUrl: "website", tag: 2),
    ]
}
