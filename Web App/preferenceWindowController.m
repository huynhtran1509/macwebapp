//
//  preferenceWindowController.m
//  webapp
//
//  Created by Htain Lin Shwe on 5/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import "preferenceWindowController.h"
#import "Util.h"

@interface preferenceWindowController ()
@property(nonatomic,strong) NSString* URL;
@end

@implementation preferenceWindowController
@synthesize urlAddress = _urlAddress;
@synthesize URL = _URL;
- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
       
    }
    
    return self;
}

- (BOOL)windowShouldClose:(id)sender {
   
    if(![Util isEmpty:self.urlAddress.stringValue]) {
        
        
        [[NSUserDefaults standardUserDefaults] setObject:self.urlAddress.stringValue forKey:@"URL"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        if(![self.URL isEqualToString:self.urlAddress.stringValue]) {
            self.URL = self.urlAddress.stringValue;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadPage" object:nil];
        }

        return YES;
    }
    else {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:NSLocalizedString(@"URL can't be blank", @"")];
        [alert runModal];
        return NO;
    }

}

- (void)windowDidLoad
{
    [super windowDidLoad];
  
    // Initialization code here.
    if(![Util isEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:@"URL"]])
    {
        self.URL = [[NSUserDefaults standardUserDefaults] objectForKey:@"URL"];
    }
    else {
        NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
        self.URL = [dict objectForKey:@"URL"];
    }
    
    [self.urlAddress setStringValue:self.URL];
}

@end
