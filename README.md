
do the following after setting your viewControllers on the tabBarController:

1. set the color you want to use
2. call ```customizeToolbar``` method


```
[self.tabBarController setSelectedBottomTabIndicatorColor:[UIColor greenColor]];
[self.tabBarController customizeToolbar];
```