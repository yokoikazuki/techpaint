//
//  ViewController.m
//  techpaint
//
//  Created by 横井一樹 on 2015/02/22.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    canvas = [[UIImageView alloc] initWithImage:nil];
    canvas.backgroundColor = [UIColor whiteColor];
    canvas.frame = self.view.frame;
    [self.view insertSubview:canvas atIndex:0];
    
    rgb=0;
    
    keshigom.on = NO;
    
    [keshigom addTarget:self
                 action:@selector(switch_ValueChanged:)
       forControlEvents:UIControlEventValueChanged];
    
    seg.selectedSegmentIndex=0;
    
    [seg addTarget:self
            action:@selector(segment_ValueChanged:)
  forControlEvents:UIControlEventValueChanged];
}

- (void)segment_ValueChanged:(id)sender{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    switch(segment.selectedSegmentIndex){
        case 0:
            rgb = 0;
            break;
        case 1:
            rgb = 2;
            break;
        case 2:
            rgb = 3;
            break;
        case 3:
            rgb = 4;
            break;
    }
    keshigom.on = NO;
}

- (void)switch_ValueChanged:(id)sender{
    UISwitch *sw = sender;
    if (sw.on){
        rgb=1;
    }
    else{
        rgb=0;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:canvas];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:canvas];
    
    UIGraphicsBeginImageContext(canvas.frame.size);
    
    [canvas.image drawInRect:
     CGRectMake(0, 0, canvas.frame.size.width, canvas.frame.size.height)];

    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10.0);
    
    //CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    
    switch(rgb){
        case 0:
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
            break;
        case 1:
             CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
            break;
        case 2:
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
            break;
        case 3:
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 1.0, 0.0, 1.0);
            break;
        case 4:
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 1.0, 1.0);
            break;
        default:
            break;
    }
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), touchPoint.x, touchPoint.y);
    
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    touchPoint = currentPoint;
}

-(void)png{
    CGRect rect = canvas.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextFillRect(ctx, rect);
    [canvas.layer renderInContext:ctx];
    NSData *data = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext());
    capture = [UIImage imageWithData:data];
    UIGraphicsEndImageContext();
}

-(IBAction)save{
    [self png];
    UIImageWriteToSavedPhotosAlbum(capture,self,@selector(onCompleteCapture:didFinishSavingWithError:contextInfo:), NULL);
}

-(void)onCompleteCapture:(UIImage *)screenImage didFinishSavingWithError:(NSError *)error
    contextInfo:(void *)contextInfo{
    NSString *message = @"画像を保存しました。";
    if(error) message = @"保存に失敗しました\nError.";
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"確認"
                                         otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
