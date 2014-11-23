//
//  MainViewController.m
//  project4
//
//  Created by xuyouyang on 14/11/23.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "MainViewController.h"
#import "TextViewController.h"
#import "DB.h"
#import "Note.h"

@interface MainViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) NSMutableArray *notes;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    self.notes = [Note getAllNotes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"note" forIndexPath:indexPath];
    cell.textLabel.text = ((Note *)[self.notes objectAtIndex:indexPath.row]).title;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addText"]) {
        NSLog(@"add");
        TextViewController *textVC = [segue destinationViewController];
        textVC.note = nil;
    }
    if ([segue.identifier isEqualToString:@"editText"]) {
        NSLog(@"edit");
        NSInteger index = [self.tableView indexPathForCell:(UITableViewCell *)sender].row;
        TextViewController *textVC = [segue destinationViewController];
        textVC.note = [self.notes objectAtIndex:index];
    }
}

- (IBAction)addNote:(id)sender {
    UIActionSheet *addNoetActionSheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"文字", @"照片", @"绘图", nil];
    [addNoetActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            NSLog(@"文字");
            [self performSegueWithIdentifier:@"addText" sender:self];
            break;
        case 1:
            NSLog(@"照片");
            // 调用相机
            break;
        case 2:
            NSLog(@"绘图");
            [self performSegueWithIdentifier:@"draw" sender:self];
            break;
    }
}
@end
