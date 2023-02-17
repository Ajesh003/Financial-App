//
//  HomeTableViewController.h
//  Pride_Group_Task
//
//  Created by OLIVE on 15/02/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *bidLabel;
@property (weak, nonatomic) IBOutlet UILabel *askLabel;
@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *icinLabel;
@property (strong, nonatomic) NSTimer *timer;

@end
NSMutableArray *iconStrArray;
NSMutableArray *symbolStrArray;
NSMutableArray *bidStrArray;
NSMutableArray *askStrArray;
NSMutableArray *colorStrBidArray;
NSMutableArray *colorStrAskArray;
NSMutableArray *tempbidEURUSDlArray;
NSMutableArray *tempbidArray;


NS_ASSUME_NONNULL_END
