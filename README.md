
# Active armie on Graviton 3

```
$ sudo ~/armie/arm-instruction-emulator_22.0_RHEL-8/arm-instruction-emulator_22.0_RHEL-8.sh -a
$ module load armie22/22.0
```

# Build

```
$ COMPILER=gnu make
```

# Run

```
$ armie -msve-vector-bits=256 -- ./build/highwayhash
TEST PASSED
```
