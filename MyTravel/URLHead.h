//
//  URLHead.h
//  MyTravel
//
//  Created by ysq on 16/1/4.
//  Copyright © 2016年 ysq. All rights reserved.
//


#ifndef URLHead_h
#define URLHead_h


#define PUSHKEY @"bdc4aa5a63e5dc03f406a06b"
#define LoginNotification @"LoginNotification"

//----------------------推荐------------------------
// 发现/轮播/折扣
#define MT_FOUND_URL                                                      \
  @"qyer/recommands/"                                                     \
  @"entry?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&" \
  @"track_deviceid=862136026218809&track_app_version=6.7.1&track_app_"    \
  @"channel=qq&track_device_info=Coolpad8297W&track_os=Android4.4.2&app_" \
  @"installtime=1444836589669&lat=40.116539&lon=116.251266&channel=qq"

//热门游记
#define MT_HOTNOTES_URL @"qyer/recommands/"                                     \
@"trip?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&"   \
@"track_deviceid=862136026218809&track_app_version=6.7.1&track_app_"     \
@"channel=qq&track_device_info=Coolpad8297W&track_os=Android4.4.2&app_"  \
@"installtime=1444836589669&lat=40.116856&lon=116.251109&type=index&"    \
@"page=%d" @"d&count=10"

//抢折扣 月份推荐旅游
#define MT_DISCOUNT_SUBJECT_URL                                                   \
@" http://m.qyer.com/z/zt/november/"                                         \
@"?source=app&campaign=appshouye&category=november/"                     \
@"&source=app&client_id=qyer_android&track_user_id=&track_deviceid="     \
@"862136026218809&track_app_version=6.8.1"

//抢折扣 推荐旅游套餐  精彩当地游 超值自由行
#define MT_DISCOUNT_URL                                                          \
@"http://m.qyer.com/z/deal/%@/"                                              \
@"?source=app&client_id=qyer_android&track_app_version=6.8.1&track_"     \
@"deviceid=862136026218809"

#define YSQ_ALLFOUND_URL                                                        \
@"http://open.qyer.com/qyer/special/topic/"                              \
@"special_list?client_id=qyer_"                                          \
@"android&client_secret="                                                \
@"9fcaae8aefc4f9ac4915&"                                                 \
@"v=1&track_deviceid=862136026218809&track_app_version=6.8.1&track_app_" \
@"channel=qq&track_device_info=Coolpad8297W&track_os=Android4.4.2&app_"  \
@"installtime=1445472814342&lat=40.117923&lon=116.257436&page=%d&count=" \
@"10"

//全部折扣
#define YSQ_ALLDISCOUNT_URL                                                   \
  @"lastminute/"                                                              \
  @"app_lastminute_list?client_id=qyer_ios&client_secret="                    \
  @"cd254439208ab658ddf9&continent_id=0&count=20&country_id=0&departure=&is_" \
  @"show_pay=1&is_show_supplier=1&lat=41.890518&lon=12.494249&max_id=0&page=" \
  @"%d&page_size=20&product_type=0&times=&track_app_channel=AppStore&track_"  \
  @"app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-" \
  @"433E-A7DF-2EC4937CD6AD&track_os=ios9.3.1&v=1"

//折扣排序
#define YSQ_DISCOUNT_ORDER_URL @"lastminute/app_lastminute_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=0&count=20&country_id=0&departure=&is_show_pay=1&is_show_supplier=1&lat=41.890518&lon=12.494249&max_id=0&orderName=&orderValue=&page=%d&page_size=20&product_type=0&sequence=%@&times=&track_app_channel=AppStore&track_app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.1&v=1"

//筛选类型
#define YSQ_DISCOUNT_CHOOSE_URL @"lastminute/get_all_categorys?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=0&count=20&country_id=0&departure=&lat=23.01425895136607&lon=113.2948652117361&page=1&times=&track_app_channel=AppStore&track_app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.1&type=0&v=1"

#define YSQ_DISCOUNT_PICK_URL @"lastminute/app_lastminute_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=%@&count=20&country_id=%@&departure=%@&is_show_pay=1&is_show_supplier=1&lat=23.01445094610098&lon=113.2958626666352&max_id=0&orderName=&orderValue=&page=%d&page_size=20&product_type=%@&times=%@&track_app_channel=AppStore&track_app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.1&v=1"

//锦囊详情
#define YSQ_KITS_DETAIL_URL @"qyer/guide/detail"

//城市列表
#define YSQ_LOCATION_URL @"qyer/hotel/hot_city_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=199&lat=39.10518588709011&lon=121.8118113409482&oauth_token=9374328e00dd5a821829c27b7ff90573&page=1&track_app_channel=AppStore&track_app_version=6.9.0&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.2&track_user_id=7935321&v=1"

//锦囊左侧列表
#define YSQ_KITS_LEFT_LIST_URL @"qyer/guide/category_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=23.01220323973925&lon=113.2956616605503&page=1&track_app_channel=AppStore&track_app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.1&v=1"

//锦囊右侧列表
#define YSQ_KITS_RIGHT_LIST_URL @"qyer/guide/channel_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&id=%@&lat=23.01220323973925&lon=113.2956616605503&page=1&track_app_channel=AppStore&track_app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.1&v=1"
/***********************************目的地****************************************/

//目的地列表
#define MT_CITY_URL                                                               \
@"qyer/footprint/"                                      \
@"continent_list?client_id=qyer_android&client_secret="                  \
@"9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_"    \
@"version=6.7.1&track_app_channel=qq&track_device_info=Coolpad8297W&"    \
@"track_"                                                                \
@"os=Android4.4.2&app_installtime=1444836589669&lat=40.116856&lon=116."  \
@"251109"

//国家区域详情页 id=%@
#define MT_COUNTRY_DETAIL_URL   @"qyer/footprint/country_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_version=6.8.1&track_app_channel=qq&track_device_info=Coolpad8297W&track_os=Android4.4.2&app_installtime=1445472814342&lat=40.118145&lon=116.250982&country_id=%@"

//热门城市详情页
#define YSQ_CITY_DETAIL_URL @"qyer/footprint/city_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_version=6.8.1&track_app_channel=qq&track_device_info=Coolpad8297W&track_os=Android4.4.2&app_installtime=1445472814342&lat=40.11786&lon=116.257809&city_id=%@"

//全部城市
#define YSQ_ALL_CITY_URL @"http://open.qyer.com/place/city/get_city_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&countryid=%@&lat=23.0120366459038&lon=113.2956755509944&oauth_token=df0f155bfc31a0dcc8affdf397bf9d06&page=%d&track_app_channel=AppStore&track_app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3&track_user_id=7435631&v=1"

//自由行
#define YSQ_TRAVEL_LOCATION_URL @"http://open.qyer.com/qyer/discount/local_discount?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&id=%@&lat=23.0120366459038&lon=113.2956755509944&oauth_token=df0f155bfc31a0dcc8affdf397bf9d06&order=2&page=%d&product_type=2410&time=1&track_app_channel=AppStore&track_app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3&track_user_id=7435631&type=1&v=1"

//tickets_freewalker
//10162C10182C1020
#define YSQ_FREEWALK_URL @"http://open.qyer.com/qyer/discount/%@?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&id=%@&lat=23.0120366459038&lon=113.2956755509944&oauth_token=df0f155bfc31a0dcc8affdf397bf9d06&order=2&page=%d&product_type=%@&time=1&track_app_channel=AppStore&track_app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3&track_user_id=7435631&type=%d&v=1"

//城市旅游精选
#define YSQ_CITY_CHOOSE_URL                                                        \
@"http://open.qyer.com/qyer/footprint/" @"mguide_list?client_id=qyer_"       \
@"android&client_secret=" @"9fcaae8aefc4f9ac4915&v="                     \
@"1&track_deviceid=862136026218809&track_app_version=6.8.1&track_app_"   \
@"channel=qq&track_device_info=Coolpad8297W&track_os=Android4.4.2&app_"  \
@"installtime=1445472814342&lat=40.11774&lon=116.257792&type=city&id=%@" \
@"&" @"count=20&page=%d"

//城市游玩
#define YSQ_CITY_PLAY_URL                                                          \
@"qyer/onroad/" @"poi_list?client_id=qyer_android&"     \
@"client_secret=9fcaae8aefc4f9ac4915&" @"v=1&"                           \
@"track_deviceid=862136026218809&track_app_version=6.8.1&track_app_"     \
@"channel=qq&track_device_info=Coolpad8297W&track_os=Android4.4.2&app_"  \
@"installtime=1445472814342&page=%d&city_id=%@&category_id=32,147,148&"  \
@"count=20&orderby=popular"

//城市美食

#define YSQ_CITY_FOOD_URL   @"qyer/onroad/poi_list?category_id=78&page=%d&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&oauth_token=df0f155bfc31a0dcc8affdf397bf9d06&orderby=popular&city_id=%@&track_app_channel=AppStore&track_app_version=6.8.4&track_device_info=iPhone7&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.2.1&track_user_id=7435631&types=&v=1"

//城市酒店
#define YSQ_CITY_HOTEL_URL @"qyer/hotel/search_list?checkin=2016-4-3&checkout=2016-4-4&city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&from_key=app_ios_city_search&lat=23.01208238609528&lon=113.2957274677111&oauth_token=df0f155bfc31a0dcc8affdf397bf9d06&orderby=1&page=%d&track_app_channel=AppStore&track_app_version=6.8.4&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.2.1&track_user_id=7435631&v=1"

//海外精选
#define YSQ_OVERSEA_SELECT_URL @"qyer/discount/get_cityfun?city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&lat=23.01219584888128&lon=113.2955871989143&page=%d&track_app_channel=AppStore&track_app_version=6.8.5&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.1&type=%d&v=1"

//城市地图
#define YSQ_CITY_MAP_URL @"qyer/map/poi_list?cate_id=%@&city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=60&lat=39.10284952193256&lon=121.8144046566587&oauth_token=9374328e00dd5a821829c27b7ff90573&order_type=1&page=1%@&track_app_channel=AppStore&track_app_version=6.9.2&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.2&track_user_id=7935321&uid=7935321&v=1"

//更多分类
#define YSQ_CITY_CATEGORY_URL @"qyer/place/city_poi_category?city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=39.10473008110427&lon=121.8125261655249&oauth_token=9374328e00dd5a821829c27b7ff90573&page=1&track_app_channel=AppStore&track_app_version=6.9.3&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.2&track_user_id=7935321&v=1"

/************************************商城*****************************************/
#define YSQ_MALL_URL @"qyer/discount/zk/discount_index?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=31.25403355168224&lon=121.6133930915044&oauth_token=9374328e00dd5a821829c27b7ff90573&page=1&track_app_channel=AppStore&track_app_version=7.0.1&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.4&track_user_id=7935321&v=1"



/************************************社区 ****************************************/
//社区
#define YSQ_BBS_URL   @"qyer/bbs/entry?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=39.10288814445452&lon=121.8143710028799&oauth_token=9374328e00dd5a821829c27b7ff90573&page=1&track_app_channel=AppStore&track_app_version=6.9.2&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.2&track_user_id=7935321&v=1"

//热门搜索记录
#define YSQ_BBS_HOT_SEARCH @"qyer/search/hot_history?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=31.25403355168224&lon=121.6133930915044&oauth_token=9374328e00dd5a821829c27b7ff90573&page=1&track_app_channel=AppStore&track_app_version=7.0.1&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.4&track_user_id=7935321&v=1"
//搜索
#define YSQ_SEARCH @"qyer/search/index?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&keyword=%@&lat=39.10287671273878&lon=121.8143606781396&oauth_token=9374328e00dd5a821829c27b7ff90573&page=%d&place_field=countrypoi&track_app_channel=AppStore&track_app_version=6.9.2&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.2&track_user_id=7935321&type=thread&v=1"

//热门BBS
#define YSQ_HOT_BBS_URL @"qyer/community/hotbbs/index?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&lat=39.10288814445452&lon=121.8143710028799&oauth_token=9374328e00dd5a821829c27b7ff90573&page=%d&track_app_channel=AppStore&track_app_version=6.9.2&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.2&track_user_id=7935321&v=1"

//找旅伴
#define YSQ_SEARCH_FRIEND_URL @"qyer/company/search_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=39.10288814445452&lon=121.8143710028799&oauth_token=9374328e00dd5a821829c27b7ff90573&page=%d&track_app_channel=AppStore&track_app_version=6.9.2&track_device_info=iPhone&track_deviceid=B501CB2C-FD57-433E-A7DF-2EC4937CD6AD&track_os=ios9.3.2&track_user_id=7935321&v=1"

//最新
#define YSQ_BBS_DETAIL_NEW_URL   @"qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_version=6.8.1&track_app_channel=qq&track_device_info=Coolpad8297W&track_os=Android4.4.2&app_installtime=1445472814342&lat=40.118145&lon=116.250982&forum_id=%@&forum_type=new&count=20&page=%d&delcache=0"

//攻略全部
#define YSQ_BBS_DETAIL_METHODAll_URL                                                            \
@"qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret="      \
@"9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_"    \
@"version=6.8.1&track_app_channel=qq&track_device_info=Coolpad8297W&"    \
@"track_"                                                                \
@"os=Android4.4.2&app_installtime=1445472814342&lat=40.118068&lon=116."  \
@"257868&forum_id=%@&forum_type=1,2,6&count=20&page=%d&delcache=0"

//精华
#define YSQ_BBS_DETAIL_ESSENCE_URL                                                        \
@"qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret="      \
@"9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_"    \
@"version=6.8.1&track_app_channel=qq&track_device_info=Coolpad8297W&"    \
@"track_"                                                                \
@"os=Android4.4.2&app_installtime=1445472814342&lat=40.118068&lon=116."  \
@"257868&forum_id=%@&forum_type=digest&count=20&page=%d&delcache=0"

//游记
#define YSQ_BBS_DETAIL_NOTE_URL                                                           \
@"qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret="      \
@"9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_"    \
@"version=6.8.1&track_app_channel=qq&track_device_info=Coolpad8297W&"    \
@"track_"                                                                \
@"os=Android4.4.2&app_installtime=1445472814342&lat=40.118068&lon=116."  \
@"257868&forum_id=%@&forum_type=1&count=20&page=%d&delcache=0"

//攻略
#define YSQ_BBS_DETAIL_METHOD_URL                                                         \
@"qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret="      \
@"9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_"    \
@"version=6.8.1&track_app_channel=qq&track_device_info=Coolpad8297W&"    \
@"track_"                                                                \
@"os=Android4.4.2&app_installtime=1445472814342&lat=40.118068&lon=116."  \
@"257868&forum_id=%@&forum_type=2&count=20&page=%d&delcache=0"

//结伴
#define YSQ_BBS_DETAIL_COMPANY_URL                                                        \
@"qyer/company/"                                                             \
@"together_list_by_fid?client_id=qyer_android&client_secret="            \
@"9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_"    \
@"version=6.8.1&track_app_channel=qq&track_device_info=Coolpad8297W&"    \
@"track_"                                                                \
@"os=Android4.4.2&app_installtime=1445472814342&lat=40.118068&lon=116."  \
@"257868&fid=%@&count=20&page=%d"

//问答
#define YSQ_BBS_DETAIL_ASK_URL                                                            \
@"qyer/ask/question/list_by_fid?client_id=qyer_android&client_secret="   \
@"9fcaae8aefc4f9ac4915&v="                                               \
@"1&track_deviceid=862136026218809&track_app_version=6.8.1&track_app_"   \
@"channel=qq&track_device_info=Coolpad8297W&track_os=Android4.4.2&app_"  \
@"installtime=1445472814342&lat=40.118068&lon=116.257868&fid=%@&count="  \
@"10&" @"page=%d"

//转让
#define YSQ_BBS_DETAIL_ASSIGN_URL                                                         \
@"qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret="      \
@"9fcaae8aefc4f9ac4915&v=1&track_deviceid=862136026218809&track_app_"    \
@"version=6.8.1&track_app_channel=qq&track_device_info=Coolpad8297W&"    \
@"track_"                                                                \
@"os=Android4.4.2&app_installtime=1445472814342&lat=40.118068&lon=116."  \
@"257868&forum_id=%@&forum_type=4&count=20&page=%d&delcache=0"
#endif /* URLHead_h */
