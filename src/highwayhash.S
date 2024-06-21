
    .text
    .global update_arm64_sve2
    .type update_arm64_sve2, %function

    srcPtr      .req x0
    msgPtr      .req x1
    length      .req x2

update_arm64_sve2:
    ptrue p1.b
    ld1d  z1.d, p1/z, [x0]
    ld1d  z2.d, p1/z, [x0, #1, MUL VL]
    ld1d  z3.d, p1/z, [x0, #2, MUL VL]
    ld1d  z4.d, p1/z, [x0, #3, MUL VL]
    subs  x2, x2, #32
    BMI  .complete_sve2

    adr   x3, .zipper_merge_sve2
    ld1d  z5.d, p1/z, [x3]

.loop_sve2:
    ld1d  z0.d, p1/z, [x1]
    add   x1, x1, #32
    add z2.d, z2.d, z0.d
    add z2.d, z2.d, z3.d
    lsr z0.d, z1.d, #32
    umullb z0.d, z0.s, z2.s
    eor z3.d, z0.d, z3.d
    add z1.d, z4.d, z1.d
    lsr z0.d, z2.d, #32
    umullb z0.d, z0.s, z1.s
    eor z4.d, z0.d, z4.d
    tbl z0.b, z2.b, z5.b
    add z1.d, z1.d, z0.d
    tbl z0.b, z1.b, z5.b
    add z2.d, z2.d, z0.d

    subs x2, x2, #32
    b.pl .loop_sve2

    st1d z1.d, p1, [x0]
    st1d z2.d, p1, [x0, #1, MUL VL]
    st1d z3.d, p1, [x0, #2, MUL VL]
    st1d z4.d, p1, [x0, #3, MUL VL]

.complete_sve2:
    ret

.zipper_merge_sve2:
    .quad 0xf010e05020c03
    .quad 0x70806090d0a040b
    .quad 0x101f111e15121c13
    .quad 0x171816191d1a141b

    .size update_arm64_sve2, .-update_arm64_sve2
