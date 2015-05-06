//
//  RepoTableViewCell.m
//  GithubReader
//
//  Created by Igor Iliyn on 5/4/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "RepoTableViewCell.h"

@implementation RepoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *) reuseIdentifier
{
    return @"CellRepo";
}

- (IBAction)forkRepoAction:(UIButton *)sender
{
    
}

- (IBAction)starRepoAction:(UIButton *)sender
{
    
}

@end
