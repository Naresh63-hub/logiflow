# LogiFlow — Production Cross-Platform 3PL Logistics & Proof-of-Delivery System

[![Flutter CI](https://github.com/logiflow/logiflow-app/actions/workflows/ci.yml/badge.svg)](https://github.com/logiflow/logiflow-app/actions/workflows/ci.yml)
[![Flutter 3.47](https://img.shields.io/badge/Flutter-3.47.8-02569B?logo=flutter)](https://flutter.dev)
[![Dart 3.13](https://img.shields.io/badge/Dart-3.13.7-0175C2?logo=dart)](https://dart.dev)
[![Supabase](https://img.shields.io/badge/Backend-Supabase%20PostgreSQL-3ECF8E?logo=supabase)](https://supabase.com)
[![Drift SQLite](https://img.shields.io/badge/Offline%20DB-Drift%20SQLite-003B57?logo=sqlite)](https://drift.simonbinder.eu)

A production-grade, **offline-first** cross-platform Third-Party Logistics (3PL) shipment tracking and Proof-of-Delivery (POD) mobile application built in Flutter for regional operations centered around **Noida, Uttar Pradesh, India** (Sector 62 Hub, Greater Noida West Fulfillment Hub, and Okhla NCR Gateway).

---

## Key Capabilities & Role-Based Workflows

### Shipper Role
- **Shipper Dashboard**: Real-time summary cards (Total, In-Transit, Delivered, Pending, Delayed) with status distribution.
- **Create Consignments**: Full multi-section manifest form with weight, category, priority tiers (Standard, Express, Overnight), and automated `LGF-2026-XXXXX` tracking generation.
- **Shipment Tracking & Timeline**: Live event timeline displaying every scan, hub arrival, dispatch, and exception remark.
- **Proof of Delivery Viewer**: View receiver signature, delivery photo, GPS coordinates, and timestamp once delivered.

### Hub Manager & Delivery Personnel Role
- **Noida Hub Operations Dashboard**: Overview of hub volume, inbound sorting, out-for-delivery runs, and quick QR scanning.
- **QR / Barcode Scanner**: Live camera barcode scanner (`mobile_scanner`) with torch toggle and manual lookup fallback.
- **Status Lifecycle Transitions**: Update shipment milestones (`Picked Up` → `Arrived at Hub` → `In Transit` → `Out for Delivery` → `Delivered` / `Delivery Failed`) even with zero network connectivity.
- **Digital Proof of Delivery (POD)**: Capture camera/gallery photos, collect finger/stylus receiver signatures (`signature`), geotag exact GPS coordinates (`geolocator`), and store offline in SQLite.

### Bilingual & Adaptive Material Design 3 UI
- **English & Hindi (हिंदी)** instant localization switching without app restart.
- **Light & Dark Themes** featuring an industrial Deep Navy (`#0B192C`), Royal Blue (`#1E3E62`), and Safety Orange (`#FF6500`) color system.

---

## Technology Stack

| Layer | Technology |
| :--- | :--- |
| **Framework** | Flutter 3.47.8 / Dart 3.13.7 (Material Design 3) |
| **Architecture** | Feature-First Clean Architecture |
| **State Management** | Riverpod (`flutter_riverpod`) |
| **Navigation** | GoRouter (`go_router`) |
| **Remote Backend** | Supabase (PostgreSQL, Auth, Storage, Row Level Security) |
| **Offline Database** | Drift (`drift`, `drift_flutter`, `sqlite3_flutter_libs`) |
| **Networking & Sync** | Dio (`dio`) + Connectivity Monitoring (`connectivity_plus`) |
| **Hardware Features** | Mobile Scanner (`mobile_scanner`), Image Picker (`image_picker`), Signature (`signature`), Geolocator (`geolocator`) |
| **Localization** | `flutter_localizations`, `intl` (English & Hindi) |
| **Testing & CI** | `flutter_test`, `mocktail`, GitHub Actions |

---

## Project Directory Structure

```text
lib/
├── app/
│   ├── app.dart                 # MaterialApp.router, Theme & Locale configuration
│   └── router.dart                # Declarative GoRouter routes across all 11 screens
├── core/
│   ├── constants/               # Material 3 colors & Light/Dark themes
│   ├── database/                # Drift SQLite schema, generated DAOs & Riverpod provider
│   ├── localization/            # Bilingual English & Hindi translation maps
│   ├── network/                 # ConnectivityMonitor & Supabase initialization wrapper
│   └── sync/                    # SyncEngine, SyncQueue models & ConflictResolver
├── features/
│   ├── auth/                    # Login screen, AuthRepository & role state
│   ├── dashboard/               # Shipper & Hub Manager dashboards
│   ├── delivery/                # Proof of Delivery capture (Photo, Signature, GPS)
│   ├── onboarding/              # Animated Splash & 3-slide Onboarding
│   ├── profile/                 # User profile, role switcher & sign out
│   ├── scanner/                 # QR/Barcode scanning & lookup
│   ├── settings/                # Theme toggle, language switcher & manual sync console
│   └── shipments/               # Shipment List, Details Timeline & Create Consignment
└── shared/
    └── widgets/                 # OfflineBanner, StatusBadge, EmptyState, Skeletons
```

---

## Offline-First Architecture & Synchronization

Essential workflows never fail in basement sorting facilities or low-connectivity transit zones:

1. **Local SQLite Source of Truth**: UI streams (`shipmentsStreamProvider`) watch reactive Drift tables directly.
2. **Sync Operations Queue (`SyncQueue`)**: Offline creations, status transitions, and POD submissions write immediately to SQLite with `isDirty = true` and append an operation (`CREATE_SHIPMENT`, `UPDATE_STATUS`, `SUBMIT_POD`) to `SyncQueue` with a UUID `operationId`.
3. **Connectivity Listener**: `SyncEngine` subscribes to `connectivity_plus` and automatically flushes queued operations FIFO upon reconnection.

### Conflict Resolution Architecture

When two users modify the same shipment concurrently while offline, [`ConflictResolver`](lib/core/sync/conflict_resolver.dart) resolves discrepancies using **optimistic concurrency (`version` + `updated_at`)**:

- **Evidence Preservation Guarantee (POD Rule)**: Proof of Delivery submissions (`SUBMIT_POD`) containing receiver signatures, photos, and GPS tags are **never overwritten or discarded** regardless of version divergence. Delivery evidence is preserved and logged in the audit history.
- **Delivered Regression Guard**: If a shipment is already marked `delivered` on the server, stale offline transit events cannot regress its state.
- **Latest Timestamp Wins**: Intermediate transit status collisions resolve in favor of the latest `localTimestamp` with an automated audit event entry.

For architecture diagrams and sequence flows, see [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

---

## Database Setup (Supabase PostgreSQL)

Normalized schema migrations and Noida seed data are located in `supabase/`:
- [`supabase/migrations/20261111000001_initial_schema.sql`](supabase/migrations/20261111000001_initial_schema.sql): 8 relational tables (`profiles`, `hubs`, `shipments`, `shipment_events`, `delivery_assignments`, `proof_of_deliveries`, `notifications`, `sync_operations`), automatic version triggers, production indexes, and **Row Level Security (RLS)** policies.
- [`supabase/seed.sql`](supabase/seed.sql): 3 Noida NCR hubs, demo shipper/manager/driver profiles, and 8 edge-case shipments.

---

## Environment Configuration & Installation

1. **Clone & Install Dependencies**:
   ```bash
   git clone https://github.com/logiflow/logiflow-app.git
   cd logiflow-app
   flutter pub get
   ```

2. **Configure Environment**:
   Copy `.env.example` to `.env` and populate your Supabase credentials (note: if left unconfigured, the app runs seamlessly in offline-first Drift SQLite evaluation mode):
   ```bash
   cp .env.example .env
   ```

3. **Generate Drift Code (if modifying tables)**:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run Static Analysis & Tests**:
   ```bash
   flutter analyze
   flutter test
   ```

5. **Demo Evaluation Accounts** (available on the Login screen via one-tap quick-fill):
   - **Shipper**: `shipper@logiflow.in`
   - **Hub Manager**: `manager@logiflow.in`

---

## Building & Installing the Android APK

To build a signed release APK:
```bash
flutter build apk --release
```
Install on a connected Android device:
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```
