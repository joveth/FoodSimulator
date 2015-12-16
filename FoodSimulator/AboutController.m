//
//  AboutController.m
//  Starve
//
//  Created by Shuwei on 15/10/28.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController{
    NSString *desc;
    UITextView *msg;
    MBProgressHUD *hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"About";
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.tableView.backgroundColor=[Common colorWithHexString:@"e0e0e0"];
    desc= @"Well,as it's a simple Recipes Simulator for The Don't Starve Game.And when I finished this project the new dlc was published.So ... maybe some days later there will be a new version.";
    hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.labelText = @"Sending...";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendBtn:)];
    rightItem.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem =rightItem;
}
-(IBAction)sendBtn:(id)sender{
    if([Common isEmptyString:msg.text]){
        return;
    }else{
        [msg resignFirstResponder];
        [hud show:YES];
        [self sendMsg];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return 3;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell    *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text=@"";
    cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines=0;
    if(indexPath.section==0){
        if(indexPath.row==0){
            cell.textLabel.text=@"Author jov";
        }
        if(indexPath.row==1){
            cell.textLabel.text=@"Q Q 247911950";
        }
        if(indexPath.row==2){
            cell.textLabel.text=@"Email funny_ba@163.com";
        }
    }else if(indexPath.section==1){
        cell.textLabel.text=desc;
    }else if(indexPath.section==2){
        msg = [[UITextView alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width-16, 120)];
        msg.delegate=self;
        msg.returnKeyType=UIReturnKeyDone;
        [cell addSubview:msg];
    }
    return cell;
}
//secltion head
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *myHeader = [[UIView alloc] init];
    UILabel *myLabel = [[UILabel alloc] init];
    [myLabel setFrame:CGRectMake(8, 5, 200, 20)];
    [myLabel setTag:101];
    [myLabel setAlpha:0.5];
    [myLabel setFont: [UIFont fontWithName:@"Arial" size:14]];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myHeader setBackgroundColor:[Common colorWithHexString:@"#e0e0e0"]];
    
    switch (section) {
        case 1:
            [myLabel setText:[NSString stringWithFormat:@"About Something"]];
            break;
        case 2:
            [myLabel setText:[NSString stringWithFormat:@"Send Message"]];
            break;
        default:
            [myLabel setText:[NSString stringWithFormat:@" "]];
            break;
    }
    [myHeader addSubview:myLabel];
    return myHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }
    return 22;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 44;
    }else if(indexPath.section==2){
        return 136;
    }
    CGSize size = [desc sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]] constrainedToSize:CGSizeMake(self.view.frame.size.width-16, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height+100;
}
-(void)sendMsg{
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    testMsg.fromEmail = @"funny_ba@163.com";
    testMsg.toEmail = @"funny_ba@163.com";
    testMsg.bccEmail = @"funny_ba@163.com";
    testMsg.relayHost = @"smtp.163.com";
    
    testMsg.requiresAuth = YES;
    
    if (testMsg.requiresAuth) {
        testMsg.login = @"funny_ba@163.com";
        testMsg.pass = @"funny_ba@163";
    }
    testMsg.wantsSecure = YES;
    testMsg.subject = @"IOS starve food Mail ";
    testMsg.delegate = self;
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               [NSString stringWithCString:[msg.text UTF8String] encoding:NSUTF8StringEncoding],kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    [testMsg send];
}
-(void)messageSent:(SKPSMTPMessage *)message{
    NSLog(@"%@",message);
    [hud hide:YES];
    [Common showMessageWithOkButton:@"Thank you !" andDelegate:self];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==12){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    NSLog(@"%@,err:%@",message,error);
    [hud hide:YES];
    [Common showMessageWithOkButton:@"Well, it's failed"];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if([Common isEmptyString:msg.text]){
            [msg resignFirstResponder];
            return YES;
        }else{
            [msg resignFirstResponder];
            [hud show:YES];
            [self sendMsg];
        }
        return NO;
    }
    return YES;
}

@end
