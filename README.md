# [`nix-shell`](https://nixos.org/manual/nix/unstable/command-ref/nix-shell.html) config files for building [seL4](https://sel4.systems/)

## Example

To build [sel4test](https://docs.sel4.systems/projects/sel4test/) and run it in a simulator:
``` bash
# Enter an environment with all the build dependencies (downloading them if necessary)
nix-shell shells/ia32.nix --pure

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
./simulate
```
