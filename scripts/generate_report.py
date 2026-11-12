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
    r_org = p_org.add_run("LOGIFLOW ENTERPRISE 3PL\nTECHNICAL ARCHITECTURE & PROJECT REPORT")
    r_org.bold = True
    r_org.font.size = Pt(14)
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
        "Enterprise 3PL Logistics Mobile Application (Noida & NCR Operations)\n"
        "Built with Flutter 3.47.8, Dart 3.13.7, Riverpod, GoRouter, Drift SQLite & Supabase\n\n"
        "Submission Date: November 2026"
    )
    r_sub.font.size = Pt(12)
    r_sub.font.color.rgb = RGBColor(0x64, 0x74, 0x8B)

    doc.add_page_break()

    # 1. Introduction
    add_heading_styled(doc, "1. Introduction", level=1)
    add_body(
        doc,
        "LogiFlow is a cross-platform mobile logistics management application engineered for a Third-Party Logistics (3PL) enterprise operating out of Noida, Uttar Pradesh, India. Serving key regional distribution corridors including the Noida Sector 62 Central Hub, Greater Noida West Fulfillment Hub, and Okhla NCR Gateway Distribution Center, the system digitizes end-to-end consignment manifestation, hub sorting, barcode identification, live tracking timelines, and tamper-resistant Proof-of-Delivery (POD) verification."
    )
    add_body(
        doc,
        "Unlike static prototypes, LogiFlow implements a production-style offline-first architecture powered by Drift (SQLite) paired with a normalized Supabase PostgreSQL backend, Row Level Security (RLS), role-based access control, bilingual English/Hindi localization, and an automated optimistic-concurrency synchronization engine."
    )

    # 2. Problem Statement
    add_heading_styled(doc, "2. Problem Statement", level=1)
    add_body(
        doc,
        "Regional 3PL carriers operating across industrial parks, high-rise residential sectors, and multi-tier sorting facilities face critical operational bottlenecks:"
    )
    add_bullet(doc, "Intermittent Connectivity Dead Zones: ", "Underground loading bays, warehouses, and transit corridors frequently experience mobile data loss, causing cloud-only apps to freeze or drop status scans.")
    add_bullet(doc, "Data Loss & Delivery Evidence Overwrites: ", "When delivery personnel capture customer signatures and photos offline while hub supervisors update consignment metadata simultaneously, naive sync implementations silently discard physical proof of delivery.")
    add_bullet(doc, "Lack of Role Isolation & Auditability: ", "Shippers require transparent visibility into their outbound shipments without risking unauthorized modification of transit milestones or delivery records.")
    add_bullet(doc, "Language Accessibility: ", "Ground hub operators and courier personnel in Northern India benefit significantly from bilingual Hindi and English interfaces.")

    # 3. Objectives
    add_heading_styled(doc, "3. Objectives", level=1)
    add_bullet(doc, "Offline-First Reliability: ", "Ensure all core reads, shipment creation, status updates, barcode scans, and POD submissions execute instantaneously against a local SQLite database without requiring internet connectivity.")
    add_bullet(doc, "Deterministic Synchronization: ", "Queue offline mutations atomically in a FIFO sync queue and automatically reconcile changes upon network restoration with explicit conflict resolution.")
    add_bullet(doc, "Role-Based Workflows: ", "Deliver tailored UI experiences and database-enforced authorization for Shippers and Hub Managers.")
    add_bullet(doc, "Proof-of-Delivery Integrity: ", "Capture camera photos, finger-drawn digital signatures, and GPS coordinates with guaranteed preservation rules.")
    add_bullet(doc, "Bilingual Material Design 3 UI: ", "Provide clean Light/Dark themes and live English/Hindi language toggling without application restarts.")

    # 4. Technology Stack
    add_heading_styled(doc, "4. Technology Stack", level=1)
    add_table(
        doc,
        ["Layer", "Technology / Package", "Role in System"],
        [
            ["Mobile Framework", "Flutter 3.47.8 & Dart 3.13.7", "Cross-platform native compilation with Material Design 3"],
            ["State Management", "flutter_riverpod 2.6.1", "Compile-safe provider graph & reactive state notifications"],
            ["Navigation", "go_router 14.8.1", "Declarative routing across 11 authenticated & onboarding views"],
            ["Local Offline DB", "drift 2.31.0 + sqlite3_flutter_libs", "Strongly-typed reactive SQLite persistence & local sync queue"],
            ["Remote Backend", "supabase_flutter 2.18.3", "PostgreSQL storage, Auth, and Row Level Security (RLS)"],
            ["Networking & Sync", "dio 5.11.1 + connectivity_plus 6.1.5", "Connectivity stream monitoring & resilient sync pipelines"],
            ["Hardware APIs", "mobile_scanner, image_picker, signature, geolocator", "QR/Barcode scanning, delivery photo, signature pad & GPS"],
            ["Localization", "flutter_localizations + intl 0.20.3", "Dynamic English & Hindi (हिंदी) localization support"],
            ["Testing", "flutter_test + mocktail 1.0.5 + drift native memory", "Automated unit, widget, and offline sync simulation tests"],
        ]
    )

    # 5. System Architecture
    add_heading_styled(doc, "5. System Architecture", level=1)
    add_body(
        doc,
        "The codebase uses a Feature-First Clean Architecture structured inside lib/:"
    )
    add_bullet(doc, "lib/app/: ", "Contains AppTheme binding, dynamic Locale injection in LogisticsApp, and GoRouter definitions in router.dart.")
    add_bullet(doc, "lib/core/: ", "Houses design tokens (app_colors.dart, app_theme.dart), Drift schema and generated DAOs (app_database.dart, app_database.g.dart), bilingual dictionary (app_localizations.dart), connectivity monitoring (connectivity_service.dart), Supabase initialization wrapper (supabase_config.dart), and the synchronization/conflict engine (sync_engine.dart, conflict_resolver.dart).")
    add_bullet(doc, "lib/features/: ", "Modularized vertical slices for onboarding, auth, dashboard, shipments, delivery (POD), scanner, profile, and settings.")
    add_bullet(doc, "lib/shared/: ", "Reusable Material 3 widgets including OfflineBanner, StatusBadge, EmptyStateWidget, and LoadingSkeletonList.")

    # 6. Database Design
    add_heading_styled(doc, "6. Database Design", level=1)
    add_heading_styled(doc, "6.1 Remote PostgreSQL Schema (Supabase)", level=2)
    add_body(
        doc,
        "Defined in supabase/migrations/20261111000001_initial_schema.sql, the relational database comprises 8 normalized tables with foreign keys, status enums, automatic version-increment triggers, and query indexes:"
    )
    add_table(
        doc,
        ["Table Name", "Primary Purpose"],
        [
            ["profiles", "Extends auth.users with role enum (shipper, hub_manager, driver, admin) and assigned hub"],
            ["hubs", "Noida NCR sorting facilities with geospatial coordinates and phone contacts"],
            ["shipments", "Core parcel records with tracking_number, weights, priority, version counter & status"],
            ["shipment_events", "Immutable audit trail of status transitions, locations, GPS tags & remarks"],
            ["delivery_assignments", "Links shipments to assigned last-mile delivery agents"],
            ["proof_of_deliveries", "Stores receiver name, signature URL, photo URL, GPS fix & verification flags"],
            ["notifications", "User-targeted consignment lifecycle alerts"],
            ["sync_operations", "Server-side reconciliation ledger logging client sync operations & conflict outcomes"],
        ]
    )

    add_heading_styled(doc, "6.2 Local Offline Database Schema (Drift SQLite)", level=2)
    add_body(
        doc,
        "Defined in lib/core/database/app_database.dart, five Drift tables mirror critical operational datasets locally: Shipments (with isDirty and syncStatus flags), ShipmentEvents, ProofOfDeliveries, SyncQueue, and Profiles. This guarantees zero-latency UI updates and full offline availability."
    )

    # 7. Application Modules
    add_heading_styled(doc, "7. Application Modules (11 Production Screens)", level=1)
    add_table(
        doc,
        ["#", "Screen", "Primary Capabilities"],
        [
            ["1", "Splash Screen", "Animated branding, session check, onboarding/dashboard routing"],
            ["2", "Onboarding Screen", "3 interactive feature slides covering tracking, offline ops & POD"],
            ["3", "Login Screen", "Supabase auth, validation, password reveal, quick-fill Shipper/Manager demos"],
            ["4", "Dashboard", "Dual role KPIs (Total, In Transit, Delivered, Pending), quick actions, recent list"],
            ["5", "Shipment List", "Live search, horizontal status filter chips, offline sync tags, FAB"],
            ["6", "Shipment Details", "Copyable tracking ID, party cards, interactive timeline, POD preview, status update sheet"],
            ["7", "Create Shipment", "Validated multi-card manifest form with instant Drift persistence"],
            ["8", "Proof of Delivery", "Camera/Gallery photo, interactive digital signature pad, GPS capture, offline queuing"],
            ["9", "QR/Barcode Scanner", "MobileScanner camera overlay, torch toggle, manual lookup fallback"],
            ["10", "Profile Screen", "Avatar, role badge, Noida Hub card, edit dialog, role perspective switcher, logout"],
            ["11", "Settings Screen", "System/Light/Dark theme toggle, EN/HI live language switcher, manual sync console"],
        ]
    )

    # 8. Offline-First & Synchronization
    add_heading_styled(doc, "8. Offline-First Implementation & Synchronization Mechanism", level=1)
    add_body(
        doc,
        "Following the repository pattern (UI -> Riverpod -> ShipmentRepository -> Drift SQLite / SyncEngine -> Supabase), all UI streams subscribe directly to local SQLite queries via watchShipments(). When offline:"
    )
    add_bullet(doc, "1. Atomic Local Write: ", "Mutations update local SQLite rows immediately with isDirty = true and syncStatus = 'pending'.")
    add_bullet(doc, "2. Queue Persistence: ", "An immutable SyncOperationModel containing UUID operationId, userId, shipmentId, operationType (CREATE_SHIPMENT, UPDATE_STATUS, SUBMIT_POD), JSON payload, and localTimestamp is inserted into SyncQueue.")
    add_bullet(doc, "3. Connectivity Listener: ", "SyncEngine subscribes to ConnectivityService.statusStream and triggers syncNow() automatically whenever internet connectivity returns.")
    add_bullet(doc, "4. FIFO Processing & Retries: ", "Pending operations execute sequentially by timestamp; failures increment retryCount and log diagnostics without dropping queued items.")

    # 9. Conflict Resolution
    add_heading_styled(doc, "9. Conflict Resolution Architecture", level=1)
    add_body(
        doc,
        "Concurrent offline edits are handled by ConflictResolver (lib/core/sync/conflict_resolver.dart) using optimistic concurrency checks against server version integers and updated_at timestamps:"
    )
    add_bullet(doc, "Evidence Preservation Rule (SUBMIT_POD): ", "Proof-of-Delivery evidence (receiver signature, delivery photo, GPS coordinates) is NEVER discarded even if the server shipment version diverged. ConflictResolver marks the strategy as ConflictStrategy.evidencePreserved, transitions status to delivered, and writes an explicit reconciliation note.")
    add_bullet(doc, "Delivered State Regression Guard: ", "Once a shipment reaches delivered on the server, stale offline transit updates (e.g., in_transit) are safely rejected via ConflictStrategy.serverWins.")
    add_bullet(doc, "Latest Timestamp Precedence: ", "Intermediate transit transitions resolve via clientTimestamp vs. serverUpdatedAt comparison with audit logging.")

    # 10. Security
    add_heading_styled(doc, "10. Security Architecture", level=1)
    add_bullet(doc, "Database-Level Authorization (RLS): ", "Supabase Row Level Security restricts shippers to their own consignments while permitting hub managers and drivers to execute transit updates and POD uploads.")
    add_bullet(doc, "Credential Hygiene: ", "Service-role keys, .env files, Android key.properties, and release keystores (*.jks) are excluded via .gitignore. A sanitized .env.example is provided for deployment setup.")
    add_bullet(doc, "Android Release Hardening: ", "Configured with minSdk = 23, R8 code shrinking (isMinifyEnabled = true), resource shrinking, and signed release builds via PKCS12 keystore.")

    # 11. Testing & Quality Assurance
    add_heading_styled(doc, "11. Testing & Verification Results", level=1)
    add_body(
        doc,
        "Automated verification was executed against the final codebase using Flutter's static analyzer and test runner:"
    )
    add_table(
        doc,
        ["Verification Suite", "Scope Covered", "Observed Outcome"],
        [
            ["flutter analyze", "Full Dart codebase, Drift generated DAOs, Riverpod providers & screens", "Passed (0 issues found)"],
            ["test/unit/shipment_model_test.dart", "JSON roundtrips, status & priority enum parsing, helper flags", "4/4 Passed"],
            ["test/unit/conflict_resolver_test.dart", "Version matches, POD evidence preservation, delivered regression guard", "3/3 Passed"],
            ["test/unit/validation_test.dart", "Email, Indian phone numbers, package weight, LGF-YYYY-XXXXX tracking IDs", "4/4 Passed"],
            ["test/widget/login_screen_test.dart", "Login form rendering & Demo Shipper credential quick-fill", "2/2 Passed"],
            ["test/widget/dashboard_and_screens_test.dart", "ShipmentListScreen search/filter chips & CreateShipmentScreen form cards", "2/2 Passed"],
            ["test/widget_test.dart", "Root LogisticsApp initialization with Drift in-memory database", "1/1 Passed"],
            ["test/integration/offline_sync_test.dart", "End-to-end offline queueing, conflict check & synced state transition", "1/1 Passed"],
        ]
    )
    add_body(
        doc,
        "Total Automated Tests Executed: 17 tests passed (exit code 0). Note: Hardware camera barcode scanning, live GPS satellite fix acquisition, and multi-device real-time Supabase synchronization require physical Android/iOS hardware and live Supabase project credentials configured in .env."
    )

    # 12. Conclusion & Future Enhancements
    add_heading_styled(doc, "12. Conclusion & Future Enhancements", level=1)
    add_body(
        doc,
        "LogiFlow fulfills all architectural, functional, offline-first, security, and testing requirements for an enterprise 3PL mobile deployment. It demonstrates clean separation of concerns, resilient local-first engineering, bilingual accessibility, and verifiable conflict handling."
    )
    add_body(doc, "Planned Future Enhancements:", bold_prefix="Roadmap: ")
    add_bullet(doc, "Live Route Polyline Optimization: ", "Integrate multi-stop TSP route sequencing across Noida & Greater Noida sectors using Google Maps Directions API.")
    add_bullet(doc, "Automated Push Triggers: ", "Deploy Supabase Edge Functions connected to Firebase Cloud Messaging (FCM) for instant customer WhatsApp/Push delivery alerts.")
    add_bullet(doc, "Image Compression Worker: ", "Background isolate compression for multi-megapixel delivery proof photographs before Supabase Storage upload.")

    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    doc.save(output_path)
    print(f"Report generated successfully at: {output_path}")

if __name__ == "__main__":
    build_report("docs/LogiFlow_Project_Report.docx")
