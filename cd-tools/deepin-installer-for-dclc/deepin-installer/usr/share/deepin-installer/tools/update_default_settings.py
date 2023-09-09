#!/usr/bin/env python3
#
# Copyright (C) 2017 ~ 2018 Deepin Technology Co., Ltd.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Generate default settings for loongson and sw platforms.
# Execute this program after updating options in resources/default_settings.ini.

import configparser
import os
import shutil
import sys

SEC_NAME = "General"

def update_settings(settings_file, settings):
    src_settings = "resources/default_settings.ini"
    if not os.path.exists(src_settings):
        print("Failed to find", src_settings)
        sys.exit(1)

    if os.path.exists(settings_file):
        os.remove(settings_file)

    config = configparser.ConfigParser()
    config.read(settings_file, encoding="utf-8")
    config.add_section(SEC_NAME)
    config.write(open(settings_file, "w"))

    parser = configparser.RawConfigParser()
    parser.read(settings_file)
    for key, value in settings:
        parser.set(SEC_NAME, key, value)
    with open(settings_file, "w") as fh:
        parser.write(fh)

def main():
    arm_community_file = "resources/platform_arm/community.override"
    arm_professional_file = "resources/platform_arm/professional.override"
    arm_server_file = "resources/platform_arm/server.override"

    loongson_community_file = "resources/platform_loongson/community.override"
    loongson_professional_file = "resources/platform_loongson/professional.override"
    loongson_server_file = "resources/platform_loongson/server.override"

    sw_community_file = "resources/platform_sw/community.override"
    sw_professional_file = "resources/platform_sw/professional.override"
    sw_server_file = "resources/platform_sw/server.override"

    x86_community_file = "resources/platform_x86/community.override"
    x86_professional_file = "resources/platform_x86/professional.override"
    x86_server_file = "resources/platform_x86/server.override"

    arm_community_settings = (
        ("select_language_default_locale", "zh_CN"),
        ("timezone_default", "Asia/Beijing"),
        ("partition_skip_simple_partition_page", "true"),
        ("partition_skip_partition_crypt_page", "true"),
    )

    arm_server_settings = (
        ("skip_select_component_page", "false"),
        ("select_language_default_locale", "zh_CN"),
        ("timezone_default", "Asia/Beijing"),
        ("partition_skip_simple_partition_page", "true"),
        ("partition_skip_partition_crypt_page", "true"),
        ("set_root_password_from_user", "true"),
        ("partition_default_button", "1"),
        ("partition_full_disk_large_root_part_range", "\"20:150\""),
    )

    loongson_community_settings = (
        ("select_language_default_locale", "zh_CN"),
        ("timezone_default", "Asia/Beijing"),
        ("partition_skip_simple_partition_page", "true"),
        ("partition_skip_partition_crypt_page", "true"),
        ("partition_enable_swap_file", "false"),
        ("partition_force_swap_file_in_simple_page", "false"),
        ("partition_supported_fs", '"ext4;ext3;ext2;efi;linux-swap"'),
        ("partition_enable_os_prober", "false"),
        ("partition_boot_on_first_partition", "true"),
        ("partition_prefer_logical_partition", "false"),
        ("partition_full_disk_small_legacy_policy", '"/boot:ext4:1:1536;swap:linux-swap:1537:swap-size;/:ext4::100%"'),
        ("partition_full_disk_large_legacy_policy", '"/boot:ext4:1:1536;swap:linux-swap:1537:swap-size;/:ext4::75%;:ext4::100%"'),
        ("partition_full_disk_small_legacy_label", '"Boot;Swap;Root"'),
        ("partition_full_disk_large_legacy_label", '"Boot;Swap;Root;_dde_data"'),
    )

    loongson_server_settings = (
        ("select_language_default_locale", "zh_CN"),
        ("timezone_default", "Asia/Beijing"),
        ("partition_skip_simple_partition_page", "true"),
        ("partition_skip_partition_crypt_page", "true"),
        ("partition_enable_swap_file", "false"),
        ("partition_force_swap_file_in_simple_page", "false"),
        ("partition_supported_fs", '"ext4;ext3;ext2;efi;linux-swap"'),
        ("partition_enable_os_prober", "false"),
        ("partition_boot_on_first_partition", "true"),
        ("partition_prefer_logical_partition", "false"),
        ("partition_full_disk_small_legacy_policy", '"/boot:ext4:1:1536;swap:linux-swap:1537:swap-size;/:ext4::100%"'),
        ("partition_full_disk_large_legacy_policy", '"/boot:ext4:1:1536;swap:linux-swap:1537:swap-size;/:ext4::75%;:ext4::100%"'),
        ("partition_full_disk_small_legacy_label", '"Boot;Swap;Root"'),
        ("partition_full_disk_large_legacy_label", '"Boot;Swap;Root;_dde_data"'),
        ("skip_select_component_page", "false"),
        ("set_root_password_from_user", "true"),
        ("partition_default_button", "1"),
        ("partition_full_disk_large_root_part_range", "\"20:150\""),
    )

    sw_community_settings = (
        ("select_language_default_locale", "zh_CN"),
        ("timezone_default", "Asia/Beijing"),
        ("partition_skip_simple_partition_page", "true"),
        ("partition_skip_partition_crypt_page", "true"),
        ("partition_enable_swap_file", "false"),
        ("partition_force_swap_file_in_simple_page", "false"),
        ("partition_supported_fs", '"ext4;ext3;ext2;efi;linux-swap"'),
        ("partition_enable_os_prober", "false"),
        ("partition_boot_on_first_partition", "true"),
        ("partition_prefer_logical_partition", "false"),
        ("partition_full_disk_small_legacy_policy", '"/boot:ext4:1:1536;swap:linux-swap:1537:swap-size;/:ext4::100%"'),
        ("partition_full_disk_large_legacy_policy", '"/boot:ext4:1:1536;swap:linux-swap:1537:swap-size;/:ext4::75%;:ext4::100%"'),
        ("partition_full_disk_small_legacy_label", '"Boot;Swap;Root"'),
        ("partition_full_disk_large_legacy_label", '"Boot;Swap;Root;_dde_data"'),
    )

    sw_server_settings = (
        ("select_language_default_locale", "zh_CN"),
        ("timezone_default", "Asia/Beijing"),
        ("partition_skip_simple_partition_page", "true"),
        ("partition_skip_partition_crypt_page", "true"),
        ("partition_enable_swap_file", "false"),
        ("partition_force_swap_file_in_simple_page", "false"),
        ("partition_supported_fs", '"ext4;ext3;ext2;efi;linux-swap"'),
        ("partition_enable_os_prober", "false"),
        ("partition_boot_on_first_partition", "true"),
        ("partition_prefer_logical_partition", "false"),
        ("partition_full_disk_small_legacy_policy", '"/boot:ext4:1:1536;swap:linux-swap:1537:swap-size;/:ext4::100%"'),
        ("partition_full_disk_large_legacy_policy", '"/boot:ext4:1:1536;swap:linux-swap:1537:swap-size;/:ext4::75%;:ext4::100%"'),
        ("partition_full_disk_small_legacy_label", '"Boot;Swap;Root"'),
        ("partition_full_disk_large_legacy_label", '"Boot;Swap;Root;_dde_data"'),
        ("skip_select_component_page", "false"),
        ("set_root_password_from_user", "true"),
        ("partition_default_button", "1"),
        ("partition_full_disk_large_root_part_range", "\"20:150\""),
    )

    x86_community_settings = (
        ("select_language_default_locale", "zh_CN"),
        ("timezone_default", "Asia/Beijing"),
        ("timezone_use_local_time_regardless", "true"),
        ("skip_select_component_page", "true"),
        ("partition_skip_simple_partition_page", "true"),
    )

    x86_community_settings = (
        ("system_info_disable_license", "true"),
    )

    x86_professinal_settings = (
        ("select_language_default_locale", "zh_CN"),
        ("timezone_default", "Asia/Beijing"),
        ("timezone_use_local_time_regardless", "true"),
        ("skip_select_component_page", "true"),
        ("partition_skip_simple_partition_page", "true"),
        ("enable_install_nvidia_driver", "true"),
    )

    x86_server_settings = (
        ("skip_select_component_page", "false"),
        ("select_language_default_locale", "zh_CN"),
        ("timezone_default", "Asia/Beijing"),
        ("partition_skip_simple_partition_page", "true"),
        ("set_root_password_from_user", "true"),
        ("partition_default_button", "1"),
        ("partition_full_disk_large_root_part_range", "\"20:150\""),
    )

    update_settings(arm_community_file, arm_community_settings)
    update_settings(arm_professional_file, arm_community_settings)
    update_settings(arm_server_file, arm_server_settings)

    update_settings(loongson_community_file, loongson_community_settings)
    update_settings(loongson_professional_file, loongson_community_settings)
    update_settings(loongson_server_file, loongson_server_settings)

    update_settings(sw_community_file, sw_community_settings)
    update_settings(sw_professional_file, sw_community_settings)
    update_settings(sw_server_file, sw_server_settings)

    update_settings(x86_community_file, x86_community_settings)
    update_settings(x86_professional_file, x86_professinal_settings)
    update_settings(x86_server_file, x86_server_settings)

if __name__ == "__main__":
    main()
