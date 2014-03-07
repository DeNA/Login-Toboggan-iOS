/**
 * MBGBalanceImage.h
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MBGBalanceImage : UIImageView {
    
}
- (id)initWithFrame:(CGRect)frame
			  color:(UIColor *)color
		   fontSize:(NSInteger)size;

/*!
 * @abstract
 */
-(void) update;

@end
