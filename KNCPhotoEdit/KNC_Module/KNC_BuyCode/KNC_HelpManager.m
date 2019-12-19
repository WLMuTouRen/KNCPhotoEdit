//
//  KNC_HelpManager.m
//  PSLongFigure
//
//  Created by LG on 2019/12/09.
//  Copyright © 2019年 LG. All rights reserved.
//

#import "KNC_HelpManager.h"

@implementation KNC_HelpManager
#pragma mark 判断是否是中文
+(BOOL)isAllChinese:(NSString *)str{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    if ([predicate evaluateWithObject:str]) {
        return YES;
    }
    return NO;
    
}
#pragma mark NSUserDefaults操作
+(id)objectForKey:(NSString *)defaultName{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:defaultName];
}
+(void)setObject:(id)value forKey:(NSString *)defaultName{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:defaultName];
}
#pragma mark 从服务器取字符串、字典、数组数据-防止服务器返回非法数据类型
+(NSString *)getStr:(id)str{
    if ([str isKindOfClass:[NSString class]]) {
        return str;
    }
    else if (str==nil){
        return @"";
    }
    else{
        return [NSString stringWithFormat:@"%@",str];
    }
}
+(NSDictionary *)getDic:(id)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        return dic;
    }
    else{
        return @{};
    }
}
+(NSArray *)getArray:(id)array{
    if ([array isKindOfClass:[NSArray class]]) {
        return array;
    }
    else{
        return @[];
    }
}
#pragma mark 关于对象和josn串互转的
+(NSString *)changeObjectToJsonStr:(id)object{
    if (object==nil) {
        return @"";
    }
    //转成json串
    NSData *data=[NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}
+(id)changeJsonStrToObject:(NSString *)jsonStr{
    if (jsonStr==nil) {
        jsonStr=@"";
    }
    NSData *data=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    id  object=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return object;
}



#pragma mark 获取当前时间
+(NSString *)getNowTime{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-M-d"];
    NSString* dateStr = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@",dateStr);
    return dateStr;
}
#pragma mark 获取当前时间
+(NSString *)getNowTime1{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString* dateStr = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@",dateStr);
    return dateStr;
}
#pragma mark 获取当前时间戳精确到秒
+(NSString *)getNowTime2{
    
    //获取当前时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *nowTimeString = [NSString stringWithFormat:@"%.0f", a];
    return nowTimeString;
}
#pragma mark 获取当前时间戳精确到毫秒
+(NSString *)getNowTime3{
    
    //获取当前时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *nowTimeString = [NSString stringWithFormat:@"%.0f000", a];
    return nowTimeString;
}
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)getToNowTimeWithIntervalString:(NSString *)timeString{
    long oldTime=[timeString longLongValue]/1000;
    long nowTime=[[KNC_HelpManager getNowTime2] longLongValue];
    long chaTime=nowTime-oldTime;
    
    if (chaTime<60) {
        return @"刚刚";
    }
    else if (chaTime>=60&&chaTime<60*60){
        return [NSString stringWithFormat:@"%ld分钟前",chaTime/60];
    }
    else if (chaTime>=60*60&&chaTime<60*60*24){
        return [NSString stringWithFormat:@"%ld小时前",chaTime/(60*60)];
    }
    else{
        return [NSString stringWithFormat:@"%ld天前",chaTime/(60*60*24)];
    }
}
+(NSString *)changeMiaoToHMS:(NSString*)miao{
    int ss=[miao intValue];
    if (ss<=60) {
        return [NSString stringWithFormat:@"%d秒",ss];
    }
    else if (ss<=60*60){
        int mm=ss/60;
        ss=ss%60;
        return [NSString stringWithFormat:@"%d分%d秒",mm,ss];
    }
    else{
        int hh=ss/(60*60);
        ss=ss%(60*60);
        int mm=ss/60;
        ss=ss%60;
        return [NSString stringWithFormat:@"%d小时%d分%d秒",hh,mm,ss];
    }
}
#pragma mark 根据字符串计算字符串高度
+(float)getHeightWithStr:(NSString *)str font:(float)strFont width:(float)width{
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:strFont]} context:nil].size ;
    return size.height+1;
}
#pragma mark 根据字符串计算字符串宽度
+(float)getWidthWithStr:(NSString *)str font:(float)strFont height:(float)height{
    CGSize size=[str boundingRectWithSize:CGSizeMake(30000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:strFont]} context:nil].size ;
    return size.width+1;
}
#pragma mark 根据字符串计算有行间距的字符串高度
+(float)getHeightWithStr:(NSString *)str font:(float)strFont width:(float)width lineSpacing:(float)lineSpacing{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    //行间距
    [paragraphStyle setLineSpacing:lineSpacing];
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:strFont],NSParagraphStyleAttributeName:paragraphStyle} context:nil].size ;
    return size.height+1;
}
#pragma mark 获取最上层controller
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
#pragma mark 彩图变黑白
+ (UIImage*)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:grayImageRef];
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    
    return grayImage;
    
    
    
}
+ (UIImage*)grayscaleImageForImage:(UIImage*)image {
    // Adapted from this thread: http://stackoverflow.com/questions/1298867/convert-image-to-grayscale
    const int RED =1;
    const int GREEN =2;
    const int BLUE =3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0,0, image.size.width* image.scale, image.size.height* image.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t*) malloc(width * height *sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels,0, width * height *sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height,8, width *sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context,CGRectMake(0,0, width, height), [image CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t*) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] +0.59 * rgbaPixel[GREEN] +0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(imageRef);
    
    return resultUIImage;
}
#pragma mark 颜色生成图片的方法，可用于给按钮设置选中颜色
+(UIImage*) createImageWithColor:(UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark 改变按钮图片和文字的位置右侧
+(void)changeBtnImageToRight:(UIButton *)btn{
    //移动文字
    UIImage *image=btn.imageView.image;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    //移动图片
    float ww=btn.titleLabel.frame.size.width;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, ww, 0, -ww)];
}
#pragma mark 禁用返回手势
+(void)disableRightSlipBack{
    UIViewController *controller=[self topViewController];
    if ([controller.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        controller.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
#pragma mark 开启返回手势
+(void)ableRightSlipBack{
    UIViewController *controller=[self topViewController];
    if ([controller.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        controller.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark 获取图片缓存地址-文件夹
+(NSString *)getImagePath{
    NSString*strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)lastObject];
    NSString *pathStr=[NSString stringWithFormat:@"%@/OCRImage", strUrl];
    NSLog(@"%@",pathStr);
    //创建record文件夹
    NSFileManager *fm=[NSFileManager defaultManager];
    [fm createDirectoryAtPath:pathStr withIntermediateDirectories:YES attributes:nil error:nil];
    return pathStr;
}
#pragma mark 获取沙河目录图片
+(UIImage*)getImgWithImgName:(NSString*)name{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getImagePath],name];
    // 保存文件的名称
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return img;
}
#pragma mark 向沙河存入图片
+(BOOL)saveImgWithImg:(UIImage*)image andImgName:(NSString*)name{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getImagePath],name];
    BOOL result =[UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES]; // 保存成功会返回YES
    return result;
}
#pragma mark 删除图片数据
+(BOOL)deleteImgWithImgName:(NSString*)name{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getImagePath],name];
    
    BOOL isHave=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (isHave) {
        BOOL isDele= [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        return isDele;
    }
    else {
        return NO;
    }
    
}

#pragma mark 获取语言类型数组
+(NSArray*)getLanguageArrayHaveAuto:(BOOL)isHaveAuto andExcludeName:(NSString*)nameStr{
    
    NSArray *languageArray=@[
                             @{
                                 @"name":@"English",
                                 @"key":@"en",
                                 @"chinaName":@"英语",
                                 @"speechKey":@"en-US"
                                 },
                             @{
                                 @"name":@"Chinese",
                                 @"key":@"zh",
                                 @"chinaName":@"中文",
                                 @"speechKey":@"zh-CN"
                                 },
                             @{
                                 @"name":@"Japanese",
                                 @"key":@"jp",
                                 @"chinaName":@"日语",
                                 @"speechKey":@"ja-JP"
                                 },
                             @{
                                 @"name":@"Korean",
                                 @"key":@"kor",
                                 @"chinaName":@"韩语",
                                 @"speechKey":@"ko-KR"
                                 },
                             @{
                                 @"name":@"French",
                                 @"key":@"fra",
                                 @"chinaName":@"法语",
                                 @"speechKey":@"fr-FR"
                                 },
                             @{
                                 @"name":@"Spanish",
                                 @"key":@"spa",
                                 @"chinaName":@"西班牙语",
                                 @"speechKey":@"es-ES"
                                 },
                             @{
                                 @"name":@"Thai",
                                 @"key":@"th",
                                 @"chinaName":@"泰语",
                                 @"speechKey":@"th-TH"
                                 },
                             @{
                                 @"name":@"Arabic",
                                 @"key":@"ara",
                                 @"chinaName":@"阿拉伯语",
                                 @"speechKey":@"ar-SA"
                                 },
                             @{
                                 @"name":@"Russian",
                                 @"key":@"ru",
                                 @"chinaName":@"俄语",
                                 @"speechKey":@"ru-RU"
                                 },
                             @{
                                 @"name":@"Portuguese",
                                 @"key":@"pt",
                                 @"chinaName":@"葡萄牙语",
                                 @"speechKey":@"pt-PT"
                                 },
                             @{
                                 @"name":@"German",
                                 @"key":@"de",
                                 @"chinaName":@"德语",
                                 @"speechKey":@"de-DE"
                                 },
                             @{
                                 @"name":@"Italian",
                                 @"key":@"it",
                                 @"chinaName":@"意大利语",
                                 @"speechKey":@"it-IT"
                                 },
                             @{
                                 @"name":@"Greek",
                                 @"key":@"el",
                                 @"chinaName":@"希腊语",
                                 @"speechKey":@"el-GR"
                                 },
                             @{
                                 @"name":@"Dutch",
                                 @"key":@"nl",
                                 @"chinaName":@"荷兰语",
                                 @"speechKey":@"nl-NL"
                                 },
                             @{
                                 @"name":@"Polish",
                                 @"key":@"pl",
                                 @"chinaName":@"波兰语",
                                 @"speechKey":@"pl-PL"
                                 },
                             @{
                                 @"name":@"Danish",
                                 @"key":@"dan",
                                 @"chinaName":@"丹麦语",
                                 @"speechKey":@"da-DK"
                                 },
                             @{
                                 @"name":@"Finnish",
                                 @"key":@"fin",
                                 @"chinaName":@"芬兰语",
                                 @"speechKey":@"fi-FI"
                                 },
                             @{
                                 @"name":@"Czech",
                                 @"key":@"cs",
                                 @"chinaName":@"捷克语",
                                 @"speechKey":@"cs-CZ"
                                 },
                             @{
                                 @"name":@"Romanian",
                                 @"key":@"rom",
                                 @"chinaName":@"罗马尼亚语",
                                 @"speechKey":@"ro-RO"
                                 },
                             @{
                                 @"name":@"Swedish",
                                 @"key":@"swe",
                                 @"chinaName":@"瑞典语",
                                 @"speechKey":@"sv-SE"
                                 },
                             @{
                                 @"name":@"Hungarian",
                                 @"key":@"hu",
                                 @"chinaName":@"匈牙利语",
                                 @"speechKey":@"hu-HU"
                                 }
                             ];
    
    NSMutableArray *mArray=[[NSMutableArray alloc]initWithArray:languageArray];
    //排除不需要显示的语言
    if (nameStr.length>0) {
        for (int i=0; i<mArray.count; i++) {
            NSDictionary *dic=mArray[i];
            if ([[dic objectForKey:@"name"] isEqualToString:nameStr]) {
                [mArray removeObjectAtIndex:i];
                break;
            }
        }
    }
    //增加自动选项
    if (isHaveAuto) {
        NSDictionary *dic=@{
                            @"name":@"Auto",
                            @"key":@"auto",
                            @"chinaName":@"自动"
                            };
        [mArray insertObject:dic atIndex:0];
    }
    
    return mArray;
}




+(BOOL)isVipLongFigure{
    
    NSString *vip = [KNC_HelpManager objectForKey:@"ISBuyVip"];
    
    if ([vip isEqualToString:@"YES"]) {
        return YES;
    }else{
        return NO;
    }
}



+(NSString *)getSystemLanuge{
    NSString *languageCode = [NSLocale preferredLanguages][0];
    // 返回的也是国际通用语言Code+国际通用国家地区代码
    NSString *countryCode = [NSString stringWithFormat:@"-%@", [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]];
        if (languageCode) {
            languageCode = [languageCode stringByReplacingOccurrencesOfString:countryCode withString:@""];
        }
    NSLog(@"languageCode : %@", languageCode);
    return languageCode;
}
#pragma mark 显示及隐藏提示框
//+(void)showHUDWithTitle:(NSString *)str{
//    VE_BaseViewController *controller=(VE_BaseViewController*)[VE_HelpManager topViewController];
//    [controller showHUDWithTitle:str andDetailsText:nil];
//}
//+(void)hideHUDWithTitle:(NSString *)str{
//    VE_BaseViewController *controller=(VE_BaseViewController*)[VE_HelpManager topViewController];
//    [controller hideHUDWithTitle:str andDetailsText:nil];
//}
//+(void)hideHUD{
//    VE_BaseViewController *controller=(VE_BaseViewController*)[VE_HelpManager topViewController];
//    [controller hideHUD];
//}


@end
