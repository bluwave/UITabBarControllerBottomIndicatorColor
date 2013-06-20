//
//  UITabBarController+ScramblsTabBarController.m
//  TabTest
//
//  Created by Garrett Richards on 6/19/13.
//
//

#import <objc/runtime.h>
#import <CoreGraphics/CoreGraphics.h>
#import "UITabBarController+SelectedTabBottomIndicator.h"


@interface UITabBarController(BottomIndicatorColor)
@property(nonatomic, strong) NSArray *selectedTabIndicatorViews;
@end

@implementation UITabBarController (SelectedTabBottomIndicator)

static NSString *const kBottomIndicatorContainerHeight = @"BottomIndicatorContainerHeight";
static NSString *const kSelectedTabIndicatorColor = @"SelectedTabIndicatorColor";
static NSString *const kSelectedTabIndicatorViews = @"SelectedTabIndicatorViews";
static NSString *const kBottomSelectedTabIndicatorViewContainer = @"BottomSelectedTabIndicatorViewContainer";

-(void) customizeToolbar
{
    UITabBar *tabbar = self.tabBar;
    UIView *container = nil;
    int tabs =  [self.viewControllers count];
    CGFloat tabWidth = self.tabBar.bounds.size.width / tabs;
    CGFloat containerHeight = [self bottomIndicatorContainerHeight];
    CGRect rect = CGRectMake(0, 0, tabbar.superview.bounds.size.width, tabbar.bounds.size.height);


    rect.origin.y = tabbar.frame.origin.y + (rect.size.height - containerHeight);

    container = [[UIView alloc] initWithFrame:rect];

    [self setBottomSelectedTabIndicatorViewContainer:container];

    self.bottomSelectedTabIndicatorViewContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

    [self.tabBar.superview addSubview:self.bottomSelectedTabIndicatorViewContainer];

    self.bottomSelectedTabIndicatorViewContainer.backgroundColor = [UIColor clearColor];


    NSMutableArray * containerSubViews = [NSMutableArray array];
    for (int i = 0; i < tabs; i++)
    {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(tabWidth * i, 0, tabWidth, [self bottomIndicatorContainerHeight])];

//        v.autoresizingMask = UIViewAutoresizingFlexibleWidth ;//| UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;

        [v setBackgroundColor:[UIColor clearColor]];

        [containerSubViews addObject:v];

        [self.bottomSelectedTabIndicatorViewContainer addSubview:v];
    }

    [self setSelectedTabIndicatorViews:[containerSubViews copy]];

    [self toggleBottomTabSelectedIndicatorAtIndex:self.selectedIndex];


    //  register for notifications when a tab is selected
    [self addObserver:self forKeyPath:@"selectedViewController" options:NSKeyValueObservingOptionNew context:NULL];

}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"selectedViewController"])
    {
        [self toggleBottomTabSelectedIndicatorAtIndex:self.selectedIndex];
    }
}

-(void) toggleBottomTabSelectedIndicatorAtIndex:(NSInteger) index
{
    //  restore all tabs to clear color
    int cnt = [self.viewControllers count];
    for(int i = 0 ; i<cnt; i++)
    {
        UIView * v = [[self selectedTabIndicatorViews] objectAtIndex:i];
        [v setBackgroundColor:[UIColor clearColor]];
    }

    //  then set the selected tab to appropriate color
    UIView * v = [[self selectedTabIndicatorViews] objectAtIndex:index];
    [v setBackgroundColor:[self selectedBottomTabIndicatorColor]];

}


#pragma mark - getters and setters for new category properties

- (UIView *)bottomSelectedTabIndicatorViewContainer
{
    return objc_getAssociatedObject(self, &kBottomSelectedTabIndicatorViewContainer);
}

- (void)setBottomSelectedTabIndicatorViewContainer:(UIView *)bottomSelectedTabIndicatorViewContainer_
{
    objc_setAssociatedObject(self, &kBottomSelectedTabIndicatorViewContainer, bottomSelectedTabIndicatorViewContainer_, OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)bottomIndicatorContainerHeight
{
    NSNumber * val = objc_getAssociatedObject(self, &kBottomIndicatorContainerHeight);
    
    if(!val)
        return 0.75;

    return [val floatValue];
}

- (void)setBottomIndicatorContainerHeight:(CGFloat)BottomIndicatorContainerHeight
{
    objc_setAssociatedObject(self, &kBottomIndicatorContainerHeight, [NSNumber numberWithFloat:BottomIndicatorContainerHeight], OBJC_ASSOCIATION_ASSIGN);
}

- (UIColor*)selectedBottomTabIndicatorColor
{
    UIColor *col = objc_getAssociatedObject(self, &kSelectedTabIndicatorColor);
    if (!col)
        return [UIColor redColor];
    return col;
}

- (void)setSelectedBottomTabIndicatorColor:(UIColor*)SelectedBottomTabIndicatorColor
{
    objc_setAssociatedObject(self, &kSelectedTabIndicatorColor, SelectedBottomTabIndicatorColor, OBJC_ASSOCIATION_RETAIN);
}

- (NSArray*)selectedTabIndicatorViews
{
    return objc_getAssociatedObject(self, &kSelectedTabIndicatorViews);
}

- (void)setSelectedTabIndicatorViews:(NSArray *)SelectedTabIndicatorViews
{
    objc_setAssociatedObject(self, &kSelectedTabIndicatorViews, SelectedTabIndicatorViews, OBJC_ASSOCIATION_RETAIN);
}
@end
