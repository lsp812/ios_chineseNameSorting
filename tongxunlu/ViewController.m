//
//  ViewController.m
//  tongxunlu
//
//  Created by 大麦 on 16/3/15.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "ViewController.h"
#import "ChineseString.h"
@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) NSMutableArray *indexArray;
@property (nonatomic,strong) NSMutableArray *letterResultArr;
@property (nonatomic,strong) UITextField *textfield;
@property (nonatomic,strong) UITableView *tableV;

@end

@implementation ViewController

@synthesize nameArray,textfield;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self createTableView];
}

-(void)createTableView
{
    nameArray = [NSMutableArray array];
    [nameArray addObject:@"杨定甲"];
    [nameArray addObject:@"刘尧"];
    [nameArray addObject:@"王思聪"];
    [nameArray addObject:@"杨家将"];
    //
    textfield = [[UITextField alloc]init];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.frame = CGRectMake(40, 40, 200, 40);
    textfield.delegate = self;
    [self.view addSubview:textfield];
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(240, 40, 60, 40)];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //
    self.tableV = [[UITableView alloc]init];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.frame = CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height-100);
    [self.view addSubview:self.tableV];
    //
    self.indexArray = [ChineseString IndexArray:nameArray];
    self.letterResultArr = [ChineseString LetterSortArray:nameArray];
}
-(void)clickAction
{
    [self textFieldShouldReturn:textfield];
    //
    if(![textfield.text isEqualToString:@""])
    {
        [nameArray addObject:textfield.text];
        [self.indexArray removeAllObjects];
        [self.letterResultArr removeAllObjects];
        self.indexArray = [ChineseString IndexArray:nameArray];
        self.letterResultArr = [ChineseString LetterSortArray:nameArray];
        [self.tableV reloadData];
    }
    else
    {
        NSLog(@"不能是空");
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark --
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}
#pragma mark -
#pragma mark - UITableViewDelegate
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//    lab.backgroundColor = [UIColor grayColor];
//    lab.text = [self.indexArray objectAtIndex:section];
//    lab.textColor = [UIColor whiteColor];
//    return lab;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65.0;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"---->%@",[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                    message:[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]
//                                                   delegate:nil
//                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
//    [alert show];
//}


@end
