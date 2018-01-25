//
//  LineView.m
//  SampleProject
//
//  Created by OpenIT on 2017. 1. 17..
//  Copyright © 2017년 OpenIT. All rights reserved.
//

#import "LineView.h"
#import "LineData.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation LineView

@synthesize maxValue;
@synthesize lineCount, lineDataArray;
@synthesize startDt, endDt;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat padding = leftLabel.frame.origin.y;
    CGFloat height = leftLabel.frame.size.height;

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //그래프 좌/우 vertical line 그리기
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xe0e0e0).CGColor);
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextMoveToPoint(context, leftLabel.frame.origin.x, height + padding);
    CGContextAddLineToPoint(context, leftLabel.frame.origin.x, 0);
    
    CGContextMoveToPoint(context, rightLabel.frame.origin.x, height + padding);
    CGContextAddLineToPoint(context, rightLabel.frame.origin.x, 0);
    
    CGContextStrokePath(context);
    
    //점섬 라인 그리기
//    CGContextRef dashContext = UIGraphicsGetCurrentContext();
//    CGFloat dash[] = {height - padding, 2};
//    CGContextSetLineDash(dashContext, 0, dash, 2); // nb "2" == ra count
//    //    CGContextSetLineCap(cx, kCGLineCapRound);
//    
//    CGContextMoveToPoint(dashContext, leftLabel.frame.origin.x + (269/4), height + padding);
//    CGContextAddLineToPoint(dashContext, leftLabel.frame.origin.x + (269/4), 0);
//    CGContextStrokePath(dashContext);
//    CGContextEndPage(dashContext);
    
    //선그리기
    for (int i = 0; i < lineCount; i++) {
        LineData *data = [lineDataArray objectAtIndex:i];
        double max = data.max;
        double min = data.min;
        
        max = height / maxValue * data.max + padding;
        min = height / maxValue * data.min + padding;
        
        CGContextSetStrokeColorWithColor(context, data.lineColor.CGColor);
        CGContextSetLineWidth(context, 3.0f);
        
        CGContextMoveToPoint(context, leftLabel.frame.origin.x, height - min + padding);
        CGContextAddLineToPoint(context, rightLabel.frame.origin.x, height - max + padding);
        
        CGContextStrokePath(context);
        
        //XLabel 글씨 표시
        CGFloat x = leftLabel.frame.origin.x;
        CGFloat h = 13.f;
        CGFloat y = height + padding + 6;
        
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.lineBreakMode = NSLineBreakByClipping;
        textStyle.alignment = NSTextAlignmentCenter;
        UIFont *textFont = [UIFont systemFontOfSize:11.0];
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName, nil];
        
        if (self.startDt != nil && self.startDt.length > 0) {
            CGFloat startDtWidth = [[[NSAttributedString alloc] initWithString:self.startDt attributes:attributes] size].width + 5;
            [self.startDt  drawInRect:CGRectMake(x, y, startDtWidth, h*2) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle, NSForegroundColorAttributeName:UIColorFromRGB(0xc1bfbc)}];
        }
        
        if (self.endDt != nil && self.endDt.length > 0) {
            CGFloat endDtWidth = [[[NSAttributedString alloc] initWithString:self.endDt attributes:attributes] size].width + 5;
            [self.endDt drawInRect:CGRectMake(rightLabel.frame.origin.x - endDtWidth, y, endDtWidth, h*2) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle, NSForegroundColorAttributeName:UIColorFromRGB(0xc1bfbc)}];
        }
        
        if (i+1 == lineCount) {
            //선 아래 투명 색상 영역
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, leftLabel.frame.origin.x, height - min + padding);
            CGContextAddLineToPoint(context, rightLabel.frame.origin.x, height - max + padding);  // mid right
            CGContextAddLineToPoint(context, rightLabel.frame.origin.x, height + padding);  // bottom left
            CGContextAddLineToPoint(context, leftLabel.frame.origin.x,  height + padding);  // bottom left
            CGContextClosePath(context);
            
            CGContextSetFillColorWithColor(context, [data.fillColor colorWithAlphaComponent:0.24].CGColor);
            CGContextFillPath(context);
        } else {
            LineData *secondData = [lineDataArray objectAtIndex:i+1];
            double secondMax = secondData.max;
            double secondMin = secondData.min;
            
            secondMax = height / maxValue * secondData.max + padding;
            secondMin = height / maxValue * secondData.min + padding;
            
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, leftLabel.frame.origin.x, height - min + padding);
            CGContextAddLineToPoint(context, rightLabel.frame.origin.x, height - max + padding);  // mid right
            CGContextAddLineToPoint(context, rightLabel.frame.origin.x, height - secondMax-1 + padding);  // bottom left
            CGContextAddLineToPoint(context, leftLabel.frame.origin.x,  height - secondMin-1 + padding);  // bottom left
            CGContextClosePath(context);

            CGContextSetFillColorWithColor(context, [data.fillColor colorWithAlphaComponent:0.24].CGColor);
            CGContextFillPath(context);
        }
        
        //이미지 표시
        UIImage *dotImg = data.dotImg;
        CGContextDrawImage(context, CGRectMake(leftLabel.frame.origin.x - 18.f, height - min + padding - 18.f, dotImg.size.width, dotImg.size.height), dotImg.CGImage);
        CGContextDrawImage(context, CGRectMake(rightLabel.frame.origin.x - 18.f, height - max + padding - 18.f, dotImg.size.width, dotImg.size.height), dotImg.CGImage);

        NSMutableParagraphStyle *leftTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        leftTextStyle.lineBreakMode = NSLineBreakByClipping;
        leftTextStyle.alignment = NSTextAlignmentRight;
        
        NSMutableParagraphStyle *rightTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        rightTextStyle.lineBreakMode = NSLineBreakByClipping;
        rightTextStyle.alignment = NSTextAlignmentLeft;

        //y축 글씨 표시
        self.minStr = data.minTitle;
        self.maxStr = data.maxTitle;
                
        y = height - min + padding - 7.5f;
        [self.minStr drawInRect:CGRectMake(leftLabel.frame.origin.x - (28.f + 15.f), y, 28.f, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:leftTextStyle, NSForegroundColorAttributeName:UIColorFromRGB(0xc1bfbc)}];
    
        y = height - max + padding - 7.5f;
        [self.maxStr drawInRect:CGRectMake(rightLabel.frame.origin.x + 15.f, y, 28.f, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:rightTextStyle, NSForegroundColorAttributeName:UIColorFromRGB(0xc1bfbc)}];
    }
}

@end
