
do the following after setting your viewControllers on the tabBarController:

1. ```#import "UITabBarController+SelectedTabBottomIndicator.h"```
2. set the color you want to use ```setSelectedBottomTabIndicatorColor```
2. call ```customizeToolbar``` method


```
[self.tabBarController setSelectedBottomTabIndicatorColor:[UIColor greenColor]];
[self.tabBarController customizeToolbar];
```

![Screenshot](/screenshots/greenBottomIndicator.png "Example")