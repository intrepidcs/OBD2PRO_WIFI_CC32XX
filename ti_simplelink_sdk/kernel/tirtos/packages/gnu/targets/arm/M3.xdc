/*
 *  Copyright 2017 by Texas Instruments Incorporated.
 *
 */

/*
 *  Copyright (c) 2008-2017 Texas Instruments and others.
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 *
 *  Contributors:
 *      Texas Instruments - initial implementation
 */
import xdc.bld.ITarget2;

/*!
 *  ======== M3.xdc ========
 *  Embedded little endian Cortex M3 bare metal target
 *
 *  This module defines an embedded bare metal target on Cortex M3. The target
 *  generates code compatible with the "v7M" architecture.
 *
 */
metaonly module M3 inherits IM {
    override readonly config string name                = "M3"; 
    override readonly config string suffix              = "m3g";
    override readonly config string isa                 = "v7M";

    override config string platform     = "ti.platforms.tiva:TM4C1294NCPDT";

    override readonly config ITarget2.Command cc = {
        cmd: "$(rootDir)/bin/$(GCCTARG)-gcc -c -MD -MF $@.dep",
        opts: "-mcpu=cortex-m3 -mthumb -mabi=aapcs -g"
    };

    readonly config ITarget2.Command ccBin = {
        cmd: "bin/arm-none-eabi-gcc -c -MD -MF $@.dep",
        opts: "-mcpu=cortex-m3 -mthumb -mabi=aapcs -g"
    };

    override readonly config ITarget2.Command asm = {
        cmd: "$(rootDir)/bin/$(GCCTARG)-gcc -c -x assembler-with-cpp",
        opts: "-Wa,-mcpu=cortex-m3 -Wa,-mthumb"
    };

    readonly config ITarget2.Command asmBin = {
        cmd: "bin/arm-none-eabi-gcc -c -x assembler-with-cpp",
        opts: "-Wa,-mcpu=cortex-m3 -Wa,-mthumb"
    };

    override config ITarget2.Options lnkOpts = {
        prefix: "-mthumb -march=armv7-m -nostartfiles -Wl,-static -Wl,--gc-sections",
        suffix: "-L$(packageBase)/libs/install-native/$(GCCTARG)/lib/thumb/v7-m -Wl,--start-group -lgcc -lc -lm -Wl,--end-group --specs=nano.specs -Wl,-Map=$(XDCCFGDIR)/$@.map"
    };

    /*!
     *  ======== includeOpts ========
     *  Additional user configurable target-specific include path options
     *
     *  This target uses newlib-nano run-time.
     */
    override config string includeOpts = "-I$(packageBase)/libs/install-native/$(GCCTARG)/include/newlib-nano -I$(packageBase)/libs/install-native/$(GCCTARG)/include";
}
/*
 *  @(#) gnu.targets.arm; 1, 0, 0,0; 11-8-2017 17:20:18; /db/ztree/library/trees/xdctargets/xdctargets-p04/src/ xlibrary

 */

