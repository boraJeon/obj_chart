//
//  CubicCurveAlgorithm.m
//  SampleProject
//
//  Created by OpenIT on 2016. 12. 2..
//  Copyright © 2016년 OpenIT. All rights reserved.
//

#import "CubicCurveAlgorithm.h"

@implementation CubicCurveAlgorithm

- (id)init {
    self = [super init];
    
    if (self) {
        firstControlPoints = [[NSMutableArray alloc] init];
        secondControlPoints = [[NSMutableArray alloc] init];
    }
    
    return self;
}
- (NSMutableArray *) controlPointsFromPoints:(NSMutableArray *)dataPoints {
    //Number of Segments
    int count = (int)[dataPoints count] - 1;
    
    //P0, P1, P2, P3 are the points for each segment, where P0 & P3 are the knots and P1, P2 are the control points.
    if (count == 1) {
        CGPoint P0 = [dataPoints[0] CGPointValue];
        CGPoint P3 = [dataPoints[1] CGPointValue];
        //Calculate First Control Point
        //3P1 = 2P0 + P3
        
        CGFloat P1x = (2*P0.x + P3.x)/3;
        CGFloat P1y = (2*P0.y + P3.y)/3;
        [firstControlPoints addObject:[NSValue valueWithCGPoint:CGPointMake(P1x, P1y)]];
        
        //Calculate second Control Point
        //P2 = 2P1 - P0
        CGFloat P2x = (2*P1x - P0.x);
        CGFloat P2y = (2*P1y - P0.y);
        [secondControlPoints addObject:[NSValue valueWithCGPoint:CGPointMake(P2x, P2y)]];
    } else {
        firstControlPoints = [[NSMutableArray alloc] init];
        for (int i = 0; i < count; i++) {
            [firstControlPoints addObject:[NSValue valueWithCGPoint:CGPointZero]];
        }
        
        NSMutableArray *rhsArray = [[NSMutableArray alloc] init];
        //Array of Coefficients
        NSMutableArray *a = [[NSMutableArray alloc] init];
        NSMutableArray *b = [[NSMutableArray alloc] init];
        NSMutableArray *c = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < count; i++) {
            CGFloat rhsValueX = 0;
            CGFloat rhsValueY = 0;
            
            CGPoint P0 = [dataPoints[i] CGPointValue];
            CGPoint P3 = [dataPoints[i+1] CGPointValue];
            
            if (i==0) {
                [a addObject:[NSNumber numberWithDouble:0]];
                [b addObject:[NSNumber numberWithDouble:2]];
                [c addObject:[NSNumber numberWithDouble:1]];
                
                //rhs for first segment
                rhsValueX = P0.x + 2*P3.x;
                rhsValueY = P0.y + 2*P3.y;
            } else if (i == count-1) {
                [a addObject:[NSNumber numberWithDouble:2]];
                [b addObject:[NSNumber numberWithDouble:7]];
                [c addObject:[NSNumber numberWithDouble:0]];
                
                //rhs for last segment
                rhsValueX = 8*P0.x + P3.x;
                rhsValueY = 8*P0.y + P3.y;
            } else {
                [a addObject:[NSNumber numberWithDouble:1]];
                [b addObject:[NSNumber numberWithDouble:4]];
                [c addObject:[NSNumber numberWithDouble:1]];
                
                rhsValueX = 4*P0.x + 2*P3.x;
                rhsValueY = 4*P0.y + 2*P3.y;
            }

            [rhsArray addObject:[NSValue valueWithCGPoint:CGPointMake(rhsValueX, rhsValueY)]];
        }
        
        //Solve Ax=B. Use Tridiagonal matrix algorithm a.k.a Thomas Algorithm
        for (int i = 1; i < count; i++) {
            CGFloat rhsValueX = [rhsArray[i] CGPointValue].x;
            CGFloat rhsValueY = [rhsArray[i] CGPointValue].y;
            
            CGFloat prevRhsValueX = [rhsArray[i-1] CGPointValue].x;
            CGFloat prevRhsValueY = [rhsArray[i-1] CGPointValue].y;
            
            double m = [a[i] doubleValue]/[b[i-1] doubleValue];
            
            double b1 = [b[i] doubleValue] - m * [c[i-1] doubleValue];
            b[i] = [NSNumber numberWithDouble:b1];
            
            CGFloat r2x = rhsValueX - m * prevRhsValueX;
            CGFloat r2y = rhsValueY - m * prevRhsValueY;
            
//            [rhsArray addObject:[NSValue valueWithCGPoint:CGPointMake(r2x, r2y)]];
            [rhsArray replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:CGPointMake(r2x, r2y)]];
        }
        
        //Get First Control Points
        
        //Last control Point
        CGFloat lastControlPointX = [rhsArray[count-1] CGPointValue].x/[b[count-1] doubleValue];
        CGFloat lastControlPointY = [rhsArray[count-1] CGPointValue].y/[b[count-1] doubleValue];
        
        [firstControlPoints replaceObjectAtIndex:(count-1) withObject:[NSValue valueWithCGPoint:CGPointMake(lastControlPointX, lastControlPointY)]];
        
        for (int i = count-2; i>=0; i--) {            
            CGPoint nextControlPoint = [[firstControlPoints objectAtIndex:(i+1)] CGPointValue];
            
            CGFloat controlPointX = ([rhsArray[i] CGPointValue].x - [c[i] doubleValue] * nextControlPoint.x)/[b[i] doubleValue];
            CGFloat controlPointY = ([rhsArray[i] CGPointValue].y - [c[i] doubleValue] * nextControlPoint.y)/[b[i] doubleValue];
            
            [firstControlPoints replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:CGPointMake(controlPointX, controlPointY)]];
        }
        
        //Compute second Control Points from first
        for (int i = 0; i < count; i++) {
            if (i == count-1) {
                CGPoint P3 = [dataPoints[i+1] CGPointValue];
                CGPoint P1 = [firstControlPoints[i] CGPointValue];
                
                CGFloat controlPointX = (P3.x + P1.x)/2;
                CGFloat controlPointY = (P3.y + P1.y)/2;
                
                [secondControlPoints addObject:[NSValue valueWithCGPoint:CGPointMake(controlPointX, controlPointY)]];
            } else {
                CGPoint P3 = [dataPoints[i+1] CGPointValue];
                CGPoint nextP1 = [firstControlPoints[i+1] CGPointValue];
                
                CGFloat controlPointX = 2*P3.x - nextP1.x;
                CGFloat controlPointY = 2*P3.y - nextP1.y;
                
                [secondControlPoints addObject:[NSValue valueWithCGPoint:CGPointMake(controlPointX, controlPointY)]];
            }
        }
    }
    
    NSMutableArray *controlPoints = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        CGPoint firstControlPoint = [firstControlPoints[i] CGPointValue];
        CGPoint secondControlPoint = [secondControlPoints[i] CGPointValue];
        
        CubicCurveSegment *segment = [[CubicCurveSegment alloc] init];
        segment.controlPoint1 = firstControlPoint;
        segment.controlPoint2 = secondControlPoint;
        
        [controlPoints addObject:segment];
    }

    return controlPoints;
}

@end
