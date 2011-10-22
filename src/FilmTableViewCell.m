#import "FilmTableViewCell.h"
#import "EGOImageView.h"

#define IMAGE_TAG 5555
#define TITLE_TAG (IMAGE_TAG+1)
#define SUBTITLE_TAG (IMAGE_TAG+2)

@implementation FilmTableViewCell

+ (UITableViewCell *)cellForFilmStub:(FilmStub *)stub forTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"FilmCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [self prepare:cell];
    }
    [self display:stub onCell:cell];    
    return cell;
}


+ (void)prepare:(UITableViewCell *)cell {    
    [[cell contentView] addSubview:^{
        EGOImageView *imageView = [[[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 90)] autorelease];
        imageView.placeholderImage = [UIImage imageNamed:@"45-movie-1.png"];
        imageView.tag = IMAGE_TAG;
        return imageView;
    }()];
    
    [[cell contentView] addSubview:^{
        UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(70, 25, 200, 20)] autorelease];
        l.tag = TITLE_TAG;
//        l.font = [UIFont boldSystemFontOfSize:18.0f];
        l.font = [UIFont fontWithName:@"Lato-Bold" size:18.0f];
        l.textColor = [UIColor whiteColor];
        l.backgroundColor = HEXCOLOR(0x333333ff);
        return l;
    }()];
    
    [[cell contentView] addSubview:^{
        UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(70, 45, 50, 20)] autorelease];
        l.tag = SUBTITLE_TAG;
//        l.font = [UIFont systemFontOfSize:18.0f];
                l.font = [UIFont fontWithName:@"Lato-Regular" size:18.0f];
        l.textColor = [UIColor grayColor];
        l.backgroundColor = HEXCOLOR(0x333333ff);
        return l;
    }()];
    
    cell.contentView.backgroundColor = HEXCOLOR(0x333333ff);
}

+ (void)prepareTableView:(UITableView *)tableView {
    tableView.backgroundColor = HEXCOLOR(0x333333ff);
    tableView.separatorColor = HEXCOLOR(0x555555ff);
}

+ (void)display:(FilmStub *)stub onCell:(UITableViewCell *)cell {
    EGOImageView *imageView = (EGOImageView *)[[cell contentView] viewWithTag:IMAGE_TAG];
    UILabel *titleLabel = (UILabel *)[[cell contentView] viewWithTag:TITLE_TAG];
    UILabel *subtitleLabel = (UILabel *)[[cell contentView] viewWithTag:SUBTITLE_TAG];
    
    titleLabel.text = stub.title;
    subtitleLabel.text = stub.year.description;
    imageView.imageURL = stub.imageURL;
}

+ (CGFloat)cellHeight {
    return 90.0f;
}
@end
