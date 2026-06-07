import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';

ServiceTemplateModel _template(
  String id,
  String nameEn,
  String nameAr,
  CommitmentCategory category,
  double defaultAmount,
  BillingCycle cycle,
  String iconName,
) {
  return ServiceTemplateModel(
    id: id,
    nameEn: nameEn,
    nameAr: nameAr,
    category: category,
    defaultAmount: defaultAmount,
    defaultBillingCycle: cycle,
    iconName: iconName,
  );
}

/// Built-in service templates — suggested defaults only.
List<ServiceTemplateModel> buildTemplateEntries() {
  const entertainment = CommitmentCategory.entertainment;
  const work = CommitmentCategory.work;
  const education = CommitmentCategory.education;
  const telecom = CommitmentCategory.telecom;
  const utilities = CommitmentCategory.utilities;
  const storage = CommitmentCategory.storage;
  const other = CommitmentCategory.other;
  const monthly = BillingCycle.monthly;
  const yearly = BillingCycle.yearly;
  const quarterly = BillingCycle.quarterly;

  return [
    // Entertainment (25)
    _template('netflix', 'Netflix', 'نتفليكس', entertainment, 49, monthly, 'movie'),
    _template('spotify', 'Spotify', 'سبوتify', entertainment, 21.99, monthly, 'music_note'),
    _template('disney_plus', 'Disney+', 'ديزني+', entertainment, 39.99, monthly, 'movie'),
    _template('amazon_prime', 'Amazon Prime Video', 'أمازون برايم', entertainment, 16, monthly, 'play_circle'),
    _template('apple_tv', 'Apple TV+', 'Apple TV+', entertainment, 29.99, monthly, 'play_circle'),
    _template('hbo_max', 'Max (HBO)', 'ماكس', entertainment, 44.99, monthly, 'movie'),
    _template('youtube_premium', 'YouTube Premium', 'يوتيوب بريميوم', entertainment, 29.99, monthly, 'play_circle'),
    _template('shahid', 'Shahid VIP', 'شاهد VIP', entertainment, 39.99, monthly, 'movie'),
    _template('osn_plus', 'OSN+', 'OSN+', entertainment, 49.99, monthly, 'movie'),
    _template('starz_play', 'StarzPlay', 'ستارز بلاي', entertainment, 39.99, monthly, 'movie'),
    _template('anghami', 'Anghami Plus', 'أنغامي بلس', entertainment, 19.99, monthly, 'music_note'),
    _template('deezer', 'Deezer Premium', 'ديزر', entertainment, 19.99, monthly, 'music_note'),
    _template('tidal', 'Tidal HiFi', 'تايدال', entertainment, 29.99, monthly, 'music_note'),
    _template('audible', 'Audible', 'أودible', entertainment, 49.99, monthly, 'music_note'),
    _template('playstation_plus', 'PlayStation Plus', 'بلايستيشن بلس', entertainment, 49.99, monthly, 'play_circle'),
    _template('xbox_game_pass', 'Xbox Game Pass', 'Xbox Game Pass', entertainment, 44.99, monthly, 'play_circle'),
    _template('nintendo_online', 'Nintendo Switch Online', 'نينتendo أونلاين', entertainment, 19.99, yearly, 'play_circle'),
    _template('crunchyroll', 'Crunchyroll', 'كرانشyroll', entertainment, 29.99, monthly, 'movie'),
    _template('apple_music', 'Apple Music', 'Apple Music', entertainment, 19.99, monthly, 'music_note'),
    _template('bein_connect', 'beIN CONNECT', 'beIN CONNECT', entertainment, 49.99, monthly, 'movie'),
    _template('twitch', 'Twitch Turbo', 'Twitch Turbo', entertainment, 39.99, monthly, 'play_circle'),
    _template('paramount_plus', 'Paramount+', 'Paramount+', entertainment, 29.99, monthly, 'movie'),
    _template('peacock', 'Peacock Premium', 'Peacock', entertainment, 24.99, monthly, 'movie'),
    _template('hulu', 'Hulu', 'Hulu', entertainment, 29.99, monthly, 'movie'),
    _template('soundcloud_go', 'SoundCloud Go+', 'SoundCloud Go+', entertainment, 19.99, monthly, 'music_note'),

    // Work (15)
    _template('microsoft_365', 'Microsoft 365', 'Microsoft 365', work, 39.99, monthly, 'work'),
    _template('google_workspace', 'Google Workspace', 'Google Workspace', work, 24, monthly, 'work'),
    _template('slack', 'Slack Pro', 'Slack Pro', work, 32.5, monthly, 'work'),
    _template('zoom', 'Zoom Pro', 'Zoom Pro', work, 49.99, monthly, 'work'),
    _template('notion', 'Notion Plus', 'Notion Plus', work, 40, monthly, 'work'),
    _template('adobe_creative_cloud', 'Adobe Creative Cloud', 'Adobe Creative Cloud', work, 89.99, monthly, 'work'),
    _template('figma', 'Figma Professional', 'Figma Professional', work, 45, monthly, 'work'),
    _template('github', 'GitHub Pro', 'GitHub Pro', work, 19, monthly, 'work'),
    _template('linkedin_premium', 'LinkedIn Premium', 'LinkedIn Premium', work, 149.99, monthly, 'work'),
    _template('canva_pro', 'Canva Pro', 'Canva Pro', work, 54.99, monthly, 'work'),
    _template('dropbox_business', 'Dropbox Business', 'Dropbox Business', work, 75, monthly, 'work'),
    _template('todoist', 'Todoist Pro', 'Todoist Pro', work, 24, monthly, 'work'),
    _template('evernote', 'Evernote Personal', 'Evernote', work, 34.99, monthly, 'work'),
    _template('asana', 'Asana Premium', 'Asana Premium', work, 49.99, monthly, 'work'),
    _template('monday_com', 'monday.com', 'monday.com', work, 48, monthly, 'work'),

    // Education (15)
    _template('coursera', 'Coursera Plus', 'Coursera Plus', education, 149.99, monthly, 'school'),
    _template('udemy', 'Udemy Personal Plan', 'Udemy', education, 99.99, monthly, 'school'),
    _template('linkedin_learning', 'LinkedIn Learning', 'LinkedIn Learning', education, 99.99, monthly, 'school'),
    _template('duolingo_plus', 'Duolingo Super', 'Duolingo Super', education, 39.99, monthly, 'school'),
    _template('skillshare', 'Skillshare Premium', 'Skillshare', education, 99, yearly, 'school'),
    _template('masterclass', 'MasterClass', 'MasterClass', education, 120, yearly, 'school'),
    _template('brilliant', 'Brilliant Premium', 'Brilliant', education, 99.99, yearly, 'school'),
    _template('pluralsight', 'Pluralsight', 'Pluralsight', education, 149, monthly, 'school'),
    _template('edx', 'edX Pro', 'edX Pro', education, 59.99, monthly, 'school'),
    _template('babbel', 'Babbel', 'Babbel', education, 49.99, monthly, 'school'),
    _template('rosetta_stone', 'Rosetta Stone', 'Rosetta Stone', education, 79.99, monthly, 'school'),
    _template('khan_academy', 'Khan Academy Donation', 'Khan Academy', education, 10, monthly, 'school'),
    _template('treehouse', 'Treehouse', 'Treehouse', education, 49.99, monthly, 'school'),
    _template('codecademy', 'Codecademy Pro', 'Codecademy Pro', education, 39.99, monthly, 'school'),
    _template('madrasati', 'Madrasati Platform', 'منصة مدرستي', education, 0, yearly, 'school'),

    // Telecom (20)
    _template('stc', 'STC Mobile', 'STC موبايل', telecom, 150, monthly, 'phone_iphone'),
    _template('mobily', 'Mobily', 'موبايلي', telecom, 120, monthly, 'signal_cellular_alt'),
    _template('zain', 'Zain', 'زين', telecom, 130, monthly, 'wifi'),
    _template('virgin_mobile', 'Virgin Mobile', 'Virgin Mobile', telecom, 99, monthly, 'phone_iphone'),
    _template('lebara', 'Lebara', 'Lebara', telecom, 79, monthly, 'phone_iphone'),
    _template('salam_mobile', 'Salam Mobile', 'سلام موبايل', telecom, 89, monthly, 'signal_cellular_alt'),
    _template('stc_fiber', 'STC Fiber', 'STC فايبر', telecom, 299, monthly, 'router'),
    _template('mobily_fiber', 'Mobily Fiber', 'موبايلي فايبر', telecom, 279, monthly, 'router'),
    _template('zain_fiber', 'Zain Fiber', 'زين فايبر', telecom, 289, monthly, 'router'),
    _template('stc_landline', 'STC Landline', 'STC خط أرضي', telecom, 99, monthly, 'phone_iphone'),
    _template('google_fi', 'Google Fi', 'Google Fi', telecom, 65, monthly, 'phone_iphone'),
    _template('verizon', 'Verizon', 'Verizon', telecom, 80, monthly, 'signal_cellular_alt'),
    _template('tmobile', 'T-Mobile', 'T-Mobile', telecom, 75, monthly, 'signal_cellular_alt'),
    _template('att', 'AT&T', 'AT&T', telecom, 85, monthly, 'signal_cellular_alt'),
    _template('orange', 'Orange', 'Orange', telecom, 70, monthly, 'wifi'),
    _template('vodafone', 'Vodafone', 'Vodafone', telecom, 65, monthly, 'wifi'),
    _template('etisalat', 'Etisalat', 'اتصالات', telecom, 140, monthly, 'phone_iphone'),
    _template('du', 'du', 'du', telecom, 135, monthly, 'phone_iphone'),
    _template('ooredoo', 'Ooredoo', 'Ooredoo', telecom, 125, monthly, 'signal_cellular_alt'),
    _template('virgin_red', 'Virgin Red', 'Virgin Red', telecom, 109, monthly, 'phone_iphone'),

    // Utilities (15)
    _template('electricity', 'Electricity', 'الكهرباء', utilities, 250, monthly, 'bolt'),
    _template('water', 'Water', 'المياه', utilities, 80, monthly, 'water_drop'),
    _template('gas', 'Natural gas', 'الغاز', utilities, 120, monthly, 'bolt'),
    _template('internet_home', 'Home internet', 'إنترنت منزلي', utilities, 299, monthly, 'router'),
    _template('sewage', 'Sewage', 'صرف صحي', utilities, 45, monthly, 'water_drop'),
    _template('municipality_fees', 'Municipality fees', 'رسوم بلدية', utilities, 200, yearly, 'home'),
    _template('home_insurance_util', 'Home insurance', 'تأمين منزل', utilities, 800, yearly, 'shield'),
    _template('car_insurance_util', 'Car insurance', 'تأمين سيارة', utilities, 1200, yearly, 'shield'),
    _template('health_insurance', 'Health insurance', 'تأمين صحي', utilities, 600, monthly, 'shield'),
    _template('pest_control', 'Pest control', 'مكافحة حشرات', utilities, 150, quarterly, 'home'),
    _template('home_maintenance', 'Home maintenance', 'صيانة منزل', utilities, 300, quarterly, 'home'),
    _template('ac_maintenance', 'AC maintenance', 'صيانة مكيف', utilities, 200, quarterly, 'bolt'),
    _template('cleaning_service', 'Cleaning service', 'خدمة تنظيف', utilities, 400, monthly, 'home'),
    _template('security_service', 'Security monitoring', 'مراقبة أمنية', utilities, 199, monthly, 'shield'),
    _template('waste_management', 'Waste management', 'إدارة نفايات', utilities, 60, monthly, 'home'),

    // Storage (10)
    _template('icloud', 'iCloud+', 'iCloud+', storage, 12.99, monthly, 'cloud'),
    _template('google_one', 'Google One', 'Google One', storage, 9.99, monthly, 'cloud'),
    _template('dropbox', 'Dropbox Plus', 'Dropbox Plus', storage, 39.99, monthly, 'cloud'),
    _template('onedrive', 'OneDrive', 'OneDrive', storage, 27, monthly, 'cloud'),
    _template('amazon_photos', 'Amazon Photos', 'Amazon Photos', storage, 19.99, monthly, 'cloud'),
    _template('pcloud', 'pCloud', 'pCloud', storage, 49.99, yearly, 'cloud'),
    _template('box', 'Box Personal Pro', 'Box', storage, 50, monthly, 'cloud'),
    _template('sync_com', 'Sync.com', 'Sync.com', storage, 96, yearly, 'cloud'),
    _template('mega', 'MEGA', 'MEGA', storage, 99.99, yearly, 'cloud'),
    _template('backblaze', 'Backblaze', 'Backblaze', storage, 70, yearly, 'cloud'),

    // Other (15)
    _template('rent', 'Rent', 'الإيجار', other, 3500, monthly, 'home'),
    _template('car_finance', 'Car finance', 'تمويل سيارة', other, 1200, monthly, 'directions_car'),
    _template('car_lease', 'Car lease', 'إيجار سيارة', other, 1500, monthly, 'directions_car'),
    _template('gym', 'Gym membership', 'اشتراك نادي', other, 299, monthly, 'fitness_center'),
    _template('school_fees', 'School fees', 'رسوم مدرسة', other, 5000, quarterly, 'school'),
    _template('university_tuition', 'University tuition', 'رسوم جامعة', other, 15000, quarterly, 'school'),
    _template('childcare', 'Childcare', 'رعاية أطفال', other, 2000, monthly, 'home'),
    _template('pet_insurance', 'Pet insurance', 'تأمين حيوانات', other, 99, monthly, 'shield'),
    _template('parking', 'Parking', 'موقف سيارات', other, 200, monthly, 'directions_car'),
    _template('toll_road', 'Toll road pass', 'تصريح طرق', other, 150, monthly, 'directions_car'),
    _template('domain_hosting', 'Domain & hosting', 'نطاق واستضافة', other, 49.99, yearly, 'cloud'),
    _template('vpn', 'VPN subscription', 'VPN', other, 39.99, yearly, 'shield'),
    _template('charity', 'Charity donation', 'تبرع خيري', other, 100, monthly, 'home'),
    _template('club_membership', 'Club membership', 'عضوية نادي', other, 500, yearly, 'fitness_center'),
    _template('newspaper', 'Newspaper subscription', 'اشتراك صحيفة', other, 29.99, monthly, 'receipt_long'),
  ];
}
