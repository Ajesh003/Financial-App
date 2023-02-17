//
//  HomeTableViewController.m
//  Pride_Group_Task
//
//  Created by OLIVE on 15/02/2023.
//

#import "HomeTableViewController.h"
#import "CustomTableViewCell.h"
#import "TimeLineChartVC.h"
@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

double timerInterval = 5.0f;

- (NSTimer *) timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:timerInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
    return _timer;
}


- (void)viewDidLoad {
    
    tempbidEURUSDlArray = [[NSMutableArray alloc] init];

    tempbidArray = [[NSMutableArray alloc] init];

    iconStrArray = [[NSMutableArray alloc]init];
    symbolStrArray = [[NSMutableArray alloc]init];
    bidStrArray = [[NSMutableArray alloc]init];
    askStrArray = [[NSMutableArray alloc]init];
    
    colorStrAskArray = [[NSMutableArray alloc]init];
    colorStrBidArray = [[NSMutableArray alloc]init];
      // Adding objects
    [iconStrArray addObject: @"C"];
    [iconStrArray addObject:@"C"];
    
    [symbolStrArray addObject: @"EURUSD"];
    [symbolStrArray addObject:@"GBPAUD"];
    
    [bidStrArray addObject: @"1.16258"];
    [bidStrArray addObject:@"1.81519"];
    
    [askStrArray addObject: @"1.16298"];
    [askStrArray addObject:@"1.81533"];
    
    [colorStrBidArray addObject: @""];
    [colorStrBidArray addObject:@""];
    
    [colorStrAskArray addObject: @""];
    [colorStrAskArray addObject:@""];
    

    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:(26.0f/255.0f) green:(103.0f/255.0f) blue:(159.0f/255.0f) alpha:1.0f];

  
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    
   // return [NSString stringWithFormat:@"%d",(int)from + arc4random() % (to-from+1)];
   return (int)from + arc4random() % (to-from+1);
}


-(void)timerAction:(NSTimer*)timer
{
  // NSMutableArray *bidStrArrayNew = [bidStrArray mutableCopy];

    
    for (int i = 0; i < bidStrArray.count; i++)
    {
        NSString *oldValueStr = [bidStrArray objectAtIndex:i];
        NSArray *OldvalueArray = [oldValueStr componentsSeparatedByString:@"."];
      
        NSString *OldDec = OldvalueArray[0];
       // NSString *OldafterDecStr = OldvalueArray[1];
        
        int OldafterDec = [[bidStrArray objectAtIndex:1]  intValue];
        int NewafterDec =0;
        
        int dynamicnumber = [self getRandomNumberBetween:11111 to:99999];
        
        NSString *dynamicnumberStr = [NSString stringWithFormat:@"%d", dynamicnumber];
        
        NSString *rise_and_fail_rate = [NSString stringWithFormat:@"0.%@%%", [dynamicnumberStr substringToIndex:2]];
        
        
        NSString *newvalueStr1 = [OldDec stringByAppendingString:@"."];
        
    
        if (dynamicnumber % 2 == 0)
        {
            NewafterDec = OldafterDec + dynamicnumber;
            
            [colorStrBidArray replaceObjectAtIndex:i withObject:@"green"];
            

            NSString* NewafterDecStr = [NSString stringWithFormat:@"%i", NewafterDec];

            NSString *NewafterDecStrRemove = [NewafterDecStr
               stringByReplacingOccurrencesOfString:@"-" withString:@""];

            NSString *newvalueStr2 = [newvalueStr1 stringByAppendingString:NewafterDecStrRemove];
            [bidStrArray replaceObjectAtIndex:i withObject:newvalueStr2];
   
            NSString *appendOperator_rise_and_fail_rate = [@"+" stringByAppendingString:[NSString stringWithFormat:@"%@",rise_and_fail_rate]];
          

            if(i == 0)
            {
                NSDictionary *lastEURUSDDict = [tempbidEURUSDlArray lastObject];
                
                double oldvalue = [[lastEURUSDDict valueForKey:@"last_px"]  doubleValue];

                double newvalue = [newvalueStr2  doubleValue];
                
                double avg_value = (oldvalue + newvalue) / 2;
                
                NSString *avg_price = [NSString stringWithFormat:@"%lf",avg_value];
                
                int last_volume_trade = [self getRandomNumberBetween:20000 to:99999];

                
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd/M hh:mm"];
                // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                
                NSString *date_time_stamp = [dateFormatter stringFromDate:[NSDate date]];
                
                [dateFormatter setDateFormat:@"HH:mm"];

                NSString *curr_time = [dateFormatter stringFromDate:[NSDate date]];

                NSMutableDictionary *mutableDictionary =  [[NSMutableDictionary alloc] init];

//
                int total_volume_trade = 0;

                
                for (NSDictionary * dic in tempbidEURUSDlArray) {
                    
                    total_volume_trade = total_volume_trade + [dic[@"last_volume_trade"]intValue];

                }
                
                int total_value_trade = 0;

                int rise_fall = [[dynamicnumberStr substringToIndex:2] intValue];
                
                total_value_trade =  total_value_trade + total_volume_trade + ((total_volume_trade * rise_fall) / 100);

                
                
                [mutableDictionary setValue:date_time_stamp forKey:@"date_time_stamp"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",last_volume_trade] forKey:@"last_volume_trade"];
                [mutableDictionary setValue:curr_time forKey:@"curr_time"];
                [mutableDictionary setValue:[lastEURUSDDict valueForKey:@"last_px"]  forKey:@"pre_close_px"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",total_value_trade] forKey:@"total_value_trade"];
                [mutableDictionary setValue:avg_price forKey:@"avg_price"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%@", appendOperator_rise_and_fail_rate] forKey:@"rise_and_fail_rate"];
                [mutableDictionary setValue:newvalueStr2 forKey:@"last_px"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",total_volume_trade] forKey:@"total_volume_trade"];
                [mutableDictionary setValue:@"green" forKey:@"color"];

                
                  [tempbidEURUSDlArray addObject:mutableDictionary];
                
            }
            
            else{
                NSDictionary *lastEURUSDDict = [tempbidArray lastObject];
                
                double oldvalue = [[lastEURUSDDict valueForKey:@"last_px"]  doubleValue];

                double newvalue = [newvalueStr2  doubleValue];
                
                double avg_value = (oldvalue + newvalue) / 2;
                
                NSString *avg_price = [NSString stringWithFormat:@"%lf",avg_value];
                
                int last_volume_trade = [self getRandomNumberBetween:20000 to:99999];

                
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd/M hh:mm"];
                // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                
                NSString *date_time_stamp = [dateFormatter stringFromDate:[NSDate date]];
                
                [dateFormatter setDateFormat:@"HH:mm"];

                NSString *curr_time = [dateFormatter stringFromDate:[NSDate date]];

                NSMutableDictionary *mutableDictionary =  [[NSMutableDictionary alloc] init];

//
                int total_volume_trade = 0;

                
                for (NSDictionary * dic in tempbidArray) {
                    
                    total_volume_trade = total_volume_trade + [dic[@"last_volume_trade"]intValue];

                }
                
                int total_value_trade = 0;

                int rise_fall = [[dynamicnumberStr substringToIndex:2] intValue];
                
                total_value_trade =  total_value_trade + total_volume_trade + ((total_volume_trade * rise_fall) / 100);

                
                
                [mutableDictionary setValue:date_time_stamp forKey:@"date_time_stamp"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",last_volume_trade] forKey:@"last_volume_trade"];
                [mutableDictionary setValue:curr_time forKey:@"curr_time"];
                [mutableDictionary setValue:[lastEURUSDDict valueForKey:@"last_px"]  forKey:@"pre_close_px"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",total_value_trade] forKey:@"total_value_trade"];
                [mutableDictionary setValue:avg_price forKey:@"avg_price"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%@", appendOperator_rise_and_fail_rate] forKey:@"rise_and_fail_rate"];
                [mutableDictionary setValue:newvalueStr2 forKey:@"last_px"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",total_volume_trade] forKey:@"total_volume_trade"];
                [mutableDictionary setValue:@"green" forKey:@"color"];

                
                  [tempbidArray addObject:mutableDictionary];
                
            }
            
          

            
        }
        else{
            NewafterDec = OldafterDec - dynamicnumber;
            
            [colorStrBidArray replaceObjectAtIndex:i withObject:@"red"];
            NSString* NewafterDecStr = [NSString stringWithFormat:@"%i", NewafterDec];

            NSString *NewafterDecStrRemove = [NewafterDecStr
               stringByReplacingOccurrencesOfString:@"-" withString:@""];

            NSString *newvalueStr2 = [newvalueStr1 stringByAppendingString:NewafterDecStrRemove];
            [bidStrArray replaceObjectAtIndex:i withObject:newvalueStr2];
            
            NSString *appendOperator_rise_and_fail_rate = [@"-" stringByAppendingString:[NSString stringWithFormat:@"%@",rise_and_fail_rate]];

            
            NSDictionary *lastEURUSDDict = [tempbidEURUSDlArray lastObject];
            
            double oldvalue = [[lastEURUSDDict valueForKey:@"last_px"]  doubleValue];
            
            double newvalue = [newvalueStr2  doubleValue];
            
            double avg_value = (oldvalue + newvalue) / 2;
            
            NSString *avg_price = [NSString stringWithFormat:@"%lf",avg_value];
            
            int last_volume_trade = [self getRandomNumberBetween:20000 to:99999];

            
            if(i == 0)
            {
                
                
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd/M hh:mm"];
                // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                
                NSString *date_time_stamp = [dateFormatter stringFromDate:[NSDate date]];
                
                [dateFormatter setDateFormat:@"HH:mm"];

                NSString *curr_time = [dateFormatter stringFromDate:[NSDate date]];

                NSMutableDictionary *mutableDictionary =  [[NSMutableDictionary alloc] init];
      
                int total_volume_trade = 0;

                
                for (NSDictionary * dic in tempbidEURUSDlArray) {
                    
                    total_volume_trade = total_volume_trade + [dic[@"last_volume_trade"]intValue];
                
                }
                
                int total_value_trade = 0;

                
                
                int rise_fall = [[dynamicnumberStr substringToIndex:2] intValue];
                
                total_value_trade =  total_value_trade + total_volume_trade + ((total_volume_trade * rise_fall) / 100);
                
                

                
                [mutableDictionary setValue:date_time_stamp forKey:@"date_time_stamp"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",last_volume_trade] forKey:@"last_volume_trade"];
                [mutableDictionary setValue:curr_time forKey:@"curr_time"];
                [mutableDictionary setValue:[lastEURUSDDict valueForKey:@"last_px"]  forKey:@"pre_close_px"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",total_value_trade] forKey:@"total_value_trade"];
                [mutableDictionary setValue:avg_price forKey:@"avg_price"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%@", appendOperator_rise_and_fail_rate] forKey:@"rise_and_fail_rate"];
                [mutableDictionary setValue:newvalueStr2 forKey:@"last_px"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",total_volume_trade] forKey:@"total_volume_trade"];
                [mutableDictionary setValue:@"green" forKey:@"color"];



                  [tempbidEURUSDlArray addObject:mutableDictionary];
            }
            else{
                
                
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd/M hh:mm"];
                // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                
                NSString *date_time_stamp = [dateFormatter stringFromDate:[NSDate date]];
                
                [dateFormatter setDateFormat:@"HH:mm"];

                NSString *curr_time = [dateFormatter stringFromDate:[NSDate date]];

                NSMutableDictionary *mutableDictionary =  [[NSMutableDictionary alloc] init];
      
                int total_volume_trade = 0;

                
                for (NSDictionary * dic in tempbidArray) {
                    
                    total_volume_trade = total_volume_trade + [dic[@"last_volume_trade"]intValue];
                
                }
                
                int total_value_trade = 0;

                
                
                int rise_fall = [[dynamicnumberStr substringToIndex:2] intValue];
                
                total_value_trade =  total_value_trade + total_volume_trade + ((total_volume_trade * rise_fall) / 100);
                
                

                
                [mutableDictionary setValue:date_time_stamp forKey:@"date_time_stamp"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",last_volume_trade] forKey:@"last_volume_trade"];
                [mutableDictionary setValue:curr_time forKey:@"curr_time"];
                [mutableDictionary setValue:[lastEURUSDDict valueForKey:@"last_px"]  forKey:@"pre_close_px"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",total_value_trade] forKey:@"total_value_trade"];
                [mutableDictionary setValue:avg_price forKey:@"avg_price"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%@", appendOperator_rise_and_fail_rate] forKey:@"rise_and_fail_rate"];
                [mutableDictionary setValue:newvalueStr2 forKey:@"last_px"];
                [mutableDictionary setValue:[NSString stringWithFormat:@"%d",total_volume_trade] forKey:@"total_volume_trade"];
                [mutableDictionary setValue:@"green" forKey:@"color"];



                  [tempbidArray addObject:mutableDictionary];
            }

        }
        
        
        
        
        
    }
    
    
    
    for (int i = 0; i < askStrArray.count; i++)
    {
      //  double oldvalue = [[askStrArray objectAtIndex:i]  doubleValue];
        NSString *oldValueStr = [askStrArray objectAtIndex:i];
        NSArray *OldvalueArray = [oldValueStr componentsSeparatedByString:@"."];
      
        NSString *OldDec = OldvalueArray[0];
       // NSString *OldafterDecStr = OldvalueArray[1];
        
        int OldafterDec = [[askStrArray objectAtIndex:1]  intValue];
        int NewafterDec =0;
        
        int dynamicnumberStr = [self getRandomNumberBetween:00000 to:99999];
        
        NSString *newvalueStr1 = [OldDec stringByAppendingString:@"."];
        

        
        if (dynamicnumberStr % 2 == 0)
        {
            NewafterDec = OldafterDec + dynamicnumberStr;
            
            [colorStrAskArray replaceObjectAtIndex:i withObject:@"green"];
            

            NSString* NewafterDecStr = [NSString stringWithFormat:@"%i", NewafterDec];
            
            
            NSString *NewafterDecStrRemove = [NewafterDecStr
               stringByReplacingOccurrencesOfString:@"-" withString:@""];

            NSString *newvalueStr2 = [newvalueStr1 stringByAppendingString:NewafterDecStrRemove];

            [askStrArray replaceObjectAtIndex:i withObject:newvalueStr2];

        }
        else{
            NewafterDec = OldafterDec - dynamicnumberStr;
            
            [colorStrAskArray replaceObjectAtIndex:i withObject:@"red"];
            NSString* NewafterDecStr = [NSString stringWithFormat:@"%i", NewafterDec];

            NSString *NewafterDecStrRemove = [NewafterDecStr
               stringByReplacingOccurrencesOfString:@"-" withString:@""];

            NSString *newvalueStr2 = [newvalueStr1 stringByAppendingString:NewafterDecStrRemove];
            [askStrArray replaceObjectAtIndex:i withObject:newvalueStr2];

        }
        
        [self.tableView reloadData];
    }
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [iconStrArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

      if (cell == nil) {
          cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
          

      }
    [[cell symbolLabel] setText:[symbolStrArray objectAtIndex:indexPath.row]];
    [[cell iconLabel] setText:[iconStrArray objectAtIndex:indexPath.row]];
    
    
    [[cell bigLabel] setText:[bidStrArray objectAtIndex:indexPath.row]];
    [[cell askLabel] setText:[askStrArray objectAtIndex:indexPath.row]];
    
    [[cell bigLabel] setBackgroundColor:([[colorStrBidArray objectAtIndex:indexPath.row] isEqual:@""])? [UIColor darkGrayColor] : (([[colorStrBidArray objectAtIndex:indexPath.row] isEqual:@"red"]) ? [UIColor colorWithRed:128/255.0 green:0/255.0 blue:32/255.0 alpha:1.0] : [UIColor colorWithRed:0/255.0 green:100/255.0 blue:0/255.0 alpha:1.0])];
    [[cell askLabel] setBackgroundColor:([[colorStrAskArray objectAtIndex:indexPath.row] isEqual:@""])? [UIColor darkGrayColor] : (([[colorStrAskArray objectAtIndex:indexPath.row] isEqual:@"red"]) ? [UIColor colorWithRed:128/255.0 green:0/255.0 blue:32/255.0 alpha:1.0] : [UIColor colorWithRed:0/255.0 green:100/255.0 blue:0/255.0 alpha:1.0])];

      return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

 
    if (indexPath.row == 0 && [tempbidEURUSDlArray count] > 0)
    {
        TimeLineChartVC *vc = [[TimeLineChartVC alloc] init];
        vc.tempbidEURUSDlArray = tempbidEURUSDlArray;
        
        [self presentViewController:vc animated:YES completion:nil];
  
        
        
    }
    else if([tempbidArray count] > 0){
        
        TimeLineChartVC *vc = [[TimeLineChartVC alloc] init];
        vc.tempbidEURUSDlArray = tempbidArray;
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle : @"Alert"
                                                                           message : @"Please wait for 5 seconds of intervel of time!"
                                                                    preferredStyle : UIAlertControllerStyleAlert];

           UIAlertAction * ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 { }];

           [alert addAction:ok];
           dispatch_async(dispatch_get_main_queue(), ^{
               [self presentViewController:alert animated:YES completion:nil];
           });

        
    }
   
    

    
}



@end








