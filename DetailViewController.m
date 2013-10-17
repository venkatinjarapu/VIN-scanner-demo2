//
//  DetailViewController.m
//  BlinkerMobileIOS
//
//  Created by ankit gupta on 9/16/13.
//  Copyright (c) 2013 Kreeti Technologies. All rights reserved.
//

#import "DetailViewController.h"
#import "SellMyCarViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
      [scrollview setContentSize:CGSizeMake(320, 650)];
   // [self.view addSubview:scrollview];
	// Do any additional setup after loading the view.
}
-(IBAction)submitCarDescription:(UIButton *) sender
{
    
    
    if (txt_view.text.length==0) {
        UIAlertView *a=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter car description" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [a show];
        
        return;
    }
    
    UIActivityViewController *activityVC=[[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:txt_view.text] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
    
    
    
    [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         NSLog(@"Activity = %@",activityType);
         NSLog(@"Completed Status =%d",completed);
         
         
         if (completed) {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Posting Was Success" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
             [alert show];
             alert=nil;
             
             [self.navigationController popViewControllerAnimated:YES];
             
         }else
         {
             
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Posting was not success" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
             [alert1 show];
             alert1=nil;
             
         }
         
         
     }];
}




-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:     (NSString *)text

{
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
    
}


- (void) textViewDidEndEditing:(UITextView*)textView{
    [textView resignFirstResponder];
}

-(BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
