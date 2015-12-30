//
//  RTScrollView.h
//  图片界面设计_2
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 Free_Shake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTScrollView : UIView
{
    void(^_getImage)(UIImage *);
}
@property (nonatomic) NSArray *imageArray;

-(void)setPassValue:(void(^)(UIImage *image))getImage;

@end
