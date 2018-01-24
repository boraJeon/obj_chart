//
//  CubicCurveAlgorithm.h
//  SampleProject
//
//  Created by OpenIT on 2016. 12. 2..
//  Copyright © 2016년 OpenIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CubicCurveSegment.h"

@interface CubicCurveAlgorithm : NSObject {
    NSMutableArray *firstControlPoints;
    NSMutableArray *secondControlPoints;
}

- (NSMutableArray *) controlPointsFromPoints:(NSMutableArray *)dataPoints;

@end
