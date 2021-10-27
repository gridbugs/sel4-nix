# [`nix-shell`](https://nixos.org/manual/nix/unstable/command-ref/nix-shell.html) config files for building [seL4](https://sel4.systems/)

## Usage

Enter a shell environment with all the dependencies installed for cross-compiling seL4:
```
nix-shell shells/<arch>.nix
```

This may require downloading and compiling the necessary toolchains.

When preparing the build system, pass the `-DCROSS_COMPILER_PREFIX` argument to specify
a custom toolchain prefix to the build system, as the prefixes of the toolchains installed
by nix won't necessarily match what the seL4 build system expects. The toolchain prefix
should be set to the `crossSystem.config` setting at the top of the nix shell config you're using,
followed by a `-` character.

For example for ia32, run:
```
../init-build.sh -DPLATFORM=ia32 -DCROSS_COMPILER_PREFIX=i686-unknown-linux-gnu-
```

For am335x, run:
```
../init-build.sh -DPLATFORM=am335x -DCROSS_COMPILER_PREFIX=arm-none-eabi-
```

## Example

To build [sel4test](https://docs.sel4.systems/projects/sel4test/) and run it in a simulator:
``` bash
# Enter an environment with all the build dependencies (downloading them if necessary)
nix-shell shells/ia32.nix

# Check out the code
mkdir sel4test
cd sel4test
repo init -u https://github.com/seL4/sel4test-manifest.git
repo sync

# Build it
mkdir ia32_build
cd ia32_build
../init-build.sh -DPLATFORM=ia32 -DRELEASE=TRUE -DSIMULATION=TRUE -DCROSS_COMPILER_PREFIX=i686-unknown-linux-gnu-
ninja

# Run it in qemu
./simulate       # to exit qemu, press: C-a x
```
