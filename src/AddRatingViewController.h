#import <UIKit/UIKit.h>
#import "Film.h"

@interface AddRatingViewController : UIViewController

@property (readwrite, retain) Film *film;

@property (readwrite, retain) IBOutlet UISlider *quality;
@property (readwrite, retain) IBOutlet UISlider *rewatchability;
@property (retain, nonatomic) IBOutlet UILabel *filmTitle;
@property (retain, nonatomic) IBOutlet UILabel *qualityInfo;
@property (retain, nonatomic) IBOutlet UILabel *rewatchabilityInfo;
@property (retain, nonatomic) IBOutlet UIButton *rateIt;

@end
