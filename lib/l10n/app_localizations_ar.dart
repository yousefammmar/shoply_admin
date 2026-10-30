// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Shoply للبائعين';

  @override
  String get sellerApp => 'تطبيق البائع';

  @override
  String get gotIt => 'حسنًا';

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get pleaseWait => 'يرجى الانتظار...';

  @override
  String get orContinueWith => 'أو تابع باستخدام';

  @override
  String get save => 'حفظ';

  @override
  String get saved => 'تم الحفظ';

  @override
  String get saveError => 'خطأ في الحفظ';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get active => 'نشط';

  @override
  String get inactive => 'غير نشط';

  @override
  String get all => 'الكل';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get notSet => 'غير محدد';

  @override
  String get inStock => 'متوفر';

  @override
  String get outOfStock => 'نفد المخزون';

  @override
  String updateFailed(String error) {
    return 'فشل التحديث: $error';
  }

  @override
  String deleteFailed(String error) {
    return 'فشل الحذف: $error';
  }

  @override
  String unexpectedError(String error) {
    return 'خطأ غير متوقع: $error';
  }

  @override
  String get noOrdersYet => 'لا توجد طلبات بعد';

  @override
  String get home => 'الرئيسية';

  @override
  String get products => 'المنتجات';

  @override
  String get orders => 'الطلبات';

  @override
  String get more => 'المزيد';

  @override
  String get customers => 'العملاء';

  @override
  String get customer => 'العميل';

  @override
  String get today => 'اليوم';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailInvalid => 'البريد الإلكتروني غير صالح';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get fullNameRequired => 'الاسم الكامل مطلوب';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get passwordWeak =>
      'يجب أن تحتوي كلمة المرور على حرف كبير واحد ورمز خاص واحد على الأقل';

  @override
  String get confirmPasswordRequired => 'تأكيد كلمة المرور مطلوب';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get signInSubtitle => 'سجّل الدخول لإدارة متجرك';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get signInWithGoogle => 'تسجيل الدخول باستخدام Google';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get loginError => 'خطأ في تسجيل الدخول';

  @override
  String get createAccount => 'أنشئ حسابك';

  @override
  String get signupSubtitle => 'ابدأ بإدارة متجرك';

  @override
  String get signUpWithGoogle => 'إنشاء حساب باستخدام Google';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get signupError => 'خطأ في إنشاء الحساب';

  @override
  String get requestSent => 'تم إرسال الطلب';

  @override
  String get signupSuccessMessage =>
      'تم إنشاء حسابك. يمكنك تسجيل الدخول بعد موافقة مالك المتجر عليه.';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني وسنرسل لك\nرابط إعادة التعيين.';

  @override
  String get sendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get backToLogin => 'العودة لتسجيل الدخول';

  @override
  String get forgotPasswordError => 'خطأ في استعادة كلمة المرور';

  @override
  String get forgotPasswordSuccess => 'تم الإرسال بنجاح';

  @override
  String get resetEmailSent => 'تم إرسال رسالة إعادة التعيين بنجاح';

  @override
  String get errorInvalidCredential =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة. يرجى المحاولة مرة أخرى.';

  @override
  String get errorEmailInUse => 'عنوان البريد الإلكتروني هذا مسجّل بالفعل.';

  @override
  String get errorWeakPassword =>
      'كلمة المرور المدخلة ضعيفة جدًا. جرّب مزيجًا أطول.';

  @override
  String get errorInvalidEmail => 'يرجى إدخال عنوان بريد إلكتروني صالح.';

  @override
  String get errorUserDisabled => 'تم تعطيل حساب المستخدم هذا. تواصل مع الدعم.';

  @override
  String get errorTooManyRequests =>
      'محاولات تسجيل دخول كثيرة جدًا. يرجى المحاولة لاحقًا.';

  @override
  String get errorAuthUnexpected =>
      'حدث خطأ غير متوقع في المصادقة. يرجى المحاولة مرة أخرى.';

  @override
  String get googleSignInFailed => 'فشل تسجيل الدخول باستخدام Google';

  @override
  String get accountPendingApproval => 'حسابك بانتظار موافقة مالك المتجر.';

  @override
  String get failedCreateAccount => 'فشل إنشاء حساب المستخدم';

  @override
  String get failedSendRequest => 'فشل إرسال الطلب';

  @override
  String get goodMorning => 'صباح الخير،';

  @override
  String get goodAfternoon => 'نهارك سعيد،';

  @override
  String get goodEvening => 'مساء الخير،';

  @override
  String get admin => 'المسؤول';

  @override
  String get pendingOrders => 'الطلبات المعلّقة';

  @override
  String failedLoadDashboard(String error) {
    return 'فشل تحميل لوحة التحكم:\n$error';
  }

  @override
  String lowStockWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'مخزون $count منتج على وشك النفاد',
      many: 'مخزون $count منتجًا على وشك النفاد',
      few: 'مخزون $count منتجات على وشك النفاد',
      two: 'مخزون منتجين على وشك النفاد',
      one: 'مخزون منتج واحد على وشك النفاد',
    );
    return '$_temp0';
  }

  @override
  String get recentOrders => 'أحدث الطلبات';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get totalSales => 'إجمالي المبيعات';

  @override
  String get thisWeek => 'هذا الأسبوع';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get allTime => 'كل الأوقات';

  @override
  String get myProducts => 'منتجاتي';

  @override
  String get searchProducts => 'ابحث عن المنتجات...';

  @override
  String get sort => 'ترتيب';

  @override
  String get sortBy => 'ترتيب حسب';

  @override
  String get sortName => 'الاسم';

  @override
  String get sortPriceLow => 'السعر: من الأقل إلى الأعلى';

  @override
  String get sortPriceHigh => 'السعر: من الأعلى إلى الأقل';

  @override
  String get sortStock => 'الأقل مخزونًا أولًا';

  @override
  String failedLoadProducts(String error) {
    return 'فشل تحميل المنتجات:\n$error';
  }

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات';

  @override
  String get productDetails => 'تفاصيل المنتج';

  @override
  String get deleteProductTitle => 'حذف المنتج؟';

  @override
  String deleteProductMessage(String name) {
    return 'ستتم إزالة $name من المتجر.';
  }

  @override
  String get description => 'الوصف';

  @override
  String get noDescription => 'لا يوجد وصف';

  @override
  String get stockQuantity => 'كمية المخزون';

  @override
  String get category => 'الفئة';

  @override
  String get editProduct => 'تعديل المنتج';

  @override
  String get addProduct => 'إضافة منتج';

  @override
  String get updateProduct => 'تحديث المنتج';

  @override
  String get saveProduct => 'حفظ المنتج';

  @override
  String get addImageRequired => 'أضف صورة واحدة على الأقل';

  @override
  String couldNotLoadCategories(String error) {
    return 'تعذّر تحميل الفئات: $error';
  }

  @override
  String get productName => 'اسم المنتج';

  @override
  String get productNameRequired => 'اسم المنتج مطلوب';

  @override
  String get productNameHint => 'مثال: سماعات لاسلكية';

  @override
  String get descriptionHint => 'اكتب وصفًا قصيرًا...';

  @override
  String get price => 'السعر';

  @override
  String get priceRequired => 'السعر مطلوب';

  @override
  String get priceInvalid => 'السعر غير صالح';

  @override
  String get stockRequired => 'كمية المخزون مطلوبة';

  @override
  String get stockInvalid => 'كمية المخزون غير صالحة';

  @override
  String get categoryRequired => 'الفئة مطلوبة';

  @override
  String get selectCategory => 'اختر الفئة';

  @override
  String get addProductImages => 'أضف صور المنتج';

  @override
  String get tapToUpload => 'اضغط لرفع الصور';

  @override
  String get productUpdated => 'تم تحديث المنتج بنجاح';

  @override
  String get productAdded => 'تمت إضافة المنتج بنجاح';

  @override
  String get failedAddProduct => 'فشل إضافة المنتج';

  @override
  String get failedUpdateProduct => 'فشل تحديث المنتج';

  @override
  String get searchOrders => 'ابحث عن الطلبات...';

  @override
  String failedLoadOrders(String error) {
    return 'فشل تحميل الطلبات:\n$error';
  }

  @override
  String get noOrdersFound => 'لم يتم العثور على طلبات';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusShipped => 'تم الشحن';

  @override
  String get statusDelivered => 'تم التوصيل';

  @override
  String get statusCancelled => 'ملغي';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر',
      many: '$count عنصرًا',
      few: '$count عناصر',
      two: 'عنصران',
      one: 'عنصر واحد',
      zero: 'لا عناصر',
    );
    return '$_temp0';
  }

  @override
  String orderMarkedAs(String status) {
    return 'تم تغيير حالة الطلب إلى $status';
  }

  @override
  String get updateStatus => 'تحديث الحالة';

  @override
  String get updating => 'جارٍ التحديث...';

  @override
  String get cancelOrderTitle => 'إلغاء الطلب؟';

  @override
  String get cancelOrderMessage => 'سيظهر هذا الطلب للعميل على أنه ملغي.';

  @override
  String get cancelOrder => 'إلغاء الطلب';

  @override
  String get keep => 'إبقاء';

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get processingDate => 'التاريخ قيد المعالجة';

  @override
  String get unknownCustomer => 'عميل غير معروف';

  @override
  String get viewProfile => 'عرض الملف';

  @override
  String get items => 'العناصر';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get shipping => 'الشحن';

  @override
  String get total => 'الإجمالي';

  @override
  String get searchCustomers => 'ابحث عن العملاء...';

  @override
  String failedLoadCustomers(String error) {
    return 'فشل تحميل العملاء:\n$error';
  }

  @override
  String get noCustomersFound => 'لم يتم العثور على عملاء';

  @override
  String ordersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طلب',
      many: '$count طلبًا',
      few: '$count طلبات',
      two: 'طلبان',
      one: 'طلب واحد',
      zero: 'لا طلبات',
    );
    return '$_temp0';
  }

  @override
  String get username => 'اسم المستخدم';

  @override
  String get address => 'العنوان';

  @override
  String get totalSpent => 'إجمالي الإنفاق';

  @override
  String get storeSettings => 'إعدادات المتجر';

  @override
  String get paymentMethods => 'طرق الدفع';

  @override
  String get shippingSettings => 'إعدادات الشحن';

  @override
  String get storeName => 'اسم المتجر';

  @override
  String get storeNameRequired => 'اسم المتجر مطلوب';

  @override
  String get contactEmail => 'البريد الإلكتروني للتواصل';

  @override
  String get contactPhone => 'هاتف التواصل';

  @override
  String get addressHint => 'المدينة، الشارع';

  @override
  String get paymentMethodsDescription => 'اختر طرق الدفع التي يقبلها متجرك.';

  @override
  String get paymentCash => 'الدفع عند الاستلام';

  @override
  String get paymentCard => 'بطاقة ائتمان / خصم';

  @override
  String get paymentWallet => 'محفظة إلكترونية';

  @override
  String get shippingFee => 'رسوم الشحن';

  @override
  String get freeShippingOver => 'شحن مجاني للطلبات فوق';

  @override
  String get freeShippingHint => 'اضبطها على 0 لفرض رسوم الشحن دائمًا.';

  @override
  String get amountRequired => 'المبلغ مطلوب';

  @override
  String get amountInvalid => 'المبلغ غير صالح';

  @override
  String failedLoadSettings(String error) {
    return 'فشل تحميل الإعدادات:\n$error';
  }

  @override
  String get settingsSaved => 'تم حفظ الإعدادات بنجاح';

  @override
  String get loadSettingsFailed => 'فشل تحميل الإعدادات';

  @override
  String get saveSettingsFailed => 'فشل حفظ الإعدادات';

  @override
  String get storeOwner => 'مالك المتجر';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get contactUs => 'تواصل معنا';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String logoutFailed(String error) {
    return 'فشل تسجيل الخروج: $error';
  }

  @override
  String get logoutTitle => 'هل ستغادر بهذه السرعة؟';

  @override
  String get logoutMessage =>
      'هل أنت متأكد من رغبتك في تسجيل الخروج من حسابك في Shoply للبائعين؟';

  @override
  String get logoutConfirm => 'نعم، سجّل خروجي';

  @override
  String get logoutCancel => 'البقاء هنا';

  @override
  String get language => 'اللغة';

  @override
  String get appearance => 'المظهر';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeSystem => 'حسب إعدادات النظام';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get newOrders => 'الطلبات الجديدة';

  @override
  String get newOrdersSubtitle => 'عرض عدد الطلبات المعلّقة على أيقونة الجرس';

  @override
  String get lowStock => 'انخفاض المخزون';

  @override
  String get lowStockSubtitle =>
      'التنبيه في الشاشة الرئيسية عندما يتبقى 5 قطع أو أقل من أي منتج';

  @override
  String get helpQ1 => 'كيف أضيف منتجًا؟';

  @override
  String get helpA1 =>
      'افتح تبويب المنتجات واضغط على زر +. أضف صورة واحدة على الأقل، واملأ التفاصيل، ثم اضغط على «حفظ المنتج».';

  @override
  String get helpQ2 => 'كيف أخفي منتجًا عن العملاء؟';

  @override
  String get helpA2 =>
      'أوقف المفتاح بجانب المنتج في تبويب المنتجات، أو مفتاح «نشط» في تفاصيل المنتج.';

  @override
  String get helpQ3 => 'كيف أحدّث طلبًا؟';

  @override
  String get helpA3 =>
      'افتح الطلب من تبويب الطلبات واضغط على «تحديث الحالة». سيرى العميل الحالة الجديدة في سجل طلباته.';

  @override
  String get helpQ4 => 'لماذا يظهر المنتج «نفد المخزون»؟';

  @override
  String get helpA4 => 'لأن كمية مخزونه 0. عدّل المنتج وحدّد كمية مخزون جديدة.';

  @override
  String get helpQ5 => 'كيف أمنح شخصًا آخر صلاحية المسؤول؟';

  @override
  String get helpA5 =>
      'يُنشئ حسابًا في هذا التطبيق، ثم يضيفه مالك المتجر إلى مجموعة admins في وحدة تحكم Firebase.';

  @override
  String get contactSubtitle => 'هل تواجه مشكلة في التطبيق؟ أرسل لنا رسالة.';

  @override
  String get subject => 'الموضوع';

  @override
  String get subjectRequired => 'الموضوع مطلوب';

  @override
  String get messageHint => 'اكتب رسالتك...';

  @override
  String get messageRequired => 'الرسالة مطلوبة';

  @override
  String get send => 'إرسال';

  @override
  String get sending => 'جارٍ الإرسال...';

  @override
  String get messageSent => 'تم إرسال الرسالة، وسنعود إليك قريبًا';

  @override
  String sendFailed(String error) {
    return 'فشل الإرسال: $error';
  }

  @override
  String appVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get aboutTheApplication => 'عن التطبيق';

  @override
  String get aboutDescription =>
      'Shoply للبائعين هو تطبيق إدارة المتجر الخاص بـ Shoply. يمكن لأصحاب المتاجر متابعة مبيعاتهم، وإضافة المنتجات وتعديلها، وإدارة المخزون، وتحديث حالات الطلبات، والاطلاع على عملائهم، وكل ذلك من البيانات نفسها التي يستخدمها تطبيق التسوق Shoply.';
}
