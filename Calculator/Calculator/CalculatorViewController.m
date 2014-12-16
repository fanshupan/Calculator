//
//  CalculatorViewController.m
//  Calculator
//
//  Created by 范 叔盘 on 14/12/15.
//  Copyright (c) 2014年 Shrek. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@property (nonatomic,strong)NSMutableArray *ValueArray;
@property (nonatomic,strong)UILabel *DisplayLabel;
@property (nonatomic,strong)UIButton *ClearButton;
@property (nonatomic,strong)UIButton *MinusButton;
@property (nonatomic,strong)UIButton *PercentButton;
@property (nonatomic,strong)UIButton *NumberButton;
@property (nonatomic,strong)UIButton *ZeroButton;
@property (nonatomic,strong)UIButton *DecimalPointButton;
@property (nonatomic,strong)UIButton *arithmeticButton;
@property (nonatomic,strong)UIButton *OperateButton;
@property (nonatomic,strong)NSString *ValueString;
@property (nonatomic,strong)NSString *arithmeticString;
@property (nonatomic,strong)NSString *ResultString;
@property (nonatomic,strong)NSMutableArray *EqualArray;
@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Calculator];
    // Do any additional setup after loading the view.
}
-(void)Calculator
{
    self.ValueArray=[[NSMutableArray alloc]init];
    self.ValueString=[[NSString alloc]init];
    self.arithmeticString=[[NSString alloc]init];
    self.ResultString=[[NSString alloc]init];
    
    self.DisplayLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/7*2)];
    self.DisplayLabel.backgroundColor=[UIColor blackColor];
    self.DisplayLabel.text=@"0";
    self.DisplayLabel.textColor=[UIColor whiteColor];
    self.DisplayLabel.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:self.DisplayLabel];
    
    //添加AC Button
    self.ClearButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.ClearButton.frame=CGRectMake(0, CGRectGetMaxY(self.view.frame)/7*2, self.view.frame.size.width/4, self.view.frame.size.height/7);
    [self.ClearButton setTitle:@"AC" forState:UIControlStateNormal];
    self.ClearButton.backgroundColor=[UIColor grayColor];
    self.ClearButton.layer.borderWidth=1.0f;
    [self.ClearButton addTarget:self action:@selector(ClearValue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ClearButton];
    
    //添加+/- Button
    self.MinusButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.MinusButton.frame=CGRectMake(CGRectGetMaxX(self.view.frame)/4, CGRectGetMaxY(self.view.frame)/7*2, self.view.frame.size.width/4, self.view.frame.size.height/7);
    [self.MinusButton setTitle:@"+/-" forState:UIControlStateNormal];
    self.MinusButton.backgroundColor=[UIColor grayColor];
    self.MinusButton.layer.borderWidth=1.0f;
    self.MinusButton.tag=16;
    [self.MinusButton addTarget:self action:@selector(GetNumberValue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.MinusButton];
    
    //添加 % Button
    self.PercentButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.PercentButton.frame=CGRectMake(CGRectGetMaxX(self.view.frame)/2, CGRectGetMaxY(self.view.frame)/7*2, self.view.frame.size.width/4, self.view.frame.size.height/7);
    [self.PercentButton setTitle:@"%" forState:UIControlStateNormal];
    self.PercentButton.backgroundColor=[UIColor grayColor];
    self.PercentButton.layer.borderWidth=1.0f;
    self.PercentButton.tag=17;
    [self.PercentButton addTarget:self action:@selector(GetNumberValue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.PercentButton];
    
    for (int j=0; j<3; j++) {
        for (int i=0; i<3; i++) {
            self.NumberButton=[UIButton buttonWithType:UIButtonTypeCustom];
            self.NumberButton.frame=CGRectMake(CGRectGetMaxX(self.view.frame)/4*i, CGRectGetMaxY(self.view.frame)/7*(5-j), self.view.frame.size.width/4, self.view.frame.size.height/7);
            self.NumberButton.backgroundColor=[UIColor grayColor];
            self.NumberButton.layer.borderWidth=1.0f;
            NSString *string=[NSString stringWithFormat:@"%d",(i+1+j*3)];
            self.NumberButton.tag=(i+1+j*3);
            [self.NumberButton addTarget:self action:@selector(GetNumberValue:) forControlEvents:UIControlEventTouchUpInside];
            [self.NumberButton setTitle:string forState:UIControlStateNormal];
            [self.view addSubview:self.NumberButton];
        }
    }
    
    
    //添加 0 Button
    self.ZeroButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.ZeroButton.frame=CGRectMake(0, CGRectGetMaxY(self.view.frame)/7*6, self.view.frame.size.width/2, self.view.frame.size.height/7);
    [self.ZeroButton setTitle:@"0" forState:UIControlStateNormal];
    self.ZeroButton.backgroundColor=[UIColor grayColor];
    self.ZeroButton.layer.borderWidth=1.0f;
    self.ZeroButton.tag=14;
    [self.ZeroButton addTarget:self action:@selector(GetNumberValue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ZeroButton];
    
    //添加 . Button
    self.DecimalPointButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.DecimalPointButton.frame=CGRectMake(CGRectGetMaxX(self.view.frame)/2, CGRectGetMaxY(self.view.frame)/7*6, self.view.frame.size.width/4, self.view.frame.size.height/7);
    [self.DecimalPointButton setTitle:@"." forState:UIControlStateNormal];
    self.DecimalPointButton.backgroundColor=[UIColor grayColor];
    self.DecimalPointButton.layer.borderWidth=1.0f;
    self.DecimalPointButton.tag=15;
    [self.DecimalPointButton addTarget:self action:@selector(GetNumberValue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.DecimalPointButton];
    
    //添加 arithmetic Button
    
    for (int K=1; K<5; K++) {
        
        self.arithmeticButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.arithmeticButton.frame=CGRectMake(CGRectGetMaxX(self.view.frame)/4*3, CGRectGetMaxY(self.view.frame)/7*(1+K), self.view.frame.size.width/4, self.view.frame.size.height/7);
        self.arithmeticButton.tag=9+K;
        if ((self.arithmeticButton.tag==10)) {
            [self.arithmeticButton setTitle:@"÷" forState:UIControlStateNormal];
        }
        else if((self.arithmeticButton.tag==11)){
            [self.arithmeticButton setTitle:@"x" forState:UIControlStateNormal];
        }
        else if((self.arithmeticButton.tag==12)){
            [self.arithmeticButton setTitle:@"-" forState:UIControlStateNormal];
        }
        else if((self.arithmeticButton.tag==13)){
            [self.arithmeticButton setTitle:@"+" forState:UIControlStateNormal];
        }
        self.arithmeticButton.backgroundColor=[UIColor orangeColor];
        self.arithmeticButton.layer.borderWidth=1.0f;
        [self.arithmeticButton addTarget:self action:@selector(arithmeticValue:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.arithmeticButton];
    }
    
    //添加 = Button
    self.OperateButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.OperateButton.frame=CGRectMake(CGRectGetMaxX(self.view.frame)/4*3, CGRectGetMaxY(self.view.frame)/7*6, self.view.frame.size.width/4, self.view.frame.size.height/7);
    [self.OperateButton setTitle:@"=" forState:UIControlStateNormal];
    self.OperateButton.backgroundColor=[UIColor orangeColor];
    self.OperateButton.layer.borderWidth=1.0f;
    [self.OperateButton addTarget:self action:@selector(OperateValue) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.OperateButton];
 
}
-(void)ClearValue:(id)sender
{
    self.ValueArray=[[NSMutableArray alloc]init];
    self.ValueString=[[NSString alloc]init];
    self.DisplayLabel.text=@"0";
}

-(void)GetNumberValue:(id)sender
{
    
    UIButton *numberButton=(UIButton *)sender;
    
    if (numberButton.tag==1) {
        [self.ValueArray addObject:@"1"];

    }
    else if (numberButton.tag==2) {
        [self.ValueArray addObject:@"2"];

    }
    else if (numberButton.tag==3) {
        [self.ValueArray addObject:@"3"];

    }
    else if (numberButton.tag==4) {
        [self.ValueArray addObject:@"4"];

    }
    else if (numberButton.tag==5) {
        [self.ValueArray addObject:@"5"];

    }
    else if (numberButton.tag==6) {
        [self.ValueArray addObject:@"6"];

    }
    else if (numberButton.tag==7) {
        [self.ValueArray addObject:@"7"];
    }
    else if (numberButton.tag==8) {
        [self.ValueArray addObject:@"8"];

    }
    else if (numberButton.tag==9) {
        [self.ValueArray addObject:@"9"];

    }
    else if (numberButton.tag==14) {
        
        [self.ValueArray addObject:@"0"];

    }
    else if (numberButton.tag==15) {
        
        if ([self.ValueArray containsObject:@"."]==NO) {
            [self.ValueArray addObject:@"."];
            
        }else {
            return;
        }

    }
    else if (numberButton.tag==16) {
        
        
        if ([self.ValueArray containsObject:@"-"]==NO) {
            
            [self.ValueArray insertObject:@"-" atIndex:0];
            if ([self.ValueArray count]==1) {
                [self.ValueArray addObject:@"0"];
            }
            NSString *temporyString= [self.ValueArray componentsJoinedByString:@""];
            self.DisplayLabel.text=temporyString;
            return;
            
        }else if ([self.ValueArray containsObject:@"-"]==YES){
            
            [self.ValueArray removeObject:@"-"];
            NSString *temporyString= [self.ValueArray componentsJoinedByString:@""];
            self.DisplayLabel.text=temporyString;
            return;
        }
  

    }
    else if (numberButton.tag==17) {
        
        if ([self.ValueArray containsObject:@"."]==NO) {
            [self.ValueArray addObject:@"."];
            
        }else {
            return;
        }
        
    }
    
    
    
    if([[self.ValueArray objectAtIndex:0]isEqual:@"."]){
        
        [self.ValueArray insertObject:@"0" atIndex:0];
    }
    
    else if ((1<[self.ValueArray count])&[[self.ValueArray objectAtIndex:0] isEqual:@"0"]) {
        
        if ([[self.ValueArray objectAtIndex:1]isEqual:@"."]) {
   
        }else
            
            [self.ValueArray removeObjectAtIndex:0];
    }
    
   
    else if((1<[self.ValueArray count])&[[self.ValueArray objectAtIndex:0] isEqual:@"-"]){
        
       if([[self.ValueArray objectAtIndex:1] isEqual:@"0"]){
            
            if ([[self.ValueArray objectAtIndex:2]isEqual:@"0"]) {
                
                [self.ValueArray removeObjectAtIndex:1];
            }
            else if([[self.ValueArray objectAtIndex:2]isEqual:@"."]){
                
            }else{
                
                [self.ValueArray removeObjectAtIndex:1];
            }
        }
    }
    
    NSString *temporyString= [self.ValueArray componentsJoinedByString:@""];
    self.DisplayLabel.text=temporyString;
}


-(void)arithmeticValue:(id)sender
{
    UIButton *numberButton=(UIButton *)sender;
    
    if (numberButton.tag==10) {
        if ([self.EqualArray containsObject:@"="]) {
            self.ValueArray=[[NSMutableArray alloc]init];
            [self.EqualArray removeObject:@"="];
            self.arithmeticString=@"÷";
        }else
        self.arithmeticString=@"÷";
    }
    else if (numberButton.tag==11) {
        if ([self.EqualArray containsObject:@"="]) {
            self.ValueArray=[[NSMutableArray alloc]init];
            [self.EqualArray removeObject:@"="];
            self.arithmeticString=@"x";
        }else
        self.arithmeticString=@"x";
    }
    else if (numberButton.tag==12) {
        if ([self.EqualArray containsObject:@"="]) {
            self.ValueArray=[[NSMutableArray alloc]init];
            [self.EqualArray removeObject:@"="];
            self.arithmeticString=@"-";
        }else
        self.arithmeticString=@"-";
    }
    else if (numberButton.tag==13) {
        if ([self.EqualArray containsObject:@"="]) {
            self.ValueArray=[[NSMutableArray alloc]init];
            [self.EqualArray removeObject:@"="];
            self.arithmeticString=@"+";
        }else
        self.arithmeticString=@"+";
    }
    
    if (0<[self.ValueArray count]) {
        if ([self.ValueString length]<1) {
            self.ValueString=[self.ValueArray componentsJoinedByString:@""];
            self.ValueArray=[[NSMutableArray alloc]init];
            return;
        }else{
            self.ResultString=[self CalculatorResult:self.ValueArray string1:self.ValueString];
            self.DisplayLabel.text=self.ResultString;
            self.ValueArray=[[NSMutableArray alloc]init];
            return;
        }
    }
    else
        return;
    
}
-(void)OperateValue
{
    
    if ([self.ValueString length]<1) {
        self.ValueArray=[[NSMutableArray alloc]init];
        return;
    }
    else{
        [self.EqualArray addObject:@"="];
        self.ResultString=[self CalculatorResult:self.ValueArray string1:self.ValueString];
        self.ValueString=self.ResultString;
        self.DisplayLabel.text=self.ResultString;
        return;
    
    }
}

-(NSString *)CalculatorResult:(NSMutableArray *)Array string1:(NSString *)string1{
    
    NSString *string2;
    if (!0<[Array count]) {
        string2=string1;
    }
    else {
    NSString *temporyString= [Array componentsJoinedByString:@""];
    string2=temporyString;
    }
    
    double float1=[string1 doubleValue];
    double float2=[string2 doubleValue];
    
    NSString *ResultString;
    
    if ([self.arithmeticString containsString:@"÷"]) {
        if ([string2 isEqual:@"0"]) {
            NSString *AccurateString=@"错误";
            ResultString=AccurateString;
            return ResultString;
        }
        else{
            
            double reslutFloat=float1/float2;
            NSString *AccurateString=[self AccurateString:reslutFloat];
            ResultString=AccurateString;
            return ResultString;

        }
    }
    else if([self.arithmeticString containsString:@"x"]){
        
        double reslutFloat=float1*float2;
        NSString *AccurateString=[self AccurateString:reslutFloat];
        ResultString=AccurateString;
        return ResultString;
    }
    else if([self.arithmeticString containsString:@"-"]){
        
        double reslutFloat=float1-float2;
        NSString *AccurateString=[self AccurateString:reslutFloat];
        ResultString=AccurateString;
        return ResultString;
    }
    else if([self.arithmeticString containsString:@"+"]){
        
        double reslutFloat=float1+float2;
        NSString *AccurateString=[self AccurateString:reslutFloat];
        ResultString=AccurateString;
        return ResultString;
    }
    
    return ResultString;
}

-(NSString *)AccurateString:(float)resultFloat
{
    NSString *name=[[NSString alloc] initWithFormat:@"%f",resultFloat];
    NSMutableArray *temporyArray=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[name length]; i++) {
        
        NSString *temporyString=[name substringWithRange:NSMakeRange(i, 1)];
        [temporyArray addObject:temporyString];
        
    }
    
    NSString *AccurateString;
    
    for (int k=1; 0<k; k++) {
        
        if ([[temporyArray lastObject]isEqual:@"0"]) {
            [temporyArray removeLastObject];
        }
        else if([[temporyArray lastObject]isEqual:@"."]){
            [temporyArray removeLastObject];
            NSString *temporyString= [temporyArray componentsJoinedByString:@""];
            AccurateString=temporyString;
            return AccurateString;
        }
        else{
            NSString *temporyString= [temporyArray componentsJoinedByString:@""];
            AccurateString=temporyString;
            return AccurateString;
        }
    }
    return AccurateString;

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
