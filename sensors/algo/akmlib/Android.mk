LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

AKMD_DEVICE_TYPE=9911

# Define Device
ifeq ($(AKMD_DEVICE_TYPE), 8975)
DEVICE_STRING=8975
LOCAL_CFLAGS := -DAKMD_AK8975
else ifeq ($(AKMD_DEVICE_TYPE), 8963)
DEVICE_STRING=8963
LOCAL_CFLAGS := -DAKMD_AK8963
else ifeq ($(AKMD_DEVICE_TYPE), 9912)
DEVICE_STRING=09912
LOCAL_CFLAGS := -DAKMD_AK09912
else ifeq ($(AKMD_DEVICE_TYPE), 9911)
DEVICE_STRING=09911
LOCAL_CFLAGS := -DAKMD_AK09911
else
$(error AKMD_DEVICE_TYPE is not defined)
endif

LOCAL_LDFLAGS += -L$(LOCAL_PATH)/libSmartCompass -lAK09911wPGplus64

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/libSmartCompass \
	hardware/qcom/sensors/

LOCAL_SRC_FILES += \
	AKMD_APIs.c \
	FileIO.c \
	Measure.c \
	akm_wrapper.c	

LOCAL_CFLAGS += -DAKSC_DISABLE_D6D

## Enable ALOGE
LOCAL_CFLAGS += -UNDEBUG
LOCAL_CFLAGS += -DENABLE_AKMDEBUG=1
LOCAL_CFLAGS += -DAKM_LOG_ENABLE
LOCAL_CFLAGS += -DENABLE_AKM_PG
LOCAL_CFLAGS += -DAKMD_DISABLE_DOEPLUS

LOCAL_MULTILIB := 64

LOCAL_MODULE_PATH_64 := $(TARGET_OUT_VENDOR)/lib64
LOCAL_SHARED_LIBRARIES += liblog
LOCAL_MODULE:=libcalmodule_akm
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)
