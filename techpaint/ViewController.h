//
//  ViewController.h
//  techpaint
//
//  Created by 横井一樹 on 2015/02/22.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

    UIImageView *canvas;
    
    CGPoint touchPoint;
    
    int rgb;
    
    IBOutlet UISwitch *keshigom;
    
    IBOutlet UISegmentedControl *seg;
    
    UIImage *capture;
}

- (IBAction)save;
- (void)png;

@end

