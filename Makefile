arch=x86_64
src_folder=src/arch/$(arch)
bootloader_asm_files=$(wildcard $(src_folder)/asm/*.asm)
kernel_asm_files=$(wildcard $(src_folder)/kernel/*.asm)

kernel=build/kernel-$(arch).bin
bootloader=build/bootloader-$(arch).bin
os=build/os-$(arch).bin
os_truncated=build/os-$(arch)-truncated.bin
os_iso=build/os-$(arch).iso
iso_dir=build/iso

qemu=qemu-system-$(arch)

AS=nasm

.PHONY: all clean run iso

all:
	mkdir -p build/iso
	$(AS) -f bin $(bootloader_asm_files) -o $(bootloader)
	$(AS) -f bin $(kernel_asm_files) -o $(kernel)
	cp $(bootloader) $(os)
	cat $(kernel) >> $(os)

clean:
	rm build/*
	rm build/iso/*.bin

run: $(kernel)
	$(qemu) -fda $(os)
run_iso: $(os_iso)
	$(qemu) -cdrom $(os_iso)

iso:
	mkdir -p build/iso
	cp $(os) $(os_truncated)
	truncate -s 1200k $(os_truncated)
	cp $(os_truncated) build/iso/boot.bin
	mkisofs -o $(os_iso) -b boot.bin ./$(iso_dir)