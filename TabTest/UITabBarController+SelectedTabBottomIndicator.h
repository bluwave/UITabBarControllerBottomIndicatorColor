//
//  UITabBarController+ScramblsTabBarController.h
//  TabTest
//
//  Created by Garrett Richards on 6/19/13.
//
//

#import <UIKit/UIKit.h>

@interface UITabBarController (SelectedTabBottomIndicator)

@property(nonatomic, assign) CGFloat bottomIndicatorContainerHeight;

@property(nonatomic, strong) UIColor *selectedBottomTabIndicatorColor;

@property(nonatomic, strong) UIView * bottomSelectedTabIndicatorViewContainer;

-(void) customizeToolbar;

@end
