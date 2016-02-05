//
//  BackgroundTask.m
//  Copyright (c) 2014 Lee Crossley - http://ilee.co.uk
//

#import "Cordova/CDV.h"
#import "Cordova/CDVViewController.h"
#import "BackgroundTask.h"

static UIBackgroundTaskIdentifier backgroundTaskId;

@implementation BackgroundTask

+ (void) initialize
{
    backgroundTaskId = UIBackgroundTaskInvalid;
}

- (void) end:(CDVInvokedUrlCommand*)command {
  NSLog(@"Ending Background Task %@", @(backgroundTaskId));
  [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskId];
  backgroundTaskId = UIBackgroundTaskInvalid;

  [self.commandDelegate runInBackground:^{
      CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
  }];

}

- (void) start:(CDVInvokedUrlCommand*)command;
{
    backgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskId];
        backgroundTaskId = UIBackgroundTaskInvalid;
    }];

    NSLog(@"Started Background Task %@", @(backgroundTaskId));
    NSLog(@"Remaining Time %@", @(UIApplication.sharedApplication.backgroundTimeRemaining));

    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
