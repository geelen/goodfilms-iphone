#import "FilmTableViewCell.h"
#import "EGOImageView.h"

#define IMAGE_TAG 5555
#define TITLE_TAG (IMAGE_TAG+1)
#define SUBTITLE_TAG (IMAGE_TAG+2)

@implementation FilmTableViewCell

+ (void)prepare:(UITableViewCell *)cell {    
    [[cell contentView] addSubview:^{
        EGOImageView *imageView = [[[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 90)] autorelease];
        imageView.tag = IMAGE_TAG;
        return imageView;
    }()];
    
    [[cell contentView] addSubview:^{
        UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 20)] autorelease];
        l.tag = TITLE_TAG;
        l.font = [UIFont boldSystemFontOfSize:18.0f];
        return l;
    }()];
    
    [[cell contentView] addSubview:^{
        UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(270, 10, 50, 20)] autorelease];
        l.tag = SUBTITLE_TAG;
        l.font = [UIFont systemFontOfSize:18.0f];
        l.textColor = [UIColor grayColor];
        return l;
    }()];
}

+ (void)display:(FilmStub *)stub onCell:(UITableViewCell *)cell {
    EGOImageView *imageView = (EGOImageView *)[[cell contentView] viewWithTag:IMAGE_TAG];
    UILabel *titleLabel = (UILabel *)[[cell contentView] viewWithTag:TITLE_TAG];
    UILabel *subtitleLabel = (UILabel *)[[cell contentView] viewWithTag:SUBTITLE_TAG];
    
    titleLabel.text = stub.title;
    subtitleLabel.text = stub.year.description;
    imageView.imageURL = stub.imageURL;
}

@end
