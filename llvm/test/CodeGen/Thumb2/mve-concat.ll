; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s

define arm_aapcs_vfpcc <4 x i32> @concat_v2i1(i32 %a, i32 %b, <4 x i32> %c) {
; CHECK-LABEL: concat_v2i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r1
; CHECK-NEXT:    vmov.i8 q1, #0x0
; CHECK-NEXT:    vmov.i8 q2, #0xff
; CHECK-NEXT:    vpsel q3, q2, q1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q1, q2, q1
; CHECK-NEXT:    vmov r1, s12
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov q2[2], q2[0], r0, r1
; CHECK-NEXT:    vmov r1, s6
; CHECK-NEXT:    vmov r0, s14
; CHECK-NEXT:    vmov.i32 q1, #0x0
; CHECK-NEXT:    vmov q2[3], q2[1], r1, r0
; CHECK-NEXT:    vcmp.i32 ne, q2, zr
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %ai = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 %a)
  %bi = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 %b)
  %s = shufflevector <2 x i1> %ai, <2 x i1> %bi, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %ci = select <4 x i1> %s, <4 x i32> %c, <4 x i32> zeroinitializer
  ret <4 x i32> %ci
}

declare <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32)


define arm_aapcs_vfpcc <8 x i16> @concat_v4i1(<4 x i32> %a, <4 x i32> %b, <8 x i16> %c) {
; CHECK-LABEL: concat_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9, d10, d11}
; CHECK-NEXT:    vpush {d8, d9, d10, d11}
; CHECK-NEXT:    vmov.i8 q3, #0x0
; CHECK-NEXT:    vmov.i8 q4, #0xff
; CHECK-NEXT:    vcmp.s32 lt, q0, zr
; CHECK-NEXT:    vpsel q5, q4, q3
; CHECK-NEXT:    vcmp.s32 lt, q1, zr
; CHECK-NEXT:    vmov r0, r1, d10
; CHECK-NEXT:    vpsel q1, q4, q3
; CHECK-NEXT:    vmov.16 q0[0], r0
; CHECK-NEXT:    vmov.16 q0[1], r1
; CHECK-NEXT:    vmov r0, r1, d11
; CHECK-NEXT:    vmov.16 q0[2], r0
; CHECK-NEXT:    vmov.16 q0[3], r1
; CHECK-NEXT:    vmov r0, r1, d2
; CHECK-NEXT:    vmov.16 q0[4], r0
; CHECK-NEXT:    vmov.16 q0[5], r1
; CHECK-NEXT:    vmov r0, r1, d3
; CHECK-NEXT:    vmov.16 q0[6], r0
; CHECK-NEXT:    vmov.16 q0[7], r1
; CHECK-NEXT:    vcmp.i16 ne, q0, zr
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    vpsel q0, q2, q0
; CHECK-NEXT:    vpop {d8, d9, d10, d11}
; CHECK-NEXT:    bx lr
entry:
  %ai = icmp slt <4 x i32> %a, zeroinitializer
  %bi = icmp slt <4 x i32> %b, zeroinitializer
  %s = shufflevector <4 x i1> %ai, <4 x i1> %bi, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %ci = select <8 x i1> %s, <8 x i16> %c, <8 x i16> zeroinitializer
  ret <8 x i16> %ci
}

define arm_aapcs_vfpcc <16 x i8> @concat_v8i1(<8 x i16> %a, <8 x i16> %b, <16 x i8> %c) {
; CHECK-LABEL: concat_v8i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9, d10, d11}
; CHECK-NEXT:    vpush {d8, d9, d10, d11}
; CHECK-NEXT:    vmov.i8 q3, #0x0
; CHECK-NEXT:    vmov.i8 q4, #0xff
; CHECK-NEXT:    vcmp.s16 lt, q0, zr
; CHECK-NEXT:    vpsel q5, q4, q3
; CHECK-NEXT:    vcmp.s16 lt, q1, zr
; CHECK-NEXT:    vmov.u16 r0, q5[0]
; CHECK-NEXT:    vpsel q1, q4, q3
; CHECK-NEXT:    vmov.8 q0[0], r0
; CHECK-NEXT:    vmov.u16 r0, q5[1]
; CHECK-NEXT:    vmov.8 q0[1], r0
; CHECK-NEXT:    vmov.u16 r0, q5[2]
; CHECK-NEXT:    vmov.8 q0[2], r0
; CHECK-NEXT:    vmov.u16 r0, q5[3]
; CHECK-NEXT:    vmov.8 q0[3], r0
; CHECK-NEXT:    vmov.u16 r0, q5[4]
; CHECK-NEXT:    vmov.8 q0[4], r0
; CHECK-NEXT:    vmov.u16 r0, q5[5]
; CHECK-NEXT:    vmov.8 q0[5], r0
; CHECK-NEXT:    vmov.u16 r0, q5[6]
; CHECK-NEXT:    vmov.8 q0[6], r0
; CHECK-NEXT:    vmov.u16 r0, q5[7]
; CHECK-NEXT:    vmov.8 q0[7], r0
; CHECK-NEXT:    vmov.u16 r0, q1[0]
; CHECK-NEXT:    vmov.8 q0[8], r0
; CHECK-NEXT:    vmov.u16 r0, q1[1]
; CHECK-NEXT:    vmov.8 q0[9], r0
; CHECK-NEXT:    vmov.u16 r0, q1[2]
; CHECK-NEXT:    vmov.8 q0[10], r0
; CHECK-NEXT:    vmov.u16 r0, q1[3]
; CHECK-NEXT:    vmov.8 q0[11], r0
; CHECK-NEXT:    vmov.u16 r0, q1[4]
; CHECK-NEXT:    vmov.8 q0[12], r0
; CHECK-NEXT:    vmov.u16 r0, q1[5]
; CHECK-NEXT:    vmov.8 q0[13], r0
; CHECK-NEXT:    vmov.u16 r0, q1[6]
; CHECK-NEXT:    vmov.8 q0[14], r0
; CHECK-NEXT:    vmov.u16 r0, q1[7]
; CHECK-NEXT:    vmov.8 q0[15], r0
; CHECK-NEXT:    vcmp.i8 ne, q0, zr
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    vpsel q0, q2, q0
; CHECK-NEXT:    vpop {d8, d9, d10, d11}
; CHECK-NEXT:    bx lr
entry:
  %ai = icmp slt <8 x i16> %a, zeroinitializer
  %bi = icmp slt <8 x i16> %b, zeroinitializer
  %s = shufflevector <8 x i1> %ai, <8 x i1> %bi, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %ci = select <16 x i1> %s, <16 x i8> %c, <16 x i8> zeroinitializer
  ret <16 x i8> %ci
}


define arm_aapcs_vfpcc <16 x i8> @concat_v48i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %d, <4 x i32> %e, <16 x i8> %c) {
; CHECK-LABEL: concat_v48i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9, d10, d11, d12, d13}
; CHECK-NEXT:    vpush {d8, d9, d10, d11, d12, d13}
; CHECK-NEXT:    vmov.i8 q4, #0x0
; CHECK-NEXT:    vmov.i8 q5, #0xff
; CHECK-NEXT:    vcmp.s32 lt, q0, zr
; CHECK-NEXT:    vpsel q6, q5, q4
; CHECK-NEXT:    vcmp.s32 lt, q1, zr
; CHECK-NEXT:    vmov r0, r1, d12
; CHECK-NEXT:    vpsel q1, q5, q4
; CHECK-NEXT:    vmov.16 q0[0], r0
; CHECK-NEXT:    vmov.16 q0[1], r1
; CHECK-NEXT:    vmov r0, r1, d13
; CHECK-NEXT:    vmov.16 q0[2], r0
; CHECK-NEXT:    vmov.16 q0[3], r1
; CHECK-NEXT:    vmov r0, r1, d2
; CHECK-NEXT:    vmov.16 q0[4], r0
; CHECK-NEXT:    vmov.16 q0[5], r1
; CHECK-NEXT:    vmov r0, r1, d3
; CHECK-NEXT:    vmov.16 q0[6], r0
; CHECK-NEXT:    vmov.16 q0[7], r1
; CHECK-NEXT:    vcmp.i16 ne, q0, zr
; CHECK-NEXT:    vpsel q1, q5, q4
; CHECK-NEXT:    vcmp.s32 lt, q2, zr
; CHECK-NEXT:    vmov.u16 r0, q1[0]
; CHECK-NEXT:    vpsel q2, q5, q4
; CHECK-NEXT:    vmov.8 q0[0], r0
; CHECK-NEXT:    vmov.u16 r0, q1[1]
; CHECK-NEXT:    vmov.8 q0[1], r0
; CHECK-NEXT:    vmov.u16 r0, q1[2]
; CHECK-NEXT:    vmov.8 q0[2], r0
; CHECK-NEXT:    vmov.u16 r0, q1[3]
; CHECK-NEXT:    vmov.8 q0[3], r0
; CHECK-NEXT:    vmov.u16 r0, q1[4]
; CHECK-NEXT:    vmov.8 q0[4], r0
; CHECK-NEXT:    vmov.u16 r0, q1[5]
; CHECK-NEXT:    vmov.8 q0[5], r0
; CHECK-NEXT:    vmov.u16 r0, q1[6]
; CHECK-NEXT:    vmov.8 q0[6], r0
; CHECK-NEXT:    vmov.u16 r0, q1[7]
; CHECK-NEXT:    vmov.8 q0[7], r0
; CHECK-NEXT:    vmov r0, r1, d4
; CHECK-NEXT:    vmov.16 q1[0], r0
; CHECK-NEXT:    vcmp.s32 lt, q3, zr
; CHECK-NEXT:    vmov.16 q1[1], r1
; CHECK-NEXT:    vmov r0, r1, d5
; CHECK-NEXT:    vmov.16 q1[2], r0
; CHECK-NEXT:    vpsel q2, q5, q4
; CHECK-NEXT:    vmov.16 q1[3], r1
; CHECK-NEXT:    vmov r0, r1, d4
; CHECK-NEXT:    vmov.16 q1[4], r0
; CHECK-NEXT:    vmov.16 q1[5], r1
; CHECK-NEXT:    vmov r0, r1, d5
; CHECK-NEXT:    vmov.16 q1[6], r0
; CHECK-NEXT:    vmov.16 q1[7], r1
; CHECK-NEXT:    vcmp.i16 ne, q1, zr
; CHECK-NEXT:    vpsel q1, q5, q4
; CHECK-NEXT:    vmov.u16 r0, q1[0]
; CHECK-NEXT:    vmov.8 q0[8], r0
; CHECK-NEXT:    vmov.u16 r0, q1[1]
; CHECK-NEXT:    vmov.8 q0[9], r0
; CHECK-NEXT:    vmov.u16 r0, q1[2]
; CHECK-NEXT:    vmov.8 q0[10], r0
; CHECK-NEXT:    vmov.u16 r0, q1[3]
; CHECK-NEXT:    vmov.8 q0[11], r0
; CHECK-NEXT:    vmov.u16 r0, q1[4]
; CHECK-NEXT:    vmov.8 q0[12], r0
; CHECK-NEXT:    vmov.u16 r0, q1[5]
; CHECK-NEXT:    vmov.8 q0[13], r0
; CHECK-NEXT:    vmov.u16 r0, q1[6]
; CHECK-NEXT:    vmov.8 q0[14], r0
; CHECK-NEXT:    vmov.u16 r0, q1[7]
; CHECK-NEXT:    vmov.8 q0[15], r0
; CHECK-NEXT:    add r0, sp, #48
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vcmp.i8 ne, q0, zr
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    vpop {d8, d9, d10, d11, d12, d13}
; CHECK-NEXT:    bx lr
entry:
  %ai = icmp slt <4 x i32> %a, zeroinitializer
  %bi = icmp slt <4 x i32> %b, zeroinitializer
  %di = icmp slt <4 x i32> %d, zeroinitializer
  %ei = icmp slt <4 x i32> %e, zeroinitializer
  %s1 = shufflevector <4 x i1> %ai, <4 x i1> %bi, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %s2 = shufflevector <4 x i1> %di, <4 x i1> %ei, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %s = shufflevector <8 x i1> %s1, <8 x i1> %s2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %ci = select <16 x i1> %s, <16 x i8> %c, <16 x i8> zeroinitializer
  ret <16 x i8> %ci
}
