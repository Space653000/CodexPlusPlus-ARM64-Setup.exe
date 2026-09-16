from __future__ import annotations

import pathlib
import sys


def replace_once(text: str, old: str, new: str, label: str) -> str:
    count = text.count(old)
    if count != 1:
        raise SystemExit(f"Patch guard failed for {label}: expected 1 match, found {count}")
    return text.replace(old, new, 1)


def patch_updater(root: pathlib.Path) -> None:
    path = root / "crates" / "codex-plus-core" / "src" / "update.rs"
    text = path.read_text(encoding="utf-8")

    text = replace_once(
        text,
        '    let update_available = is_newer_version(&release.version, current_version)?;\n',
        '    let update_available = is_newer_version(&release.version, current_version)?\n'
        '        && release.asset_url.is_some();\n',
        "update availability guard",
    )

    text = replace_once(
        text,
        '    if cfg!(windows) && is_windows_installer_asset(name) {\n'
        '        return 0;\n'
        '    }\n',
        '    if cfg!(windows) {\n'
        '        if !is_windows_installer_asset(name) {\n'
        '            return 2;\n'
        '        }\n'
        '        if is_windows_native_arch_asset(name) {\n'
        '            return 0;\n'
        '        }\n'
        '        // Never cross-update an ARM64 build with an x64 installer (or vice versa).\n'
        '        return 2;\n'
        '    }\n',
        "Windows platform rank",
    )

    anchor = '''fn is_windows_installer_asset(name: &str) -> bool {\n'''
    helper = r'''fn is_windows_native_arch_asset(name: &str) -> bool {
    let lower = name.to_ascii_lowercase();
    let native_arch_token = match std::env::consts::ARCH {
        "x86_64" => "x64",
        "aarch64" => "arm64",
        _ => return true,
    };
    let other_arch_token = if native_arch_token == "x64" {
        "arm64"
    } else {
        "x64"
    };

    let native_markers = [
        format!("-windows-{native_arch_token}-"),
        format!("-windows-{native_arch_token}."),
        format!("_{native_arch_token}."),
        format!("-{native_arch_token}."),
    ];
    if native_markers.iter().any(|marker| lower.contains(marker)) {
        return true;
    }

    let other_markers = [
        format!("-windows-{other_arch_token}-"),
        format!("-windows-{other_arch_token}."),
        format!("_{other_arch_token}."),
        format!("-{other_arch_token}."),
    ];
    if other_markers.iter().any(|marker| lower.contains(marker)) {
        return false;
    }

    // Legacy installer names without an architecture token are accepted.
    true
}

'''
    text = replace_once(text, anchor, helper + anchor, "Windows architecture helper")
    path.write_text(text, encoding="utf-8")
    print(f"ARM64 updater safety patch applied: {path}")


def patch_windows_package_api(root: pathlib.Path) -> None:
    path = root / "crates" / "codex-plus-core" / "src" / "app_paths.rs"
    text = path.read_text(encoding="utf-8")

    old = '''        GetPackagesByPackageFamily(\n            PCWSTR(family.as_ptr()),\n            &mut count,\n            &mut buffer_length,\n            PWSTR(std::ptr::null_mut()),\n        )\n'''
    new = '''        GetPackagesByPackageFamily(\n            PCWSTR(family.as_ptr()),\n            &mut count,\n            None,\n            &mut buffer_length,\n            PWSTR(std::ptr::null_mut()),\n        )\n'''
    text = replace_once(
        text,
        old,
        new,
        "GetPackagesByPackageFamily probe call",
    )
    path.write_text(text, encoding="utf-8")
    print(f"Windows package API compatibility patch applied: {path}")


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("usage: patch_arm64.py <upstream-root>")

    root = pathlib.Path(sys.argv[1]).resolve()
    patch_updater(root)
    patch_windows_package_api(root)
    print("All Windows ARM64 compatibility patches applied successfully.")


if __name__ == "__main__":
    main()
