// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shoply Seller';

  @override
  String get sellerApp => 'Seller App';

  @override
  String get gotIt => 'Got it';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get save => 'Save';

  @override
  String get saved => 'Saved';

  @override
  String get saveError => 'Save Error';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get all => 'All';

  @override
  String get loading => 'Loading...';

  @override
  String get notSet => 'Not set';

  @override
  String get inStock => 'In Stock';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String updateFailed(String error) {
    return 'Update failed: $error';
  }

  @override
  String deleteFailed(String error) {
    return 'Delete failed: $error';
  }

  @override
  String unexpectedError(String error) {
    return 'Unexpected error: $error';
  }

  @override
  String get noOrdersYet => 'No orders yet';

  @override
  String get home => 'Home';

  @override
  String get products => 'Products';

  @override
  String get orders => 'Orders';

  @override
  String get more => 'More';

  @override
  String get customers => 'Customers';

  @override
  String get customer => 'Customer';

  @override
  String get today => 'Today';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get fullName => 'Full Name';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Email is not valid';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get fullNameRequired => 'Full Name is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get passwordWeak =>
      'Password must contain at least one uppercase letter and one special character';

  @override
  String get confirmPasswordRequired => 'Confirm Password is required';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInSubtitle => 'Sign in to manage your store';

  @override
  String get logIn => 'Log In';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get loginError => 'Login Error';

  @override
  String get createAccount => 'Create Your Account';

  @override
  String get signupSubtitle => 'Start managing your store';

  @override
  String get signUpWithGoogle => 'Sign up with Google';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get signupError => 'Sign Up Error';

  @override
  String get requestSent => 'Request Sent';

  @override
  String get signupSuccessMessage =>
      'Your account was created. You can log in once the store owner approves it.';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email and we\'ll send\nyou a reset link.';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get forgotPasswordError => 'Forgot Password Error';

  @override
  String get forgotPasswordSuccess => 'Forgot Password Success';

  @override
  String get resetEmailSent => 'Reset email sent successfully';

  @override
  String get errorInvalidCredential =>
      'Incorrect email or password. Please try again.';

  @override
  String get errorEmailInUse => 'This email address is already registered.';

  @override
  String get errorWeakPassword =>
      'The password entered is too weak. Try a longer combination.';

  @override
  String get errorInvalidEmail => 'Please enter a valid email address.';

  @override
  String get errorUserDisabled =>
      'This user account has been disabled. Contact support.';

  @override
  String get errorTooManyRequests =>
      'Too many login attempts. Please try again later.';

  @override
  String get errorAuthUnexpected =>
      'An unexpected authentication error occurred. Please try again.';

  @override
  String get googleSignInFailed => 'Google sign in failed';

  @override
  String get accountPendingApproval =>
      'Your account is waiting for approval from the store owner.';

  @override
  String get failedCreateAccount => 'Failed to create user account';

  @override
  String get failedSendRequest => 'Failed to send the request';

  @override
  String get goodMorning => 'Good Morning,';

  @override
  String get goodAfternoon => 'Good Afternoon,';

  @override
  String get goodEvening => 'Good Evening,';

  @override
  String get admin => 'Admin';

  @override
  String get pendingOrders => 'Pending orders';

  @override
  String failedLoadDashboard(String error) {
    return 'Failed to load dashboard:\n$error';
  }

  @override
  String lowStockWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products are running low on stock',
      one: '1 product is running low on stock',
    );
    return '$_temp0';
  }

  @override
  String get recentOrders => 'Recent Orders';

  @override
  String get seeAll => 'See All';

  @override
  String get totalSales => 'Total Sales';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisMonth => 'This Month';

  @override
  String get allTime => 'All Time';

  @override
  String get myProducts => 'My Products';

  @override
  String get searchProducts => 'Search products...';

  @override
  String get sort => 'Sort';

  @override
  String get sortBy => 'Sort by';

  @override
  String get sortName => 'Name';

  @override
  String get sortPriceLow => 'Price: low to high';

  @override
  String get sortPriceHigh => 'Price: high to low';

  @override
  String get sortStock => 'Lowest stock first';

  @override
  String failedLoadProducts(String error) {
    return 'Failed to load products:\n$error';
  }

  @override
  String get noProductsFound => 'No products found';

  @override
  String get productDetails => 'Product Details';

  @override
  String get deleteProductTitle => 'Delete product?';

  @override
  String deleteProductMessage(String name) {
    return '$name will be removed from the store.';
  }

  @override
  String get description => 'Description';

  @override
  String get noDescription => 'No description';

  @override
  String get stockQuantity => 'Stock Quantity';

  @override
  String get category => 'Category';

  @override
  String get editProduct => 'Edit Product';

  @override
  String get addProduct => 'Add Product';

  @override
  String get updateProduct => 'Update Product';

  @override
  String get saveProduct => 'Save Product';

  @override
  String get addImageRequired => 'Add at least one image';

  @override
  String couldNotLoadCategories(String error) {
    return 'Could not load categories: $error';
  }

  @override
  String get productName => 'Product Name';

  @override
  String get productNameRequired => 'Product Name is required';

  @override
  String get productNameHint => 'e.g. Wireless Headphones';

  @override
  String get descriptionHint => 'Write a short description...';

  @override
  String get price => 'Price';

  @override
  String get priceRequired => 'Price is required';

  @override
  String get priceInvalid => 'Price is not valid';

  @override
  String get stockRequired => 'Stock Quantity is required';

  @override
  String get stockInvalid => 'Stock Quantity is not valid';

  @override
  String get categoryRequired => 'Category is required';

  @override
  String get selectCategory => 'Select category';

  @override
  String get addProductImages => 'Add Product Images';

  @override
  String get tapToUpload => 'Tap to upload images';

  @override
  String get productUpdated => 'Product updated successfully';

  @override
  String get productAdded => 'Product added successfully';

  @override
  String get failedAddProduct => 'Failed to add product';

  @override
  String get failedUpdateProduct => 'Failed to update product';

  @override
  String get searchOrders => 'Search orders...';

  @override
  String failedLoadOrders(String error) {
    return 'Failed to load orders:\n$error';
  }

  @override
  String get noOrdersFound => 'No orders found';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusShipped => 'Shipped';

  @override
  String get statusDelivered => 'Delivered';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String orderMarkedAs(String status) {
    return 'Order marked as $status';
  }

  @override
  String get updateStatus => 'Update Status';

  @override
  String get updating => 'Updating...';

  @override
  String get cancelOrderTitle => 'Cancel order?';

  @override
  String get cancelOrderMessage =>
      'The customer will see this order as cancelled.';

  @override
  String get cancelOrder => 'Cancel order';

  @override
  String get keep => 'Keep';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get processingDate => 'Processing date';

  @override
  String get unknownCustomer => 'Unknown customer';

  @override
  String get viewProfile => 'View Profile';

  @override
  String get items => 'Items';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get shipping => 'Shipping';

  @override
  String get total => 'Total';

  @override
  String get searchCustomers => 'Search customers...';

  @override
  String failedLoadCustomers(String error) {
    return 'Failed to load customers:\n$error';
  }

  @override
  String get noCustomersFound => 'No customers found';

  @override
  String ordersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count orders',
      one: '1 order',
    );
    return '$_temp0';
  }

  @override
  String get username => 'Username';

  @override
  String get address => 'Address';

  @override
  String get totalSpent => 'Total spent';

  @override
  String get storeSettings => 'Store Settings';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get shippingSettings => 'Shipping Settings';

  @override
  String get storeName => 'Store Name';

  @override
  String get storeNameRequired => 'Store Name is required';

  @override
  String get contactEmail => 'Contact Email';

  @override
  String get contactPhone => 'Contact Phone';

  @override
  String get addressHint => 'City, street';

  @override
  String get paymentMethodsDescription =>
      'Choose the payment methods your store accepts.';

  @override
  String get paymentCash => 'Cash on delivery';

  @override
  String get paymentCard => 'Credit / debit card';

  @override
  String get paymentWallet => 'Mobile wallet';

  @override
  String get shippingFee => 'Shipping Fee';

  @override
  String get freeShippingOver => 'Free Shipping Over';

  @override
  String get freeShippingHint => 'Set to 0 to always charge the shipping fee.';

  @override
  String get amountRequired => 'Amount is required';

  @override
  String get amountInvalid => 'Amount is not valid';

  @override
  String failedLoadSettings(String error) {
    return 'Failed to load settings:\n$error';
  }

  @override
  String get settingsSaved => 'Settings saved successfully';

  @override
  String get loadSettingsFailed => 'Failed to load settings';

  @override
  String get saveSettingsFailed => 'Failed to save settings';

  @override
  String get storeOwner => 'Store Owner';

  @override
  String get notifications => 'Notifications';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get aboutApp => 'About App';

  @override
  String get logOut => 'Log Out';

  @override
  String logoutFailed(String error) {
    return 'Logout failed: $error';
  }

  @override
  String get logoutTitle => 'Leaving So Soon?';

  @override
  String get logoutMessage =>
      'Are you sure you want to log out of your Shoply Seller account?';

  @override
  String get logoutConfirm => 'Yes, Log Out';

  @override
  String get logoutCancel => 'Stay Here';

  @override
  String get language => 'Language';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System Default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get newOrders => 'New orders';

  @override
  String get newOrdersSubtitle =>
      'Show the number of pending orders on the bell';

  @override
  String get lowStock => 'Low stock';

  @override
  String get lowStockSubtitle =>
      'Warn on the home screen when a product has 5 or fewer left';

  @override
  String get helpQ1 => 'How do I add a product?';

  @override
  String get helpA1 =>
      'Open the Products tab and tap the + button. Add at least one image, fill in the details and tap Save Product.';

  @override
  String get helpQ2 => 'How do I hide a product from customers?';

  @override
  String get helpA2 =>
      'Turn off the switch next to the product in the Products tab, or the Active switch in the product details.';

  @override
  String get helpQ3 => 'How do I update an order?';

  @override
  String get helpA3 =>
      'Open the order from the Orders tab and tap Update Status. The customer sees the new status in their order history.';

  @override
  String get helpQ4 => 'Why does a product show \"Out of Stock\"?';

  @override
  String get helpA4 =>
      'Its stock quantity is 0. Edit the product and set a new stock quantity.';

  @override
  String get helpQ5 => 'How do I give someone else admin access?';

  @override
  String get helpA5 =>
      'They sign up in this app, then the store owner adds them to the admins collection in the Firebase console.';

  @override
  String get contactSubtitle =>
      'Having a problem with the app? Send us a message.';

  @override
  String get subject => 'Subject';

  @override
  String get subjectRequired => 'Subject is required';

  @override
  String get messageHint => 'Write your message...';

  @override
  String get messageRequired => 'Message is required';

  @override
  String get send => 'Send';

  @override
  String get sending => 'Sending...';

  @override
  String get messageSent => 'Message sent, we will get back to you soon';

  @override
  String sendFailed(String error) {
    return 'Send failed: $error';
  }

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String get aboutTheApplication => 'About the Application';

  @override
  String get aboutDescription =>
      'Shoply Seller is the store management app for Shoply. Store owners can follow their sales, add and edit products, manage stock, update order statuses and see their customers, all from the same data the Shoply shopping app uses.';
}
