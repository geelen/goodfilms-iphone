#import <UIKit/UIKit.h>
#import "Film.h"

@protocol AddRatingDelegate <NSObject>
- (void)rate:(Film *)film withQuality:(float)quality andRewatchability:(float)rewatchability;
@end

@interface AddRatingViewController : UIViewController

@property (readwrite, assign) id <AddRatingDelegate> delegate;
@property (readwrite, retain) Film *film;

@property (readwrite, retain) IBOutlet UISlider *quality;
@property (readwrite, retain) IBOutlet UISlider *rewatchability;
@property (retain, nonatomic) IBOutlet UILabel *filmTitle;
@property (retain, nonatomic) IBOutlet UILabel *qualityInfo;
@property (retain, nonatomic) IBOutlet UILabel *rewatchabilityInfo;
@property (retain, nonatomic) IBOutlet UIButton *rateIt;

@end
