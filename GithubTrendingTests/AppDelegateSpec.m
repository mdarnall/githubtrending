
#import "GithubTrendingAppDelegate.h"
#import "TrendingListViewController.h"

SpecBegin(AppDelegate)

describe(@"AppDelegate", ^{

    __block GithubTrendingAppDelegate *appDelegate;

    beforeAll(^{
    });
    
    beforeEach(^{
        appDelegate = [[GithubTrendingAppDelegate alloc] init];

    });

    describe(@"application:didFinishLaunchingWithOptions:", ^{

        beforeEach(^{
            [appDelegate application:nil didFinishLaunchingWithOptions:nil];
        });

        it(@"should set the root view controller", ^{
            expect(appDelegate.window.rootViewController).to.beKindOf([UINavigationController class]);
        });

        
        
    });
    

});

SpecEnd
