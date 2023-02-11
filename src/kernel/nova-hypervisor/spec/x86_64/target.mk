
TARGET   = nova-hypervisor
REQUIRES = x86 nova-hypervisor

NOVA_SRC_DIR  = $(call select_from_ports,nova-hypervisor)/src/kernel/nova
NOVA_BUID_DIR = $(BUILD_BASE_DIR)/kernel/nova-next
 
INC_DIR = $(NOVA_SRC_DIR)/inc/x86_64
SRC_CC  = $(sort $(notdir $(wildcard $(NOVA_SRC_DIR)/src/x86_64/*.cpp)))
SRC_S   = $(sort $(notdir $(wildcard $(NOVA_SRC_DIR)/src/x86_64/*.S)))

vpath %.cpp $(NOVA_SRC_DIR)/src/x86_64
vpath %.S $(NOVA_SRC_DIR)/src/x86_64

#override CC_MARCH = -m64
CC_WARN = -Wframe-larger-than=512
#CC_OPT  := -mpreferred-stack-boundary=4 -mcmodel=kernel -mno-red-zone
CC_OPT  = -Wa,--divide,--noexecstack -m64 -march=core2 -mcmodel=kernel -mno-red-zone -mno-mmx -mno-sse

git_version      = $(shell cd $(NOVA_SRC_DIR) && (git rev-parse HEAD 2>/dev/null || echo 0) | cut -c1-7)
CXX_LINK_OPT     = -Wl,--gc-sections -Wl,--warn-common -Wl,-static -Wl,-n -Wl,--defsym=GIT_VER=0x$(call git_version)

LD_TEXT_ADDR     = # 0xc000000000 - when setting this 64bit compile fails because of relocation issues!! 
LD_SCRIPT_STATIC = hypervisor.o

$(TARGET): hypervisor.o

hypervisor.o: $(NOVA_SRC_DIR)/src/hypervisor.ld target.mk
	$(VERBOSE)$(CC) $(INCLUDES) -DCONFIG_MEMORY_BOOT=128M -MP -MMD -xassembler-with-cpp -E -P $< -o $@
#	$(VERBOSE)$(CC) $(INCLUDES) -DCONFIG_MEMORY_BOOT=128M -MP -MMD -pipe $(CC_MARCH) -xassembler-with-cpp -E -P $< -o $@

include $(REP_DIR)/src/kernel/nova-hypervisor/nova-hypervisor.inc

