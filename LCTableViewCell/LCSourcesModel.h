//
//  LCSourcesModel.h
//  LCTableViewCell
//
//  Created by 罗川 on 2017/7/31.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LCSourcesModel : NSObject
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *webAddressStr;
@property (nonatomic, strong) NSString *descriptionStr;
@property (nonatomic, strong) NSString *hasDownload;//是否已下载 1:已下载 0:未下载
@property (nonatomic, assign) CGFloat cellHeight;
@end
