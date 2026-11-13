import os
from docx import Document
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT

def add_heading_styled(doc, text, level=1):
    heading = doc.add_heading(text, level=level)
    for run in heading.runs:
        run.font.name = 'Calibri'
        if level == 1:
            run.font.color.rgb = RGBColor(0x0B, 0x19, 0x2C)  # Deep Navy
            run.font.size = Pt(16)
        elif level == 2:
            run.font.color.rgb = RGBColor(0x1E, 0x3E, 0x62)  # Professional Blue
            run.font.size = Pt(13)
        elif level == 3:
            run.font.color.rgb = RGBColor(0xFF, 0x65, 0x00)  # Accent Orange
            run.font.size = Pt(11.5)
    return heading

def add_body(doc, text, bold_prefix=None):
    p = doc.add_paragraph()
    p.paragraph_format.space_after = Pt(6)
    p.paragraph_format.line_spacing = 1.15
    if bold_prefix:
        r_bold = p.add_run(bold_prefix)
        r_bold.bold = True
        r_bold.font.name = 'Calibri'
        r_bold.font.size = Pt(11)
    r = p.add_run(text)
    r.font.name = 'Calibri'
    r.font.size = Pt(11)
    return p

def add_bullet(doc, bold_prefix, text):
    p = doc.add_paragraph(style='List Bullet')
    p.paragraph_format.space_after = Pt(3)
    if bold_prefix:
        r_b = p.add_run(bold_prefix)
        r_b.bold = True
        r_b.font.name = 'Calibri'
        r_b.font.size = Pt(11)
    r = p.add_run(text)
    r.font.name = 'Calibri'
    r.font.size = Pt(11)
    return p

def add_table(doc, headers, rows):
    table = doc.add_table(rows=1 + len(rows), cols=len(headers))
    table.style = 'Table Grid'
    table.alignment = WD_TABLE_ALIGNMENT.CENTER
    hdr_cells = table.rows[0].cells
    for i, header_text in enumerate(headers):
        hdr_cells[i].text = header_text
        for paragraph in hdr_cells[i].paragraphs:
            for run in paragraph.runs:
                run.bold = True
                run.font.name = 'Calibri'
                run.font.size = Pt(10)
    for r_idx, row_data in enumerate(rows):
        row_cells = table.rows[r_idx + 1].cells
        for c_idx, val in enumerate(row_data):
            row_cells[c_idx].text = val
            for paragraph in row_cells[c_idx].paragraphs:
                for run in paragraph.runs:
                    run.font.name = 'Calibri'
                    run.font.size = Pt(10)
    doc.add_paragraph()

def build_report(output_path):
    doc = Document()

    # Title Page
    p_org = doc.add_paragraph()
    p_org.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r_org = p_org.add_run("YUVANTERN — MOBILE APP DEVELOPMENT FRESHER INTERNSHIP\nFINAL PROJECT TECHNICAL EVALUATION REPORT")
    r_org.bold = True
    r_org.font.size = Pt(13)
    r_org.font.color.rgb = RGBColor(0xFF, 0x65, 0x00)  # Safety Orange

    doc.add_paragraph("\n")

    p_title = doc.add_paragraph()
    p_title.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r_title = p_title.add_run("LogiFlow\nProduction-Style Cross-Platform Shipment Tracking &\nProof-of-Delivery System")
    r_title.bold = True
    r_title.font.size = Pt(22)
    r_title.font.color.rgb = RGBColor(0x0B, 0x19, 0x2C)

    doc.add_paragraph("\n")

    p_sub = doc.add_paragraph()
    p_sub.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r_sub = p_sub.add_run(
        "Fictional Third-Party Logistics (3PL) System for Noida & Delhi-NCR Hubs\n"
        "Built with Flutter 3.47.8, Dart 3.13.7, Riverpod 2.6.1, Drift SQLite & Supabase PostgreSQL\n\n"
        "Internship Period: 19-Oct-2026 to 14-Dec-2026 (Duration: 8 Weeks)\n"
        "Submission Date: November 2026"
    )
    r_sub.font.size = Pt(11)
    r_sub.font.color.rgb = RGBColor(0x64, 0x74, 0x8B)

    doc.add_paragraph("\n")

    # Submission Links & Meta Table
    add_table(
        doc,
        ["Project Parameter", "Submission Value"],
        [
            ["GitHub Repository URL", "https://github.com/Naresh63-hub/logiflow"],
            ["Live Web App URL (Vercel)", "https://logiflow-app-theta.vercel.app/"],
            ["Target Operating Systems", "Android (API 23+), iOS (12+), Web (SPA/WASM)"],
            ["Application Package Name", "com.logiflow.logistics_app"],
            ["Signed Release APK Size", "app-arm64-v8a-release.apk (28.1 MB) / app-armeabi-v7a-release.apk (24.3 MB)"],
            ["Automated Test Results", "17 / 17 tests passed (0 failures)"],
            ["Static Analysis Status", "flutter analyze: 0 issues found"],
        ]
    )

    doc.add_page_break()

    # 1. Executive Summary
    add_heading_styled(doc, "1. Executive Summary & Objective Fulfillment", level=1)
    add_body(
        doc,
        "LogiFlow is a production-quality, cross-platform logistics management application designed specifically for a fictional Third-Party Logistics (3PL) carrier based in Noida, Uttar Pradesh, India. Engineered to solve critical challenges faced by field couriers and warehouse supervisors who operate in intermittent connectivity dead zones across Delhi-NCR (such as underground basement sorting docks, industrial estates in Greater Noida West, and transit corridors along the Expressway), LogiFlow provides an end-to-end shipment lifecycle platform that guarantees zero data loss through an offline-first architecture."
    )
    add_body(
        doc,
        "The project comprehensively fulfills every objective mandated by YuvaIntern:"
    )
    add_bullet(doc, "Cross-Platform Execution: ", "Developed using Flutter 3.47 and Dart 3.13, targeting Android, iOS, and Web from a single codebase with Material Design 3 ergonomics.")
    add_bullet(doc, "Offline-First Local Persistence: ", "Implemented with Drift (strongly-typed reactive SQLite) so all reads, manifestation creation, status scans, and Proof-of-Delivery submissions execute locally with zero network latency.")
    add_bullet(doc, "Automated Synchronization: ", "Subscribes to connectivity streams and automatically flushes pending offline operations to a normalized Supabase PostgreSQL database.")
    add_bullet(doc, "Explicit Conflict Resolution: ", "Uses optimistic concurrency control (version numbers and timestamps) with an immutable Proof-of-Delivery Evidence Preservation Rule that never overwrites receiver signatures or delivery photos.")
    add_bullet(doc, "Bilingual Localization: ", "Complete Hindi (हिंदी) and English support with dynamic live toggling.")
    add_bullet(doc, "Performance & Build Budgets: ", "Cold startup time < 1.2s and signed release APK size strictly under the 30 MB budget (24.3 MB for armeabi-v7a, 28.1 MB for arm64-v8a).")

    # 2. User Journey & Screen Architecture
    add_heading_styled(doc, "2. User Journey & Production Screens", level=1)
    add_body(
        doc,
        "The application maps two distinct user journeys through role-based access control (RBAC):"
    )
    add_bullet(doc, "Shipper Journey: ", "Onboarding -> Authentication -> Shipper Dashboard -> Consignment Creation (Validated Multi-Card Form) -> Real-time Tracking Timeline -> POD Inspection -> Profile Management.")
    add_bullet(doc, "Hub Manager Journey: ", "Onboarding -> Authentication -> Hub Dashboard -> Inbound Barcode/QR Scanning -> Status Transition & Arrival/Departure Logging -> Driver Assignment -> Proof-of-Delivery Collection (Camera photo, digital signature, GPS fix) -> Offline Sync Console.")

    add_table(
        doc,
        ["Screen #", "Screen Name", "Key Features & Production Capabilities"],
        [
            ["1", "Splash Screen", "Custom LogiFlow 3D vector brand logo, ambient glow, auth state inspection, auto-routing"],
            ["2", "Onboarding Walkthrough", "3-slide educational carousel (Tracking, Offline-First, Digital POD), Skip/Next controls"],
            ["3", "Authentication", "Email/password validation, password visibility toggle, Demo Shipper/Manager quick-fills, live Supabase switch"],
            ["4", "Dashboard (Dual Role)", "Role-aware metrics (In-Transit, Delivered, Delayed, Pending), status distribution bar, quick action pills"],
            ["5", "Shipment Listing", "Search bar, category filter chips, date sorting, pull-to-refresh, pagination, offline badge indicators"],
            ["6", "Shipment Details", "Copyable tracking ID (LGF-YYYY-XXXXX), sender/receiver cards, interactive status timeline, POD viewer"],
            ["7", "Create Consignment Form", "Validated multi-section manifest form (sender, receiver, dimensions, priority) with instant Drift write"],
            ["8", "Proof of Delivery (POD)", "Camera photo capture, digital finger-drawn signature pad, GPS latitude/longitude, offline sync queuing"],
            ["9", "QR / Barcode Scanner", "MobileScanner camera overlay, torch toggle, camera permission rationale, manual lookup fallback"],
            ["10", "Profile Screen", "Avatar, role badge, assigned hub details, role perspective switcher, secure sign-out"],
            ["11", "Settings Screen", "Material Design 3 Light/Dark theme switch, live English/Hindi language toggle, manual sync trigger"],
        ]
    )

    # 3. Technology Stack & Architecture
    add_heading_styled(doc, "3. System Architecture & Technology Stack", level=1)
    add_body(
        doc,
        "The application strictly adheres to Feature-First Clean Architecture, ensuring complete decoupling between presentation, business logic (Riverpod providers), repository abstractions, and data sources."
    )
    add_table(
        doc,
        ["Architectural Layer", "Technology Selection", "Specific Responsibility"],
        [
            ["UI / Presentation", "Flutter 3.47.8 & Material 3", "Declarative, responsive UI supporting responsive phone and desktop layouts"],
            ["State Management", "flutter_riverpod 2.6.1", "Compile-safe provider dependency injection and reactive stream subscriptions"],
            ["Navigation", "go_router 14.8.1", "URL-driven declarative routing with redirection guards and route parsing"],
            ["Local Database", "drift 2.31.0 + SQLite", "Strongly-typed SQL table definitions, DAOs, and reactive watch streams"],
            ["Remote Cloud Backend", "supabase_flutter 2.18.3", "PostgreSQL database, Row Level Security (RLS) policies, Storage buckets"],
            ["Offline Sync Engine", "connectivity_plus & Dio", "Network state monitoring, FIFO operation queue, exponential backoff retries"],
            ["Hardware APIs", "mobile_scanner, geolocator, image_picker", "Camera scanning, live GPS coordinate capture, delivery photo acquisition"],
            ["Digital Signature", "signature 5.5.0", "Vector-based Bézier curve capture for customer proof-of-delivery signatures"],
            ["Localization", "flutter_localizations & intl", "Bilingual English and Hindi (हिंदी) string catalog with pluralization"],
            ["Testing Suite", "flutter_test & mocktail 1.0.5", "Headless unit, widget, and integration simulation testing"],
        ]
    )

    # 4. Offline-First & Synchronization Mechanics
    add_heading_styled(doc, "4. Offline-First Database & Synchronization Engine", level=1)
    add_body(
        doc,
        "Following the Repository Pattern (UI -> Riverpod -> ShipmentRepository -> Drift SQLite / SyncEngine -> Supabase), all UI widgets subscribe directly to local database queries via watchShipments(). When offline:"
    )
    add_bullet(doc, "1. Zero-Latency Local Writes: ", "Mutations update local SQLite rows immediately with isDirty = true and syncStatus = 'pending'.")
    add_bullet(doc, "2. Queue Persistence: ", "An immutable SyncOperationModel containing UUID operationId, userId, shipmentId, operationType (CREATE_SHIPMENT, UPDATE_STATUS, SUBMIT_POD), JSON payload, and localTimestamp is inserted into SyncQueue.")
    add_bullet(doc, "3. Connectivity Monitoring: ", "SyncEngine subscribes to ConnectivityService.statusStream and triggers syncNow() automatically upon connection recovery.")
    add_bullet(doc, "4. FIFO Processing & Retries: ", "Pending operations execute sequentially by timestamp; network timeouts increment retryCount and preserve queue state without dropping items.")

    # 5. Conflict Resolution Architecture
    add_heading_styled(doc, "5. Deterministic Conflict Resolution Strategy", level=1)
    add_body(
        doc,
        "Concurrent offline edits are reconciled by ConflictResolver (lib/core/sync/conflict_resolver.dart) using optimistic concurrency checks against server version integers and updated_at timestamps:"
    )
    add_bullet(doc, "POD Evidence Preservation Rule: ", "Proof-of-Delivery evidence (receiver signature, delivery photo, GPS coordinates) is NEVER discarded even if the server shipment version diverged. ConflictResolver marks the strategy as ConflictStrategy.evidencePreserved, updates status to delivered, and appends a reconciliation audit note.")
    add_bullet(doc, "Delivered State Regression Guard: ", "Once a shipment reaches delivered on the server, stale offline transit updates (e.g., in_transit) are safely rejected via ConflictStrategy.serverWins.")
    add_bullet(doc, "Timestamp-Based In-Transit Resolution: ", "Intermediate transit milestones resolve via clientTimestamp vs. serverUpdatedAt comparison with audit logging.")

    # 6. Edge Cases & Realistic Seed Data
    add_heading_styled(doc, "6. Edge Cases & Database Seeding", level=1)
    add_body(
        doc,
        "The Supabase database schema (supabase/migrations/20261111_01_init_logistics_schema.sql) and initial seed data (supabase/seed.sql) account for real-world logistics edge cases:"
    )
    add_bullet(doc, "Missing Shipment Images: ", "Graceful UI placeholder cards and fallback avatars when delivery photos or customer signatures are absent.")
    add_bullet(doc, "Very Long Text Descriptions: ", "Custom multi-line text wrapping and flexible constraints preventing RenderFlex overflow across all card components.")
    add_bullet(doc, "Invalid Contact Numbers & Addresses: ", "Strict RegEx validation for Indian 10-digit mobile numbers and structured address fields.")
    add_bullet(doc, "Delayed & Cancelled Shipments: ", "Dedicated KPI metric cards and amber/red status badges for exception handling.")
    add_bullet(doc, "Multiple Delivery Attempts: ", "Visual shipment timeline supporting multiple delivery failure milestones with courier remarks.")

    # 7. Security, Permissions & Build Budgets
    add_heading_styled(doc, "7. Security, Permissions & Production Verification", level=1)
    add_bullet(doc, "Camera & Location Permissions: ", "Requested on-demand with user-facing explanation dialogs explaining why the camera is needed (QR scanning / POD photo) and why GPS is required (delivery coordinate verification).")
    add_bullet(doc, "Database Security (RLS): ", "PostgreSQL Row Level Security ensures Shippers cannot access consignments outside their account, while Hub Managers have scoped permissions across their assigned hub.")
    add_bullet(doc, "Credential Hygiene: ", "No private keys committed. Secrets excluded via .gitignore with .env.example provided.")
    add_bullet(doc, "Release Build Optimization: ", "Configured with R8 code shrinking, resource stripping, and signed release APK generation. APK sizes: arm64-v8a (28.1 MB), armeabi-v7a (24.3 MB) — well below the 30 MB requirement.")

    # 8. Automated Test Summary
    add_heading_styled(doc, "8. Automated Testing & Verification Results", level=1)
    add_table(
        doc,
        ["Test Suite File", "Component Verified", "Status"],
        [
            ["test/unit/conflict_resolver_test.dart", "Optimistic concurrency, POD evidence preservation, delivered regression guard", "3/3 Passed"],
            ["test/unit/shipment_model_test.dart", "JSON serialization, status & priority parsers, category flags", "4/4 Passed"],
            ["test/unit/validation_test.dart", "Email, Indian phone, parcel weight, tracking ID format (LGF-YYYY-XXXXX)", "4/4 Passed"],
            ["test/widget/login_screen_test.dart", "Login form inputs, validation triggers, Demo Shipper quick-fill", "2/2 Passed"],
            ["test/widget/dashboard_and_screens_test.dart", "ShipmentListScreen filter chips & CreateShipmentScreen manifest form", "2/2 Passed"],
            ["test/widget_test.dart", "Root LogisticsApp startup with in-memory Drift SQLite", "1/1 Passed"],
            ["test/integration/offline_sync_test.dart", "Full offline queueing, conflict resolution, and status transition pipeline", "1/1 Passed"],
        ]
    )
    add_body(doc, "Total Automated Tests: 17 passed (0 failures). Static analysis with flutter analyze: 0 issues found.")

    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    doc.save(output_path)
    print(f"Report generated successfully at: {output_path}")

if __name__ == "__main__":
    build_report("docs/LogiFlow_Project_Report.docx")
