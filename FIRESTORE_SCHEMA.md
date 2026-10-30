# Firestore schema (shared contract)

`shoply_app` (customers) and `shoply_admin` (Shoply Seller) use the same Firebase project, **shoply-e25f0**, and the same Firestore database.
Each repo has its own copy of the models, so **this file is the contract between them**.
If you rename or add a field in one app, update this file and the other app in the same change.

## Collections

### `User/{uid}`
Written by `shoply_app` on sign up. The admin app reads it for the Customers screens.

| Field | Type |
|---|---|
| `uid` | string |
| `email` | string |
| `fullName` | string |
| `userName` | string |
| `address` | string |
| `profileImage` | string (Supabase URL) |

### `User/{uid}/orders/{orderId}`
Written by `shoply_app` at checkout. The admin app reads all of them with `collectionGroup('orders')` and changes `status`.

| Field | Type | Notes |
|---|---|---|
| `items` | array of maps | `productId`, `name`, `price`, `quantity`, `image` |
| `total` | number | items + shipping |
| `status` | string | `placed` (new, shown as Pending), `pending`, `shipped`, `delivered`, `cancelled` |
| `createdAt` | timestamp | server time |

### `User/{uid}/cart/{productId}` and `User/{uid}/favorites/{productId}`
Customer app only.

### `products/{productId}`

| Field | Type | Notes |
|---|---|---|
| `name` | string | |
| `description` | string | |
| `price` | number | |
| `categoryId` | string | |
| `images` | array of string | Supabase URLs |
| `isTrending` | bool | |
| `stock` | number | **new**, set by the admin app. Missing = not tracked yet |
| `isActive` | bool | **new**, set by the admin app. Missing = active |
| `createdAt` | timestamp | **new**, set when the admin app adds a product |

### `categories/{categoryId}`
`name`, `image`.

### `admins/{uid}` (new)
An account can use the admin app only if this document exists. Fields: `name`, `email`.
Add documents by hand in the Firebase console. No app can write here.

### `adminRequests/{uid}` (new)
Created when someone signs up in the admin app. Fields: `fullName`, `email`, `createdAt`.
To approve someone, copy their uid into a new `admins/{uid}` document.

### `settings/store` (new)
`storeName`, `contactEmail`, `contactPhone`, `address`, `shippingFee`, `freeShippingOver`, `paymentMethods` (array of string).

### `supportMessages/{id}` (new)
Sent from Contact Us in the admin app: `uid`, `name`, `email`, `subject`, `message`, `createdAt`.

## Not used by the customer app yet

These are saved by the admin app but `shoply_app` doesn't read them yet:

- `isActive`: inactive products still show to customers.
- `stock`: checkout doesn't check or reduce stock.
- `settings/store`: shipping fee and payment methods aren't used at checkout.

## Security rules

See [`firestore.rules`](firestore.rules). They are the project's original rules plus additions for the admin app
(each marked `Admin app:`) and one for customer checkout (lowering `stock`).
Customers can only read and write their own data, only admins can read everyone's orders,
change order status, or edit products and settings, and nobody can make themselves an admin.
Publishing them replaces the project's current rules.

## Files copied from `shoply_app`

Keep these in sync by hand:
`core/model/category`, `core/model/login`, `core/model/product` (plus the new fields),
`core/repositories/category_repository.dart`, `core/helper/*`, `core/local/*`, `core/regex/*`,
`core/service/upload_image_service.dart`, `core/dependencies/*`, `core/utils/*`, `features/forgot_password/*`.
