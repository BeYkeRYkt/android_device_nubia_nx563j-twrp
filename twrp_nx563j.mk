#
# Copyright 2017-2022 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Release name
PRODUCT_RELEASE_NAME := nx563j

# Inherit AOSP product makefiles
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := nx563j
PRODUCT_NAME := twrp_nx563j
PRODUCT_BRAND := nubia
PRODUCT_MODEL := Z17
PRODUCT_MANUFACTURER := nubia

PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=NX563J PRODUCT_NAME=NX563J

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="NX563J-user 7.1.1 NMF26X eng.nubia.20181008.160254 release-keys"

BUILD_FINGERPRINT := nubia/NX563J/NX563J:7.1.1/NMF26X/eng.nubia.20171019.101529:user/release-keys

ifeq ($(NUBIA_DYNAMIC), true)
# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd
endif

# qcom standard decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.keystore=msm8998 \
    ro.hardware.gatekeeper=msm8998

# Verity
PRODUCT_SUPPORTS_BOOT_SIGNER := true
PRODUCT_SUPPORTS_VERITY := false
PRODUCT_SUPPORTS_VERITY_FEC := false
PRODUCT_VERITY_SIGNING_KEY := build/target/product/security/verity
