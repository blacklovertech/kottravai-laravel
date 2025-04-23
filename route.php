// routes/web.php
use Illuminate\Support\Facades\Route;

// Public routes
Route::get('/', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
Route::get('/categories', [App\Http\Controllers\CategoryController::class, 'index'])->name('categories.index');
Route::get('/products/{product}', [App\Http\Controllers\ProductController::class, 'show'])->name('products.show');
Route::get('/search', [App\Http\Controllers\ProductController::class, 'search'])->name('products.search');
Route::get('/contact', [App\Http\Controllers\PageController::class, 'contact'])->name('contact');
Route::get('/about', [App\Http\Controllers\PageController::class, 'about'])->name('about');

// Authentication Routes (Phone login with session + device tracking)
Route::prefix('auth')->group(function(){
    Route::get('login', [App\Http\Controllers\Auth\LoginController::class,'showLoginForm'])->name('login');
    Route::post('login', [App\Http\Controllers\Auth\LoginController::class,'phoneLogin']);
    Route::post('logout', [App\Http\Controllers\Auth\LoginController::class,'logout'])->name('logout');
});

// Authenticated User Routes
Route::middleware(['auth', 'checkRole:user'])->prefix('user')->group(function(){
    Route::get('dashboard', [App\Http\Controllers\User\DashboardController::class, 'index'])->name('user.dashboard');

    Route::resource('addresses', App\Http\Controllers\User\AddressController::class);
    Route::resource('orders', App\Http\Controllers\User\OrderController::class)->only(['index', 'show']);
    Route::resource('wishlist', App\Http\Controllers\User\WishlistController::class)->only(['index', 'store', 'destroy']);
    Route::get('notifications', [App\Http\Controllers\User\NotificationController::class, 'index'])->name('user.notifications');

    Route::get('profile', [App\Http\Controllers\User\ProfileController::class, 'edit'])->name('user.profile.edit');
    Route::put('profile', [App\Http\Controllers\User\ProfileController::class, 'update'])->name('user.profile.update');

    Route::get('cart', [App\Http\Controllers\CartController::class, 'index'])->name('cart.index');
    Route::post('cart/apply-coupon', [App\Http\Controllers\CartController::class, 'applyCoupon'])->name('cart.applyCoupon');
    Route::post('checkout', [App\Http\Controllers\OrderController::class, 'checkout'])->name('order.checkout');
});

// Seller Routes
Route::middleware(['auth', 'checkRole:seller'])->prefix('seller')->group(function(){
    Route::get('dashboard', [App\Http\Controllers\Seller\DashboardController::class, 'index'])->name('seller.dashboard');
    Route::resource('products', App\Http\Controllers\Seller\ProductController::class);
    Route::resource('orders', App\Http\Controllers\Seller\OrderController::class)->only(['index', 'show']);
    Route::post('orders/{order}/ship', [App\Http\Controllers\Seller\OrderController::class, 'markShipped'])->name('seller.orders.ship');

    Route::get('feedback', [App\Http\Controllers\Seller\FeedbackController::class, 'index'])->name('seller.feedback');
});

// Admin Routes
Route::middleware(['auth', 'checkRole:admin'])->prefix('admin')->group(function(){
    Route::get('dashboard', [App\Http\Controllers\Admin\DashboardController::class, 'index'])->name('admin.dashboard');
    Route::resource('users', App\Http\Controllers\Admin\UserController::class);
    Route::resource('product-approvals', App\Http\Controllers\Admin\ProductApprovalController::class)->only(['index', 'update']);
    Route::resource('orders', App\Http\Controllers\Admin\OrderController::class);
    Route::resource('refunds', App\Http\Controllers\Admin\RefundController::class);
    Route::resource('coupons', App\Http\Controllers\Admin\CouponController::class);

    Route::get('payments', [App\Http\Controllers\Admin\PaymentController::class, 'index'])->name('admin.payments.index');
    Route::get('shipments', [App\Http\Controllers\Admin\ShipmentController::class, 'index'])->name('admin.shipments.index');

    Route::get('login-audit', [App\Http\Controllers\Admin\LoginAuditController::class, 'index'])->name('admin.loginAudit');
});