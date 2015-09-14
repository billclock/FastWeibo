

#import "FWImageListView.h"
#import "FWImageView.h"
#import "PicUrlModel.h"


@interface FWImageListView ()
{
    CGSize _contentSize;
}

@end

@implementation FWImageListView

#pragma mark - 1、初始化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // 初始化9张图片并添加到View
        for (int i = 0; i < kImageCount; i++) {
            FWImageView *image = [[FWImageView alloc] init];
            image.tag = i + 10;
            [self addSubview:image];
        }
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化9张图片并添加到View
        for (int i = 0; i < kImageCount; i++) {
            FWImageView *image = [[FWImageView alloc] init];
            image.tag = i + 10;
            [self addSubview:image];
        }
    }
    return self;
}

#pragma mark - 2、设置内容与尺寸位置
-(void)setImageList:(NSArray *)imageList
{
    _imageList = imageList;
    
    // 1、取出所有子控件判断是否有需要展示图片
    
    // 2、设置展示图片及尺寸位置
    
    NSInteger imageCount = imageList.count;
    
    if (imageCount > 0) {
        for (int i = 0; i < kImageCount; i++) {
            
            FWImageView *statusImage = self.subviews[i];
            
            if (i < imageCount) {   // 初始化9张图片，有图片url则显示，否则隐藏
                
                statusImage.hidden = NO;
                
                statusImage.picUrl = ((PicUrlModel* )imageList[i]).thumbnailPic;
                
                if (imageCount == 1) {      // 1、一张配图情况
                    self.backgroundColor = [UIColor clearColor];                        // 设置背景色
                    statusImage.contentMode = UIViewContentModeScaleAspectFit;         // 设置图片保持宽高比
                    
                    // 设置尺寸位置
                    statusImage.frame = CGRectMake(0, 0, kStatusImageOneWH, kStatusImageOneWH);
                    
                } else {                    // 2、多张配图情况
                    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];        // 设置背景色
                    statusImage.contentMode = UIViewContentModeScaleAspectFill;        // 设置图片正常填充
                    statusImage.clipsToBounds = YES;                                   // 裁剪边缘
                    
                    // 设置尺寸位置
                    NSInteger count = (imageCount == 4) ? 2 : 3;                        // 如果4张图片则按2列排，其他按3列排
                    CGFloat multipleWidth = kStatusImageMuWH;
                    CGFloat multipleHeight = kStatusImageMuWH;
                    NSInteger row = i / count;                                          // 计算行号0~n
                    NSInteger column = i % count;                                       // 计算列号0~n
                    statusImage.frame = CGRectMake(column * (kImageInterval + multipleWidth) + kImageInterval, row * (kImageInterval + multipleWidth) + kImageInterval, multipleWidth, multipleHeight);
                }
                
            } else {                // 初始化9张图片，有图片url则显示，否则隐藏
                statusImage.hidden = YES;
            }
        }
        _contentSize = [FWImageListView sizeOfViewWithImageCount:imageCount];
        self.bounds = (CGRect){{0, 0}, _contentSize};
        self.hidden = NO;
    } else {
        _contentSize = CGSizeZero;
        self.bounds = CGRectZero;
        self.hidden = YES;
    }
}

#pragma mark - 3、对外提供配图所占尺寸
+ (CGSize)sizeOfViewWithImageCount:(NSInteger)count
{
    if (count == 1) {   // 只有一张图片展示大图
        return CGSizeMake(kStatusImageOneWH, kStatusImageOneWH);
    } else {            // 多张图片展示小图并计算多张图所占据的尺寸
        NSInteger columns = (count > 2 && count != 4) ? 3 : 2;  // 小于3张图或等于4张图按2列展示，否则按3列展示
        NSInteger rows = (count + columns - 1) / columns;       // 计算实际图片排列的行数，如果4张图无论是按2列还是按3列展示都是2行，所在不需要特殊处理
        return CGSizeMake(columns * (kStatusImageMuWH + kImageInterval) + kImageInterval, rows * (kStatusImageMuWH + kImageInterval) + kImageInterval);
    }
}

- (CGSize)intrinsicContentSize{
    return _contentSize;
}

@end
