//
//  HomeTableViewController.m
//  Pride_Group_Task
//
//  Created by OLIVE on 15/02/2023.
//
#import "TimeLineChartVC.h"
#import "XMLineChart.h"

@interface TimeLineChartVC ()<XMLineChartViewDelegate>

@property (strong, nonatomic) XMTimeLineView *timeLineView;

@end


@implementation TimeLineChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self creatUI];
    
    

}



- (void)creatUI{
    self.timeLineView = [[XMTimeLineView alloc] init];
    [self.timeLineView setupChartOffsetWithLeft:40 top:10 right:40 bottom:10];
    self.timeLineView.gridBackgroundColor = [UIColor whiteColor];
    self.timeLineView.borderColor = QXMHex2Rgb(0xf6f6f6, 1);
    self.timeLineView.borderWidth = .5;
    self.timeLineView.uperChartHeightScale = 0.7;
    self.timeLineView.xAxisHeitht = 25;
    self.timeLineView.countOfTimes = 190;
    self.timeLineView.endPointShowEnabled = YES;
        //self.timeLineView.leftYAxisIsInChart = YES;
    self.timeLineView.rightYAxisDrawEnabled = YES;
    self.timeLineView.delegate = self;
    self.timeLineView.highlightLineShowEnabled = YES;
    self.timeLineView.isDrawAvgEnabled  = YES;
    
    self.timeLineView.offsetMaxPrice = 1.9;
    self.timeLineView.minPrice = 1.0;
   
    self.timeLineView.frame = CGRectMake(10, 100, self.view.bounds.size.width - 2 * 10, 300);
    [self.view addSubview:self.timeLineView];
    
    
    



    //    赋值
//    NSString * path =[[NSBundle mainBundle]pathForResource:@"data.plist" ofType:nil];
//    NSArray * sourceArray = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"data3"];
    NSMutableArray * timeArray = [NSMutableArray array];
    
    

    for (NSDictionary * dic in _tempbidEURUSDlArray) {
        XMTimeLineEntity * e = [[XMTimeLineEntity alloc]init];
        
        //        当前时间
        e.currtTime = dic[@"curr_time"];
        
        e.preClosePx = [dic[@"pre_close_px"] doubleValue];
        
        e.avgPirce = [dic[@"avg_pirce"] doubleValue];
        
        e.lastPirce = [dic[@"last_px"]doubleValue];
        
        e.volume = [dic[@"last_volume_trade"]doubleValue];
        
        e.rate = dic[@"rise_and_fall_rate"];
        e.totalVolume = [dic[@"total_volume_trade"]doubleValue];
        
        
        [timeArray addObject:e];
    }
    XMTimeDataset * set  = [[XMTimeDataset alloc]init];
    set.data = timeArray;
    set.avgLineCorlor = [UIColor colorWithRed:253/255.0 green:179/255.0 blue:8/255.0 alpha:1.0];
    set.priceLineCorlor = QXMHex2Rgb(0x4CB1FF,1);
    set.lineWidth = 1.f;
    set.highlightLineWidth = .8f;
    set.highlightLineColor = [UIColor colorWithRed:60/255.0 green:76/255.0 blue:109/255.0 alpha:1.0];
    
    set.volumeTieColor = [UIColor grayColor];
    set.volumeRiseColor = QXMHex2Rgb(0xff5353, 1);
    set.volumeFallColor = QXMHex2Rgb(0x00b07c, 1);
    set.fillStartColor =  QXMHex2Rgb(0x4CB1FF,1);
    set.fillStopColor = QXMHex2Rgb(0x4CB1FF,0.5);
    set.fillAlpha = .5f;
    set.drawFilledEnabled = YES;
    
    NSDictionary * dic_firstobj  = [_tempbidEURUSDlArray firstObject];
    NSDictionary * dic_lastobj  = [_tempbidEURUSDlArray lastObject];

    
    
    NSString *firstcolumnRemovetime = [dic_firstobj[@"curr_time"]
       stringByReplacingOccurrencesOfString:@":" withString:@"."];
    
    NSString *secoundcolumnRemovetime = [dic_lastobj[@"curr_time"]
       stringByReplacingOccurrencesOfString:@":" withString:@"."];
    
    double fsttime = [firstcolumnRemovetime doubleValue];
    
    double lsttime = [secoundcolumnRemovetime  doubleValue];
    double midtime = (fsttime + lsttime) / 2;
    

    NSString *midtimeStr = [NSString stringWithFormat:@"%.2f",midtime];

    
    
    set.firsttime = dic_firstobj[@"curr_time"];
    
    NSString *midtimeStr2 = [midtimeStr stringByReplacingOccurrencesOfString:@"." withString:@":"];
    
    set.midtime =  [NSString stringWithFormat:@"%@",midtimeStr2];
    set.lasttime = dic_lastobj[@"curr_time"];
    
    
    
    
     
    
    [self.timeLineView setupData:set];
}



-(void)getBetweenDates:(NSDate *)startDate andEndDate:(NSDate *)endDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offset = [[NSDateComponents alloc] init];
    [offset setDay:1];

    NSMutableArray *dates = [NSMutableArray array];
    NSDate *curDate = startDate;
    while([curDate timeIntervalSince1970] <= [endDate timeIntervalSince1970])
    {
        [dates addObject:curDate];
        curDate = [calendar dateByAddingComponents:offset toDate:curDate options:0];
    }

    NSLog(@"%@",dates);

   
}


-(void)chartValueSelected:(XMViewBase *)chartView entry:(id)entry entryIndex:(NSInteger)entryIndex
{
    NSLog(@"=111===%@",chartView);
}

- (void)chartValueNothingSelected:(XMViewBase *)chartView
{
    NSLog(@"==22==%@",chartView);
}

- (void)chartKlineScrollLeft:(XMViewBase *)chartView
{
    NSLog(@"=33==%@",chartView);
}

@end
