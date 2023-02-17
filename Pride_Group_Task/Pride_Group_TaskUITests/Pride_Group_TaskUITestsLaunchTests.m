//
//  Pride_Group_TaskUITestsLaunchTests.m
//  Pride_Group_TaskUITests
//
//  Created by OLIVE on 15/02/2023.
//

#import <XCTest/XCTest.h>

@interface Pride_Group_TaskUITestsLaunchTests : XCTestCase

@end

@implementation Pride_Group_TaskUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end
