class AppStrings {
  static String appName = "Invoice Builder";
  static String fontName = "PTSerif";

  // Linking screen : //! Editer avec prudence les liens de routage de page pointer
  static String splashScreenTag = '/';
  static String homeScreenTag = '/home_screen';
  static String loginScreenTag = '/login_screen';
  static String registerScreenTag = '/register_screen';
  static String invoiceScreenTag = '/new_invoice';
  static String businessScreenTag = '/add_business';
  static String cutommerScreenTag = '/add_customer';
  static String paymentScreenTag = '/add_payment';
  static String itemScreenTag = '/add_products';
  static String signatureScreenTag = '/sign_invoice';
  static String previewScreenTag = '/build_preview';
  static String notificationScreenSag = '/notification';
  static String contactScreenSag = '/contact_screen_tag';
  static String onbordingScreenTag = '/onbording';
  static String tempDetailScreenTag = '/tempDetail_screen_tag';
  static String tempScreenTag = '/temp_screen_tag';
  static String lastTempScreenTag = '/last_temp_screen_tag';

  static String defaultUsername = 'User';
  static String defaultNotifEmail = '@user';
  // Message Snackbar Text
  static String businessErrorScreenText =
      'Please Fill all the required fields for validate business sections.';
  static String customerErrorScreenText =
      'Please Fill all the required fields for validate customers sections.';
  static String paymentErrorScreenText = 'Please check your entries and try again!';
  static String tabRepresentDataErrorScreenTextI = 'Please speficify new value.';
  static String tabRepresentDataErrorScreenTextII = 'Please speficify new price.';
  static String tabRepresentDataErrorScreenTextIII = 'Please speficify new value.';
  static String invoicePreviewErrorScreenText =
      'Error: You must fill in information that will constitute your invoice. Please fill them in! ';
  static String invoiceSaveErrorScreenText =
      'Please you should filled all box for build with successfully your invoice';
  static List<String> authentificationMessage = [
    'Failed Autentification',
    'Autentification has canceled',
    'Autentification has canceled'
  ];
  // Shared Widgets
  static String textSaveBtn = 'Save';
  static String textCreateBtn = 'Create';
  static String textRetryBtn = 'Retry';
  static String textClosePreviewBtn = 'Close Preview';
  static String textWithGoogle = 'Continue with Google';
  static String textWithApple = 'Continue with Apple';
  // Text Data Pdf Gen Ai Screen
  static List<String> headers = ['Item Description', 'Qty', 'Price', 'Total'];
  // Text On Login Screen
  static String textTitleLoginScreen = 'Login';
  static String textSubtitleLoginScreen = 'Easy, Efficient and Productive.';
  static String textDescLoginScreen =
      'Invoice creator allows you to build different invoices in a professional way with thousands of free templates. Log in and build invoices for your customers.';
  static String textLoginEmail = 'Email', textLoginEmailHint = 'hello@outlook.com';
  static String textLoginPassword = 'Password', textLoginPasswordHint = 'You password';
  static String textForgotLoginPassword = 'Forgot password?';
  static String textLoginBtn = 'Login';
  static String textOrLogin = 'Or';
  // Text On Register Screen
  static String textRegisterOnbordingScreen = 'Register';
  static String textSkipOnbordingScreen = 'Skip';
  static String textTitleOnbordingIScreen = 'Hola, no time to lose, ';
  static String textDescOnbordingIScreen =
      'Invoice builder takes care of it, thanks to thousands of models, quickly build an invoice for your business.';
  static String textTitleOnbordingIIScreen = 'Better results with one click';
  static String textDescOnbordingIIScreen =
      'Surprise your customers with modern billing models with models built for your business.';
  static String textTitleOnbordingIIIScreen = 'Powerfull in Desktop version';
  static String textDescOnbordingIIIScreen =
      'Build the fast invoice with more details and precision, with the desktop version.';
  // Text On Preview Invoice Screen
  static String textTitlePreviewInvoiceScreen = 'Invoice Preview';
  static String textGenPreviewInvoiceScreen = 'Generate Preview, please wait';
  // Text On Invoice Screen
  static String textTitleInvoiceScreen = 'Create Invoice';
  static String textInvoice = 'Invoice#';
  static String textInvoiceDate = 'Invoice date';
  static String textInvoiceCustomer = 'Add Customers';
  static String textInvoiceManageProduct = 'Manage Products';
  static String textInvoiceBusiness = 'My Business';
  static String textInvoicePayment = 'Payment';
  static String textInvoicePaymentInstruction = 'Payment Instructions';
  static String textInvoiceSignature = 'Signature';
  static String textInvoicePreview = 'Preview';
  // Text On Business Composite Invoice Screen
  static String textTitleBusinessComposite = 'My Business';
  static String textBssTitleNameComposite = 'Business Name';
  static String textBssTitleNameHintComposite = 'Type you name business';
  static String textBssTitleEmailComposite = 'Email Address';
  static String textBssTitleEmailHintComposite = '@outlook.com | @gmail.com';
  static String textBssTitlePhoneNumberComposite = 'Phone Number';
  static String textBssTitlePhoneNumberHintComposite = 'eg. +237 000 000 000';
  static String textBssTitleAddressComposite = 'Address';
  static String textBssTitleAddressHintComposite = 'You location address';
  static String textBssTitlePicLogoComposite = 'Pick you logo';
  // Text On Customers Composite Invoice Screen
  static String textTitleCustomerComposite = 'Customers Infos';
  static String textCustomerTitleNameComposite = 'Full Name';
  static String textCustomerTitleNameHintComposite = 'Add Client Fullname';
  static String textCustomerTitleEmailComposite = 'Email';
  static String textCustomerTitleEmailHintComposite = 'customer@outlook.com';
  static String textCustomerTitlePhoneNumberComposite = 'Phone';
  static String textCustomerTitlePhoneNumberHintComposite = 'Client Phone Number';
  static String textCustomerTitleAddressComposite = 'Address';
  static String textCustomerTitleAddressHintComposite = 'Customer Location';
  // Text On Items Composite Invoice Screen
  static String textTitleItemsComposite = 'Manage Product Items';
  static String textTitleCellnameItemsComposite = 'Name';
  static String textTitleCellPriceItemsComposite = 'Item Price';
  static String textTitleCellQuantityItemsComposite = 'Quantity';
  static String textTitleCellActionsItemsComposite = 'Actions';
  static String textTitleNoInvoiceBuildItemsComposite = 'You did not add any item yet!';
  static String textTitleNoInvoiceBuildConIItemsComposite = 'Please press ';
  static String textTitleNoInvoiceBuildConIIItemsComposite = 'button for add new item.';
  static String totalText = 'Total: ';
  static String newItemText = 'Total: ';
  static String editInformationText = 'Edit Informations';
  static String editName = 'Edit Item Name', editPrice = 'Edit Price', editQty = 'Edit Quantity';
  static String renameText = 'Rename';
  static String newName = 'New Name:', newPrice = 'New Price:', newQty = 'New Qty value:';
  // Text On Payement Composite Invoice Screen
  static String textTitleDialogPaymentComposite = 'Write your instructions';
  // Text On Signature Composite Invoice Screen
  static String textTitleSignatureComposite = 'Sign your invoice';
  // Tooltips message
  static String tooltipReadBtnInvoiceScreen = 'Read minimal instructions.';
  static String tooltipTemplateBtnInvoiceScreen = 'Use template for cute result';
  static String tooltipItemsCompositeCellname = 'Item Name';
  static String textTitleCellEditDeleteItemsComposite = 'Edit/Delete';
  // Option Menu on home Page
  static String homePageOption = 'Home Page';
  static String templateHomePageOption = 'Templates';
  static String notificationHomePageOption = 'Notifications';
  static String rateUSHomePageOption = 'Rate US';
  static String helpCenterHomePageOption = 'Help Center';
  static String signOutHomePageOption = 'Sign Out';
  static String hiMsgHomePageOption = 'Hi, ';
  static String welcomeTextHomePageOption = 'Welcome';
  // Navigation on Home Page
  static String homeTextNavigation = 'Home';
  static String templatesTextNavigation = 'Templates';
  static String historyTextNavigation = 'History';
  static String profileTextNavigation = 'Profile';
  // Text In Home Fragment Page
  static String belowTextWl = 'Let\'s build new invoice';
  static String tipsTextHomeFragment = 'Generate Invoice By Following Just Few Steps !';
  static String genInvoiceHomeFragment = 'Generate News';
  static String popularTempHomeFragment = 'Popular Templates';
  static String lastTempUsedHomeFragment = 'Last used Templates';
  static String viewAllHomeFragment = 'View All';
  static String nothinTempUsedTitleHomeFragment = 'No Template Yet';
  static String nothinTempUsedDescriptionHomeFragment =
      'Please create invoice using one template, there showing here';
  // Text In History Fragment Page
  static String nothinInvoiceBuildTitleHistoryFragment = 'No Invoice Build Yet';
  static String nothinTempInvoiceBuildDescriptionHistoryFragment =
      'However, all your created invoice history will be displayed this way.';
  // Text In Templates Fragment Page
  static String searchInvoiceTextTemplateFragment = 'Search Templates';
  static String searchInvoiceTextDescTemplateFragment =
      'You can use a free template for you invoice.';
  // Assets Image
  static String googleImage = 'assets/google.png';
  static String appleImage = 'assets/apple.png';
  static String defaultProfileImage =
      'https://cdn-icons-png.flaticon.com/512/4228/4228707.png'; // depuis flaticon, une image par defaut au profile invoice builder
  static String doneArgumentIcons = 'assets/icons/success_circle.svg';
  static String prepareBuildInvoiceLogo = 'assets/images/Invoice-rafiki.svg';
  static String onBordingInvoiceI = 'assets/images/Invoice-pana.svg';
  static String onBordingInvoiceII = 'assets/images/Invoice-cuate.svg';
  static String onBordingInvoiceIII = 'assets/images/Invoice-bro.svg';
  static String prepareBuildInvoiceLogoSemantic = 'Invoice Start Logo';
}
