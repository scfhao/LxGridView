//
//  LxGridViewCell.m
//  LxGridView
//

#import "LxGridView.h"

static NSString * const kVibrateAnimation = @stringify(kVibrateAnimation);
static CGFloat const BADGE_HEIGHT = 20.0;
static CGFloat const DELETE_WIDTH = 30.0;

@interface LxGridViewCell ()

@end

@implementation LxGridViewCell
{
    UIButton * _deleteButton;
    UILabel * _titleLabel;
    UILabel *_badgeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setupEvents];
    }
    return self;
}

- (void)setup
{
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.layer.cornerRadius = ICON_CORNER_RADIUS;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    _badgeLabel = [UILabel new];
    _badgeLabel.layer.masksToBounds = YES;
    _badgeLabel.font = [UIFont boldSystemFontOfSize:12];
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.backgroundColor = [UIColor redColor];
    _badgeLabel.layer.cornerRadius = BADGE_HEIGHT / 2;
    _badgeLabel.layer.borderWidth = 1;
    _badgeLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_badgeLabel];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteButton setImage:[UIImage imageNamed:@"delete_collect_btn"] forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteButton];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"title";
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSLayoutConstraint * iconImageViewLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.iconImageView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint * iconImageViewRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.iconImageView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint * iconImageViewTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.iconImageView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint * iconImageViewHeightConstraint =
    [NSLayoutConstraint constraintWithItem:self.iconImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.iconImageView
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1
                                  constant:0];
    
    [self.contentView addConstraints:@[iconImageViewLeftConstraint,iconImageViewRightConstraint,iconImageViewTopConstraint,iconImageViewHeightConstraint]];
    
    NSLayoutConstraint * deleteButtonTopConstraint =
    [NSLayoutConstraint constraintWithItem:_deleteButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.iconImageView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:-_deleteButton.currentImage.size.height/2];
    
    NSLayoutConstraint * deleteButtonLeftConstraint =
    [NSLayoutConstraint constraintWithItem:_deleteButton
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.iconImageView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:-_deleteButton.currentImage.size.width/2];
    
    NSLayoutConstraint * deleteButtonWidthConstraint =
    [NSLayoutConstraint constraintWithItem:_deleteButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1
                                  constant:DELETE_WIDTH];
    
    NSLayoutConstraint * deleteButtonHeightConstraint =
    [NSLayoutConstraint constraintWithItem:_deleteButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1
                                  constant:DELETE_WIDTH];

    [self.contentView addConstraints:@[deleteButtonLeftConstraint,deleteButtonTopConstraint,deleteButtonWidthConstraint,deleteButtonHeightConstraint]];
    
    NSLayoutConstraint * badgeLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:_badgeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:-BADGE_HEIGHT/2];
    
    NSLayoutConstraint * badgeLabelRightConstraint =
    [NSLayoutConstraint constraintWithItem:_badgeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:BADGE_HEIGHT/2];
    
    NSLayoutConstraint * badgeLabelHeightConstraint =
    [NSLayoutConstraint constraintWithItem:_badgeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:BADGE_HEIGHT];
    
    NSLayoutConstraint * badgeLabelWidthConstraint =
    [NSLayoutConstraint constraintWithItem:_badgeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:BADGE_HEIGHT];
    
    [self.contentView addConstraints:@[badgeLabelTopConstraint, badgeLabelRightConstraint, badgeLabelHeightConstraint, badgeLabelWidthConstraint]];
    
    NSLayoutConstraint * centerXConstraint =
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.iconImageView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint * titleLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.iconImageView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:3];
    
    NSLayoutConstraint * titleLabelWidthConstraint =
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.iconImageView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint * titleLabelHeightConstraint =
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1
                                  constant:15];
    
    [self.contentView addConstraints:@[centerXConstraint, titleLabelTopConstraint, titleLabelWidthConstraint, titleLabelHeightConstraint]];
}

- (void)setupEvents
{
    [_deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconImageView.userInteractionEnabled = YES;
}

- (void)deleteButtonClicked:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(deleteButtonClickedInGridViewCell:)]) {
        [self.delegate deleteButtonClickedInGridViewCell:self];
    }
}

- (BOOL)editing
{
    return !_deleteButton.hidden;
}

- (void)setEditing:(BOOL)editing
{
    _deleteButton.hidden = !editing;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (NSString *)title
{
    return _titleLabel.text;
}

- (void)setBadge:(NSInteger)badge {
    _badgeLabel.text = @(badge).stringValue;
    _badgeLabel.hidden = badge == 0;
}

- (UIView *)snapshotView
{
    UIView * snapshotView = [[UIView alloc]init];
    
    UIView * cellSnapshotView = nil;
    UIView * deleteButtonSnapshotView = nil;
    UIView * badgeLabelSnapshotView = nil;
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
    }
    else {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
    }
    
    if ([_deleteButton respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        deleteButtonSnapshotView = [_deleteButton snapshotViewAfterScreenUpdates:NO];
    }
    else {
        UIGraphicsBeginImageContextWithOptions(_deleteButton.bounds.size, _deleteButton.opaque, 0);
        [_deleteButton.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * deleteButtonSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        deleteButtonSnapshotView = [[UIImageView alloc]initWithImage:deleteButtonSnapshotImage];
    }
    
    if ([_badgeLabel respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        badgeLabelSnapshotView = [_badgeLabel snapshotViewAfterScreenUpdates:NO];
    }
    else {
        UIGraphicsBeginImageContextWithOptions(_badgeLabel.bounds.size, _badgeLabel.opaque, 0);
        [_badgeLabel.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *badgeLableSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        badgeLabelSnapshotView = [[UIImageView alloc]initWithImage:badgeLableSnapshotImage];
    }
    
    snapshotView.frame = CGRectMake(-deleteButtonSnapshotView.frame.size.width / 2,
                                    -deleteButtonSnapshotView.frame.size.height / 2,
                                    deleteButtonSnapshotView.frame.size.width / 2 + cellSnapshotView.frame.size.width + badgeLabelSnapshotView.frame.size.width / 2,
                                    badgeLabelSnapshotView.frame.size.height / 2 + cellSnapshotView.frame.size.height);
    cellSnapshotView.frame = CGRectMake(deleteButtonSnapshotView.frame.size.width / 2,
                                        deleteButtonSnapshotView.frame.size.height / 2,
                                        cellSnapshotView.frame.size.width,
                                        cellSnapshotView.frame.size.height);
    deleteButtonSnapshotView.frame = CGRectMake(0, CGRectGetHeight(badgeLabelSnapshotView.frame) / 2 - CGRectGetHeight(deleteButtonSnapshotView.frame) / 2 + 2,
                                                deleteButtonSnapshotView.frame.size.width,
                                                deleteButtonSnapshotView.frame.size.height);
    
    badgeLabelSnapshotView.frame = CGRectMake(CGRectGetWidth(cellSnapshotView.frame) + CGRectGetWidth(deleteButtonSnapshotView.frame) / 2 - CGRectGetWidth(badgeLabelSnapshotView.frame) / 2 - 1, 2, CGRectGetWidth(badgeLabelSnapshotView.frame), CGRectGetHeight(badgeLabelSnapshotView.frame));
    badgeLabelSnapshotView.hidden = _badgeLabel.hidden;
    [snapshotView addSubview:cellSnapshotView];
    [snapshotView addSubview:deleteButtonSnapshotView];
    [snapshotView addSubview:badgeLabelSnapshotView];
    
    return snapshotView;
}

@end
