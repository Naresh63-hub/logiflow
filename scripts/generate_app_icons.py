"""
Comprehensive icon generator for LogiFlow across Android, Web, and iOS.
Renders with 4x supersampling (4096x4096) and Lanczos downsampling.
"""

import math
import os
from PIL import Image, ImageDraw, ImageFilter

def draw_logiflow_symbol(draw, cx, cy, size, scale):
    """
    Draws the LogiFlow brand mark:
    - Isometric 3D Logistics Parcel (Top/Left/Right facets in gradient orange)
    - Center sealing tape
    - Dynamic supersonic 'Flow' trajectory swoosh & arrow in electric cyan & white
    """
    box_r = size * 0.28
    
    # 30-degree isometric projection vectors
    cos30 = math.cos(math.radians(30))
    sin30 = math.sin(math.radians(30))
    
    dx = box_r * cos30
    dy = box_r * sin30
    h = box_r * 1.12  # Box depth
    
    # Vertices
    # Center-top vertex of the box (where top, left, right faces meet)
    # Offset center slightly to account for the dynamic flow arrow at top-right
    bcx = cx - size * 0.02
    bcy = cy + size * 0.04
    
    p_center = (bcx, bcy - h * 0.35)
    p_top = (bcx, p_center[1] - 2 * dy)
    p_right = (bcx + dx, p_center[1] - dy)
    p_left = (bcx - dx, p_center[1] - dy)
    
    p_bottom = (bcx, p_center[1] + h)
    p_l_bottom = (bcx - dx, p_left[1] + h)
    p_r_bottom = (bcx + dx, p_right[1] + h)
    
    # Left Face (Darker terracotta orange for 3D shadow depth)
    draw.polygon([p_left, p_center, p_bottom, p_l_bottom], fill=(217, 70, 0, 255))
    
    # Right Face (Vibrant safety/accent orange)
    draw.polygon([p_right, p_center, p_bottom, p_r_bottom], fill=(255, 95, 0, 255))
    
    # Top Face (Bright amber/golden orange representing sunlight from above)
    draw.polygon([p_top, p_right, p_center, p_left], fill=(255, 160, 36, 255))
    
    # Tape Stripe across Top Face
    tape_w = box_r * 0.22
    tdx = tape_w * cos30 * 0.5
    tdy = tape_w * sin30 * 0.5
    tape_top = [
        (p_top[0] - tdx, p_top[1] + tdy),
        (p_top[0] + tdx, p_top[1] - tdy),
        (p_center[0] + tdx, p_center[1] - tdy),
        (p_center[0] - tdx, p_center[1] + tdy),
    ]
    draw.polygon(tape_top, fill=(255, 205, 110, 240))
    
    # Tape Stripe down Right Face
    tape_right = [
        (p_center[0] - tdx, p_center[1] + tdy),
        (p_center[0] + tdx, p_center[1] - tdy),
        (p_bottom[0] + tdx, p_bottom[1] - tdy),
        (p_bottom[0] - tdx, p_bottom[1] + tdy),
    ]
    draw.polygon(tape_right, fill=(235, 80, 0, 230))
    
    # Polished subtle highlight edges
    edge_color = (255, 255, 255, 75)
    ew = max(1, int(2 * scale))
    draw.line([p_top, p_right], fill=edge_color, width=ew)
    draw.line([p_top, p_left], fill=edge_color, width=ew)
    draw.line([p_center, p_right], fill=edge_color, width=ew)
    draw.line([p_center, p_left], fill=edge_color, width=ew)
    draw.line([p_center, p_bottom], fill=edge_color, width=ew)
    draw.line([p_left, p_l_bottom], fill=edge_color, width=ew)
    draw.line([p_right, p_r_bottom], fill=edge_color, width=ew)
    draw.line([p_l_bottom, p_bottom], fill=edge_color, width=ew)
    draw.line([p_r_bottom, p_bottom], fill=edge_color, width=ew)
    
    # --- Supersonic Flow Trajectory (The "Flow" in LogiFlow) ---
    # Arc swooshing from bottom-left under the parcel, curling up past the right face
    # and shooting into a crisp forward delta arrow.
    
    # Flow Trail 1 (Electric Cyan)
    trail_pts = [
        (cx - size * 0.40, cy + size * 0.18),
        (cx - size * 0.18, cy + size * 0.32),
        (cx + size * 0.14, cy + size * 0.28),
        (cx + size * 0.38, cy + size * 0.05),
        (cx + size * 0.34, cy - size * 0.02),
        (cx + size * 0.12, cy + size * 0.19),
        (cx - size * 0.16, cy + size * 0.23),
        (cx - size * 0.35, cy + size * 0.12),
    ]
    draw.polygon(trail_pts, fill=(0, 215, 255, 245))
    
    # Secondary Inner White Glow Trail
    inner_trail = [
        (cx - size * 0.32, cy + size * 0.21),
        (cx - size * 0.14, cy + size * 0.34),
        (cx + size * 0.10, cy + size * 0.30),
        (cx + size * 0.28, cy + size * 0.16),
        (cx + size * 0.24, cy + size * 0.12),
        (cx + size * 0.08, cy + size * 0.24),
        (cx - size * 0.12, cy + size * 0.27),
        (cx - size * 0.28, cy + size * 0.17),
    ]
    draw.polygon(inner_trail, fill=(255, 255, 255, 255))
    
    # Delta Arrow Head pointing North-East (Speed / Delivery Direction)
    arrow_tip = (cx + size * 0.43, cy - size * 0.01)
    arrow_top = (cx + size * 0.30, cy - size * 0.12)
    arrow_notch = (cx + size * 0.33, cy - size * 0.02)
    arrow_bottom = (cx + size * 0.28, cy + size * 0.07)
    draw.polygon([arrow_tip, arrow_top, arrow_notch, arrow_bottom], fill=(255, 255, 255, 255))
    
    # Subtle trailing speed dashes
    dash1 = [
        (cx - size * 0.42, cy + size * 0.28),
        (cx - size * 0.28, cy + size * 0.37),
        (cx - size * 0.26, cy + size * 0.33),
        (cx - size * 0.40, cy + size * 0.24),
    ]
    draw.polygon(dash1, fill=(0, 215, 255, 180))


def generate_icon(size, rounded=True, maskable=False):
    """
    Generates a high-quality icon at `size` x `size`.
    If maskable=True: Full-bleed square with safe margins.
    If rounded=True: Squircle cut for Android / Web standard icon.
    If rounded=False and maskable=False: Solid square with standard margins.
    """
    scale = 3  # 3x supersampling
    c_size = size * scale
    
    img = Image.new("RGBA", (c_size, c_size), (0, 0, 0, 0))
    bg = Image.new("RGBA", (c_size, c_size), (0, 0, 0, 0))
    bg_draw = ImageDraw.Draw(bg)
    
    # Deep Navy Corporate Gradient
    # Top: #12243A, Bottom: #070F1B
    top_c = (18, 36, 58, 255)
    bot_c = (7, 15, 27, 255)
    for y in range(c_size):
        t = y / float(c_size)
        r = int(top_c[0] * (1 - t) + bot_c[0] * t)
        g = int(top_c[1] * (1 - t) + bot_c[1] * t)
        b = int(top_c[2] * (1 - t) + bot_c[2] * t)
        bg_draw.line([(0, y), (c_size, y)], fill=(r, g, b, 255))
        
    cx = c_size / 2.0
    cy = c_size / 2.0
    
    # Radial Ambient Glow in background behind emblem
    glow_rad = int(c_size * 0.35)
    glow = Image.new("RGBA", (glow_rad * 2, glow_rad * 2), (0, 0, 0, 0))
    g_draw = ImageDraw.Draw(glow)
    for r in range(glow_rad, 0, -3):
        frac = r / float(glow_rad)
        alpha = int(35 * (1.0 - frac)**1.4)
        g_draw.ellipse(
            [glow_rad - r, glow_rad - r, glow_rad + r, glow_rad + r],
            fill=(255, 101, 0, alpha)
        )
    glow = glow.filter(ImageFilter.GaussianBlur(radius=int(14 * scale)))
    bg.alpha_composite(glow, dest=(int(cx - glow_rad), int(cy - glow_rad)))
    
    # Draw the LogiFlow Symbol onto bg
    # If maskable, scale symbol slightly smaller to respect 15% safe padding
    symbol_scale = 0.82 if maskable else 0.95
    draw_logiflow_symbol(bg_draw, cx, cy, c_size * symbol_scale, scale)
    
    if rounded and not maskable:
        mask = Image.new("L", (c_size, c_size), 0)
        m_draw = ImageDraw.Draw(mask)
        corner_r = int(c_size * 0.22)
        m_draw.rounded_rectangle(
            [(0, 0), (c_size - 1, c_size - 1)],
            radius=corner_r,
            fill=255
        )
        img.paste(bg, (0, 0), mask)
        
        # Outer rim highlight
        idraw = ImageDraw.Draw(img)
        idraw.rounded_rectangle(
            [(scale, scale), (c_size - 1 - scale, c_size - 1 - scale)],
            radius=corner_r - scale,
            outline=(50, 85, 130, 160),
            width=int(2 * scale)
        )
    else:
        img = bg
        
    return img.resize((size, size), Image.Resampling.LANCZOS)

def main():
    print("Generating LogiFlow multi-platform app launcher icons...")
    
    # 1. Android Mipmap Icons
    android_targets = [
        ("android/app/src/main/res/mipmap-mdpi/ic_launcher.png", 48),
        ("android/app/src/main/res/mipmap-hdpi/ic_launcher.png", 72),
        ("android/app/src/main/res/mipmap-xhdpi/ic_launcher.png", 96),
        ("android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png", 144),
        ("android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png", 192),
    ]
    for path, sz in android_targets:
        os.makedirs(os.path.dirname(path), exist_ok=True)
        icon = generate_icon(sz, rounded=True, maskable=False)
        icon.save(path, "PNG")
        print(f"  [Android] Saved {sz}x{sz} -> {path}")
        
    # 2. Web Icons & Favicon
    web_targets = [
        ("web/favicon.png", 64, True, False),
        ("web/icons/Icon-192.png", 192, True, False),
        ("web/icons/Icon-512.png", 512, True, False),
        ("web/icons/Icon-maskable-192.png", 192, False, True),
        ("web/icons/Icon-maskable-512.png", 512, False, True),
    ]
    for path, sz, rnd, mask in web_targets:
        os.makedirs(os.path.dirname(path), exist_ok=True)
        icon = generate_icon(sz, rounded=rnd, maskable=mask)
        icon.save(path, "PNG")
        print(f"  [Web] Saved {sz}x{sz} (maskable={mask}) -> {path}")

    # 3. iOS AppIcon set
    ios_dir = "ios/Runner/Assets.xcassets/AppIcon.appiconset"
    ios_targets = [
        (os.path.join(ios_dir, "Icon-App-20x20@1x.png"), 20),
        (os.path.join(ios_dir, "Icon-App-20x20@2x.png"), 40),
        (os.path.join(ios_dir, "Icon-App-20x20@3x.png"), 60),
        (os.path.join(ios_dir, "Icon-App-29x29@1x.png"), 29),
        (os.path.join(ios_dir, "Icon-App-29x29@2x.png"), 58),
        (os.path.join(ios_dir, "Icon-App-29x29@3x.png"), 87),
        (os.path.join(ios_dir, "Icon-App-40x40@1x.png"), 40),
        (os.path.join(ios_dir, "Icon-App-40x40@2x.png"), 80),
        (os.path.join(ios_dir, "Icon-App-40x40@3x.png"), 120),
        (os.path.join(ios_dir, "Icon-App-60x60@2x.png"), 120),
        (os.path.join(ios_dir, "Icon-App-60x60@3x.png"), 180),
        (os.path.join(ios_dir, "Icon-App-76x76@1x.png"), 76),
        (os.path.join(ios_dir, "Icon-App-76x76@2x.png"), 152),
        (os.path.join(ios_dir, "Icon-App-83.5x83.5@2x.png"), 167),
        (os.path.join(ios_dir, "Icon-App-1024x1024@1x.png"), 1024),
    ]
    for path, sz in ios_targets:
        os.makedirs(os.path.dirname(path), exist_ok=True)
        # iOS AppStore icons are unmasked squares (iOS applies the squircle curvature)
        icon = generate_icon(sz, rounded=False, maskable=False)
        icon.save(path, "PNG")
        print(f"  [iOS] Saved {sz}x{sz} -> {path}")

    # 4. Master branding asset for in-app / docs
    os.makedirs("assets/branding", exist_ok=True)
    master = generate_icon(1024, rounded=True, maskable=False)
    master.save("assets/branding/app_logo.png", "PNG")
    print(f"  [Master] Saved 1024x1024 -> assets/branding/app_logo.png")

if __name__ == "__main__":
    main()
