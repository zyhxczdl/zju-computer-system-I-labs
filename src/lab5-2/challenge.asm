
challenge:     file format elf64-littleriscv


Disassembly of section .plt:

0000000000000800 <.plt>:
 800:	00002397          	auipc	t2,0x2
 804:	41c30333          	sub	t1,t1,t3
 808:	7683be03          	ld	t3,1896(t2) # 2f68 <.got>
 80c:	fd430313          	addi	t1,t1,-44
 810:	76838293          	addi	t0,t2,1896
 814:	00135313          	srli	t1,t1,0x1
 818:	0082b283          	ld	t0,8(t0)
 81c:	000e0067          	jr	t3

0000000000000820 <__libc_start_main@plt>:
 820:	00002e17          	auipc	t3,0x2
 824:	758e3e03          	ld	t3,1880(t3) # 2f78 <__libc_start_main@GLIBC_2.34>
 828:	000e0367          	jalr	t1,t3
 82c:	00000013          	nop

0000000000000830 <__isoc99_scanf@plt>:
 830:	00002e17          	auipc	t3,0x2
 834:	750e3e03          	ld	t3,1872(t3) # 2f80 <__isoc99_scanf@GLIBC_2.27>
 838:	000e0367          	jalr	t1,t3
 83c:	00000013          	nop

0000000000000840 <__stack_chk_fail@plt>:
 840:	00002e17          	auipc	t3,0x2
 844:	748e3e03          	ld	t3,1864(t3) # 2f88 <__stack_chk_fail@GLIBC_2.27>
 848:	000e0367          	jalr	t1,t3
 84c:	00000013          	nop

0000000000000850 <readlink@plt>:
 850:	00002e17          	auipc	t3,0x2
 854:	740e3e03          	ld	t3,1856(t3) # 2f90 <readlink@GLIBC_2.27>
 858:	000e0367          	jalr	t1,t3
 85c:	00000013          	nop

0000000000000860 <_exit@plt>:
 860:	00002e17          	auipc	t3,0x2
 864:	738e3e03          	ld	t3,1848(t3) # 2f98 <_exit@GLIBC_2.27>
 868:	000e0367          	jalr	t1,t3
 86c:	00000013          	nop

0000000000000870 <strlen@plt>:
 870:	00002e17          	auipc	t3,0x2
 874:	730e3e03          	ld	t3,1840(t3) # 2fa0 <strlen@GLIBC_2.27>
 878:	000e0367          	jalr	t1,t3
 87c:	00000013          	nop

0000000000000880 <read@plt>:
 880:	00002e17          	auipc	t3,0x2
 884:	728e3e03          	ld	t3,1832(t3) # 2fa8 <read@GLIBC_2.27>
 888:	000e0367          	jalr	t1,t3
 88c:	00000013          	nop

0000000000000890 <close@plt>:
 890:	00002e17          	auipc	t3,0x2
 894:	720e3e03          	ld	t3,1824(t3) # 2fb0 <close@GLIBC_2.27>
 898:	000e0367          	jalr	t1,t3
 89c:	00000013          	nop

00000000000008a0 <puts@plt>:
 8a0:	00002e17          	auipc	t3,0x2
 8a4:	718e3e03          	ld	t3,1816(t3) # 2fb8 <puts@GLIBC_2.27>
 8a8:	000e0367          	jalr	t1,t3
 8ac:	00000013          	nop

00000000000008b0 <open@plt>:
 8b0:	00002e17          	auipc	t3,0x2
 8b4:	710e3e03          	ld	t3,1808(t3) # 2fc0 <open@GLIBC_2.27>
 8b8:	000e0367          	jalr	t1,t3
 8bc:	00000013          	nop

00000000000008c0 <printf@plt>:
 8c0:	00002e17          	auipc	t3,0x2
 8c4:	708e3e03          	ld	t3,1800(t3) # 2fc8 <printf@GLIBC_2.27>
 8c8:	000e0367          	jalr	t1,t3
 8cc:	00000013          	nop

Disassembly of section .text:

00000000000008d0 <_start>:
     8d0:	022000ef          	jal	8f2 <load_gp>
     8d4:	87aa                	mv	a5,a0
     8d6:	00002517          	auipc	a0,0x2
     8da:	71253503          	ld	a0,1810(a0) # 2fe8 <_GLOBAL_OFFSET_TABLE_+0x18>
     8de:	6582                	ld	a1,0(sp)
     8e0:	0030                	addi	a2,sp,8
     8e2:	ff017113          	andi	sp,sp,-16
     8e6:	4681                	li	a3,0
     8e8:	4701                	li	a4,0
     8ea:	880a                	mv	a6,sp
     8ec:	f35ff0ef          	jal	820 <__libc_start_main@plt>
     8f0:	9002                	ebreak

00000000000008f2 <load_gp>:
     8f2:	00003197          	auipc	gp,0x3
     8f6:	f0e18193          	addi	gp,gp,-242 # 3800 <__global_pointer$>
     8fa:	8082                	ret
	...

00000000000008fe <deregister_tm_clones>:
     8fe:	1141                	addi	sp,sp,-16
     900:	e422                	sd	s0,8(sp)
     902:	0800                	addi	s0,sp,16
     904:	00002517          	auipc	a0,0x2
     908:	74450513          	addi	a0,a0,1860 # 3048 <__TMC_END__>
     90c:	00002797          	auipc	a5,0x2
     910:	73c78793          	addi	a5,a5,1852 # 3048 <__TMC_END__>
     914:	00a78a63          	beq	a5,a0,928 <deregister_tm_clones+0x2a>
     918:	00002797          	auipc	a5,0x2
     91c:	6c07b783          	ld	a5,1728(a5) # 2fd8 <_ITM_deregisterTMCloneTable@Base>
     920:	c781                	beqz	a5,928 <deregister_tm_clones+0x2a>
     922:	6422                	ld	s0,8(sp)
     924:	0141                	addi	sp,sp,16
     926:	8782                	jr	a5
     928:	6422                	ld	s0,8(sp)
     92a:	0141                	addi	sp,sp,16
     92c:	8082                	ret

000000000000092e <register_tm_clones>:
     92e:	00002517          	auipc	a0,0x2
     932:	71a50513          	addi	a0,a0,1818 # 3048 <__TMC_END__>
     936:	00002597          	auipc	a1,0x2
     93a:	71258593          	addi	a1,a1,1810 # 3048 <__TMC_END__>
     93e:	8d89                	sub	a1,a1,a0
     940:	1141                	addi	sp,sp,-16
     942:	4035d793          	srai	a5,a1,0x3
     946:	91fd                	srli	a1,a1,0x3f
     948:	e422                	sd	s0,8(sp)
     94a:	95be                	add	a1,a1,a5
     94c:	0800                	addi	s0,sp,16
     94e:	8585                	srai	a1,a1,0x1
     950:	c989                	beqz	a1,962 <register_tm_clones+0x34>
     952:	00002797          	auipc	a5,0x2
     956:	6a67b783          	ld	a5,1702(a5) # 2ff8 <_ITM_registerTMCloneTable@Base>
     95a:	c781                	beqz	a5,962 <register_tm_clones+0x34>
     95c:	6422                	ld	s0,8(sp)
     95e:	0141                	addi	sp,sp,16
     960:	8782                	jr	a5
     962:	6422                	ld	s0,8(sp)
     964:	0141                	addi	sp,sp,16
     966:	8082                	ret

0000000000000968 <__do_global_dtors_aux>:
     968:	1101                	addi	sp,sp,-32
     96a:	e822                	sd	s0,16(sp)
     96c:	e426                	sd	s1,8(sp)
     96e:	ec06                	sd	ra,24(sp)
     970:	1000                	addi	s0,sp,32
     972:	00002497          	auipc	s1,0x2
     976:	6d648493          	addi	s1,s1,1750 # 3048 <__TMC_END__>
     97a:	0004c783          	lbu	a5,0(s1)
     97e:	e385                	bnez	a5,99e <__do_global_dtors_aux+0x36>
     980:	00002797          	auipc	a5,0x2
     984:	6707b783          	ld	a5,1648(a5) # 2ff0 <__cxa_finalize@GLIBC_2.27>
     988:	c791                	beqz	a5,994 <__do_global_dtors_aux+0x2c>
     98a:	00002517          	auipc	a0,0x2
     98e:	67653503          	ld	a0,1654(a0) # 3000 <__dso_handle>
     992:	9782                	jalr	a5
     994:	f6bff0ef          	jal	8fe <deregister_tm_clones>
     998:	4785                	li	a5,1
     99a:	00f48023          	sb	a5,0(s1)
     99e:	60e2                	ld	ra,24(sp)
     9a0:	6442                	ld	s0,16(sp)
     9a2:	64a2                	ld	s1,8(sp)
     9a4:	6105                	addi	sp,sp,32
     9a6:	8082                	ret

00000000000009a8 <frame_dummy>:
     9a8:	1141                	addi	sp,sp,-16
     9aa:	e422                	sd	s0,8(sp)
     9ac:	0800                	addi	s0,sp,16
     9ae:	6422                	ld	s0,8(sp)
     9b0:	0141                	addi	sp,sp,16
     9b2:	bfb5                	j	92e <register_tm_clones>

00000000000009b4 <char2num>:
     9b4:	1101                	addi	sp,sp,-32
     9b6:	ec22                	sd	s0,24(sp)
     9b8:	1000                	addi	s0,sp,32
     9ba:	87aa                	mv	a5,a0
     9bc:	fef42623          	sw	a5,-20(s0)
     9c0:	fec42783          	lw	a5,-20(s0)
     9c4:	0007871b          	sext.w	a4,a5
     9c8:	02f00793          	li	a5,47
     9cc:	02e7d063          	bge	a5,a4,9ec <char2num+0x38>
     9d0:	fec42783          	lw	a5,-20(s0)
     9d4:	0007871b          	sext.w	a4,a5
     9d8:	03900793          	li	a5,57
     9dc:	00e7c863          	blt	a5,a4,9ec <char2num+0x38>
     9e0:	fec42783          	lw	a5,-20(s0)
     9e4:	fd07879b          	addiw	a5,a5,-48
     9e8:	2781                	sext.w	a5,a5
     9ea:	a805                	j	a1a <char2num+0x66>
     9ec:	fec42783          	lw	a5,-20(s0)
     9f0:	0007871b          	sext.w	a4,a5
     9f4:	06000793          	li	a5,96
     9f8:	02e7d063          	bge	a5,a4,a18 <char2num+0x64>
     9fc:	fec42783          	lw	a5,-20(s0)
     a00:	0007871b          	sext.w	a4,a5
     a04:	06600793          	li	a5,102
     a08:	00e7c863          	blt	a5,a4,a18 <char2num+0x64>
     a0c:	fec42783          	lw	a5,-20(s0)
     a10:	fa97879b          	addiw	a5,a5,-87
     a14:	2781                	sext.w	a5,a5
     a16:	a011                	j	a1a <char2num+0x66>
     a18:	57fd                	li	a5,-1
     a1a:	853e                	mv	a0,a5
     a1c:	6462                	ld	s0,24(sp)
     a1e:	6105                	addi	sp,sp,32
     a20:	8082                	ret

0000000000000a22 <binary_hash_key>:
     a22:	db010113          	addi	sp,sp,-592
     a26:	24113423          	sd	ra,584(sp)
     a2a:	24813023          	sd	s0,576(sp)
     a2e:	22913c23          	sd	s1,568(sp)
     a32:	0c80                	addi	s0,sp,592
     a34:	72fd                	lui	t0,0xfffff
     a36:	9116                	add	sp,sp,t0
     a38:	00002797          	auipc	a5,0x2
     a3c:	5a87b783          	ld	a5,1448(a5) # 2fe0 <__stack_chk_guard@GLIBC_2.27>
     a40:	6398                	ld	a4,0(a5)
     a42:	fce43c23          	sd	a4,-40(s0)
     a46:	4701                	li	a4,0
     a48:	77fd                	lui	a5,0xfffff
     a4a:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     a4c:	008784b3          	add	s1,a5,s0
     a50:	77fd                	lui	a5,0xfffff
     a52:	df878793          	addi	a5,a5,-520 # ffffffffffffedf8 <__global_pointer$+0xffffffffffffb5f8>
     a56:	1781                	addi	a5,a5,-32
     a58:	97a2                	add	a5,a5,s0
     a5a:	1ff00613          	li	a2,511
     a5e:	85be                	mv	a1,a5
     a60:	00001517          	auipc	a0,0x1
     a64:	86850513          	addi	a0,a0,-1944 # 12c8 <_IO_stdin_used+0x8>
     a68:	de9ff0ef          	jal	850 <readlink@plt>
     a6c:	dea4b423          	sd	a0,-536(s1)
     a70:	77fd                	lui	a5,0xfffff
     a72:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     a74:	97a2                	add	a5,a5,s0
     a76:	de87b783          	ld	a5,-536(a5)
     a7a:	00f04b63          	bgtz	a5,a90 <binary_hash_key+0x6e>
     a7e:	00001517          	auipc	a0,0x1
     a82:	85a50513          	addi	a0,a0,-1958 # 12d8 <_IO_stdin_used+0x18>
     a86:	e1bff0ef          	jal	8a0 <puts@plt>
     a8a:	557d                	li	a0,-1
     a8c:	dd5ff0ef          	jal	860 <_exit@plt>
     a90:	77fd                	lui	a5,0xfffff
     a92:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     a94:	00878733          	add	a4,a5,s0
     a98:	77fd                	lui	a5,0xfffff
     a9a:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     a9c:	97a2                	add	a5,a5,s0
     a9e:	de87b783          	ld	a5,-536(a5)
     aa2:	97ba                	add	a5,a5,a4
     aa4:	de078c23          	sb	zero,-520(a5)
     aa8:	77fd                	lui	a5,0xfffff
     aaa:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     aac:	008784b3          	add	s1,a5,s0
     ab0:	77fd                	lui	a5,0xfffff
     ab2:	df878793          	addi	a5,a5,-520 # ffffffffffffedf8 <__global_pointer$+0xffffffffffffb5f8>
     ab6:	1781                	addi	a5,a5,-32
     ab8:	97a2                	add	a5,a5,s0
     aba:	4581                	li	a1,0
     abc:	853e                	mv	a0,a5
     abe:	df3ff0ef          	jal	8b0 <open@plt>
     ac2:	87aa                	mv	a5,a0
     ac4:	dcf4ae23          	sw	a5,-548(s1)
     ac8:	77fd                	lui	a5,0xfffff
     aca:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     acc:	97a2                	add	a5,a5,s0
     ace:	ddc7a783          	lw	a5,-548(a5)
     ad2:	2781                	sext.w	a5,a5
     ad4:	0007db63          	bgez	a5,aea <binary_hash_key+0xc8>
     ad8:	00001517          	auipc	a0,0x1
     adc:	83050513          	addi	a0,a0,-2000 # 1308 <_IO_stdin_used+0x48>
     ae0:	dc1ff0ef          	jal	8a0 <puts@plt>
     ae4:	557d                	li	a0,-1
     ae6:	d7bff0ef          	jal	860 <_exit@plt>
     aea:	77fd                	lui	a5,0xfffff
     aec:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     aee:	97a2                	add	a5,a5,s0
     af0:	811ca737          	lui	a4,0x811ca
     af4:	dc570713          	addi	a4,a4,-571 # ffffffff811c9dc5 <__global_pointer$+0xffffffff811c65c5>
     af8:	dce7ac23          	sw	a4,-552(a5)
     afc:	77fd                	lui	a5,0xfffff
     afe:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b00:	008784b3          	add	s1,a5,s0
     b04:	77fd                	lui	a5,0xfffff
     b06:	17e1                	addi	a5,a5,-8 # ffffffffffffeff8 <__global_pointer$+0xffffffffffffb7f8>
     b08:	1781                	addi	a5,a5,-32
     b0a:	00878733          	add	a4,a5,s0
     b0e:	77fd                	lui	a5,0xfffff
     b10:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b12:	97a2                	add	a5,a5,s0
     b14:	ddc7a783          	lw	a5,-548(a5)
     b18:	6605                	lui	a2,0x1
     b1a:	85ba                	mv	a1,a4
     b1c:	853e                	mv	a0,a5
     b1e:	d63ff0ef          	jal	880 <read@plt>
     b22:	dea4b823          	sd	a0,-528(s1)
     b26:	77fd                	lui	a5,0xfffff
     b28:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b2a:	97a2                	add	a5,a5,s0
     b2c:	df07b783          	ld	a5,-528(a5)
     b30:	c7e1                	beqz	a5,bf8 <binary_hash_key+0x1d6>
     b32:	77fd                	lui	a5,0xfffff
     b34:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b36:	97a2                	add	a5,a5,s0
     b38:	df07b783          	ld	a5,-528(a5)
     b3c:	0207d363          	bgez	a5,b62 <binary_hash_key+0x140>
     b40:	77fd                	lui	a5,0xfffff
     b42:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b44:	97a2                	add	a5,a5,s0
     b46:	ddc7a783          	lw	a5,-548(a5)
     b4a:	853e                	mv	a0,a5
     b4c:	d45ff0ef          	jal	890 <close@plt>
     b50:	00000517          	auipc	a0,0x0
     b54:	7e050513          	addi	a0,a0,2016 # 1330 <_IO_stdin_used+0x70>
     b58:	d49ff0ef          	jal	8a0 <puts@plt>
     b5c:	557d                	li	a0,-1
     b5e:	d03ff0ef          	jal	860 <_exit@plt>
     b62:	77fd                	lui	a5,0xfffff
     b64:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b66:	97a2                	add	a5,a5,s0
     b68:	de07b023          	sd	zero,-544(a5)
     b6c:	a885                	j	bdc <binary_hash_key+0x1ba>
     b6e:	77fd                	lui	a5,0xfffff
     b70:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b72:	00878733          	add	a4,a5,s0
     b76:	77fd                	lui	a5,0xfffff
     b78:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b7a:	97a2                	add	a5,a5,s0
     b7c:	de07b783          	ld	a5,-544(a5)
     b80:	97ba                	add	a5,a5,a4
     b82:	ff87c783          	lbu	a5,-8(a5)
     b86:	0007861b          	sext.w	a2,a5
     b8a:	77fd                	lui	a5,0xfffff
     b8c:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b8e:	97a2                	add	a5,a5,s0
     b90:	777d                	lui	a4,0xfffff
     b92:	1701                	addi	a4,a4,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     b94:	9722                	add	a4,a4,s0
     b96:	dd872703          	lw	a4,-552(a4)
     b9a:	86ba                	mv	a3,a4
     b9c:	8732                	mv	a4,a2
     b9e:	8f35                	xor	a4,a4,a3
     ba0:	dce7ac23          	sw	a4,-552(a5)
     ba4:	77fd                	lui	a5,0xfffff
     ba6:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     ba8:	97a2                	add	a5,a5,s0
     baa:	777d                	lui	a4,0xfffff
     bac:	1701                	addi	a4,a4,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     bae:	9722                	add	a4,a4,s0
     bb0:	dd872703          	lw	a4,-552(a4)
     bb4:	86ba                	mv	a3,a4
     bb6:	01000737          	lui	a4,0x1000
     bba:	1937071b          	addiw	a4,a4,403 # 1000193 <__global_pointer$+0xffc993>
     bbe:	02e6873b          	mulw	a4,a3,a4
     bc2:	dce7ac23          	sw	a4,-552(a5)
     bc6:	77fd                	lui	a5,0xfffff
     bc8:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     bca:	97a2                	add	a5,a5,s0
     bcc:	777d                	lui	a4,0xfffff
     bce:	1701                	addi	a4,a4,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     bd0:	9722                	add	a4,a4,s0
     bd2:	de073703          	ld	a4,-544(a4)
     bd6:	0705                	addi	a4,a4,1
     bd8:	dee7b023          	sd	a4,-544(a5)
     bdc:	77fd                	lui	a5,0xfffff
     bde:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     be0:	00878733          	add	a4,a5,s0
     be4:	77fd                	lui	a5,0xfffff
     be6:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     be8:	97a2                	add	a5,a5,s0
     bea:	de073703          	ld	a4,-544(a4)
     bee:	df07b783          	ld	a5,-528(a5)
     bf2:	f6f74ee3          	blt	a4,a5,b6e <binary_hash_key+0x14c>
     bf6:	b719                	j	afc <binary_hash_key+0xda>
     bf8:	0001                	nop
     bfa:	77fd                	lui	a5,0xfffff
     bfc:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     bfe:	97a2                	add	a5,a5,s0
     c00:	ddc7a783          	lw	a5,-548(a5)
     c04:	853e                	mv	a0,a5
     c06:	c8bff0ef          	jal	890 <close@plt>
     c0a:	77fd                	lui	a5,0xfffff
     c0c:	1781                	addi	a5,a5,-32 # ffffffffffffefe0 <__global_pointer$+0xffffffffffffb7e0>
     c0e:	97a2                	add	a5,a5,s0
     c10:	dd87a783          	lw	a5,-552(a5)
     c14:	873e                	mv	a4,a5
     c16:	00002797          	auipc	a5,0x2
     c1a:	3ca7b783          	ld	a5,970(a5) # 2fe0 <__stack_chk_guard@GLIBC_2.27>
     c1e:	fd843683          	ld	a3,-40(s0)
     c22:	639c                	ld	a5,0(a5)
     c24:	8fb5                	xor	a5,a5,a3
     c26:	4681                	li	a3,0
     c28:	c399                	beqz	a5,c2e <binary_hash_key+0x20c>
     c2a:	c17ff0ef          	jal	840 <__stack_chk_fail@plt>
     c2e:	853a                	mv	a0,a4
     c30:	6285                	lui	t0,0x1
     c32:	9116                	add	sp,sp,t0
     c34:	24813083          	ld	ra,584(sp)
     c38:	24013403          	ld	s0,576(sp)
     c3c:	23813483          	ld	s1,568(sp)
     c40:	25010113          	addi	sp,sp,592
     c44:	8082                	ret

0000000000000c46 <phase_1>:
     c46:	7179                	addi	sp,sp,-48
     c48:	f406                	sd	ra,40(sp)
     c4a:	f022                	sd	s0,32(sp)
     c4c:	1800                	addi	s0,sp,48
     c4e:	fca43c23          	sd	a0,-40(s0)
     c52:	00002797          	auipc	a5,0x2
     c56:	46678793          	addi	a5,a5,1126 # 30b8 <name_buffer>
     c5a:	0067c783          	lbu	a5,6(a5)
     c5e:	2781                	sext.w	a5,a5
     c60:	853e                	mv	a0,a5
     c62:	d53ff0ef          	jal	9b4 <char2num>
     c66:	87aa                	mv	a5,a0
     c68:	fef42223          	sw	a5,-28(s0)
     c6c:	47d1                	li	a5,20
     c6e:	fef42423          	sw	a5,-24(s0)
     c72:	a8b9                	j	cd0 <phase_1+0x8a>
     c74:	00002717          	auipc	a4,0x2
     c78:	39470713          	addi	a4,a4,916 # 3008 <phase_box>
     c7c:	fe442783          	lw	a5,-28(s0)
     c80:	078a                	slli	a5,a5,0x2
     c82:	97ba                	add	a5,a5,a4
     c84:	4398                	lw	a4,0(a5)
     c86:	fe442783          	lw	a5,-28(s0)
     c8a:	278d                	addiw	a5,a5,3
     c8c:	2781                	sext.w	a5,a5
     c8e:	8bbd                	andi	a5,a5,15
     c90:	2781                	sext.w	a5,a5
     c92:	00002697          	auipc	a3,0x2
     c96:	37668693          	addi	a3,a3,886 # 3008 <phase_box>
     c9a:	078a                	slli	a5,a5,0x2
     c9c:	97b6                	add	a5,a5,a3
     c9e:	439c                	lw	a5,0(a5)
     ca0:	8fb9                	xor	a5,a5,a4
     ca2:	0007871b          	sext.w	a4,a5
     ca6:	00002697          	auipc	a3,0x2
     caa:	36268693          	addi	a3,a3,866 # 3008 <phase_box>
     cae:	fe442783          	lw	a5,-28(s0)
     cb2:	078a                	slli	a5,a5,0x2
     cb4:	97b6                	add	a5,a5,a3
     cb6:	439c                	lw	a5,0(a5)
     cb8:	00002697          	auipc	a3,0x2
     cbc:	35068693          	addi	a3,a3,848 # 3008 <phase_box>
     cc0:	078a                	slli	a5,a5,0x2
     cc2:	97b6                	add	a5,a5,a3
     cc4:	439c                	lw	a5,0(a5)
     cc6:	8fb9                	xor	a5,a5,a4
     cc8:	2781                	sext.w	a5,a5
     cca:	8bbd                	andi	a5,a5,15
     ccc:	fef42223          	sw	a5,-28(s0)
     cd0:	fe842783          	lw	a5,-24(s0)
     cd4:	fff7871b          	addiw	a4,a5,-1
     cd8:	fee42423          	sw	a4,-24(s0)
     cdc:	ffc1                	bnez	a5,c74 <phase_1+0x2e>
     cde:	4785                	li	a5,1
     ce0:	fef42623          	sw	a5,-20(s0)
     ce4:	a805                	j	d14 <phase_1+0xce>
     ce6:	fd843783          	ld	a5,-40(s0)
     cea:	0007c783          	lbu	a5,0(a5)
     cee:	2781                	sext.w	a5,a5
     cf0:	853e                	mv	a0,a5
     cf2:	cc3ff0ef          	jal	9b4 <char2num>
     cf6:	87aa                	mv	a5,a0
     cf8:	873e                	mv	a4,a5
     cfa:	fe442783          	lw	a5,-28(s0)
     cfe:	2781                	sext.w	a5,a5
     d00:	00e79563          	bne	a5,a4,d0a <phase_1+0xc4>
     d04:	fe042623          	sw	zero,-20(s0)
     d08:	a819                	j	d1e <phase_1+0xd8>
     d0a:	fd843783          	ld	a5,-40(s0)
     d0e:	0785                	addi	a5,a5,1
     d10:	fcf43c23          	sd	a5,-40(s0)
     d14:	fd843783          	ld	a5,-40(s0)
     d18:	0007c783          	lbu	a5,0(a5)
     d1c:	f7e9                	bnez	a5,ce6 <phase_1+0xa0>
     d1e:	fec42783          	lw	a5,-20(s0)
     d22:	853e                	mv	a0,a5
     d24:	70a2                	ld	ra,40(sp)
     d26:	7402                	ld	s0,32(sp)
     d28:	6145                	addi	sp,sp,48
     d2a:	8082                	ret

0000000000000d2c <phase_2>:
     d2c:	7139                	addi	sp,sp,-64
     d2e:	fc06                	sd	ra,56(sp)
     d30:	f822                	sd	s0,48(sp)
     d32:	f426                	sd	s1,40(sp)
     d34:	0080                	addi	s0,sp,64
     d36:	fca43423          	sd	a0,-56(s0)
     d3a:	00002797          	auipc	a5,0x2
     d3e:	37e78793          	addi	a5,a5,894 # 30b8 <name_buffer>
     d42:	0067c783          	lbu	a5,6(a5)
     d46:	2781                	sext.w	a5,a5
     d48:	853e                	mv	a0,a5
     d4a:	c6bff0ef          	jal	9b4 <char2num>
     d4e:	87aa                	mv	a5,a0
     d50:	84be                	mv	s1,a5
     d52:	00002797          	auipc	a5,0x2
     d56:	36678793          	addi	a5,a5,870 # 30b8 <name_buffer>
     d5a:	0077c783          	lbu	a5,7(a5)
     d5e:	2781                	sext.w	a5,a5
     d60:	853e                	mv	a0,a5
     d62:	c53ff0ef          	jal	9b4 <char2num>
     d66:	87aa                	mv	a5,a0
     d68:	8fa5                	xor	a5,a5,s1
     d6a:	0007849b          	sext.w	s1,a5
     d6e:	00002797          	auipc	a5,0x2
     d72:	34a78793          	addi	a5,a5,842 # 30b8 <name_buffer>
     d76:	0087c783          	lbu	a5,8(a5)
     d7a:	2781                	sext.w	a5,a5
     d7c:	853e                	mv	a0,a5
     d7e:	c37ff0ef          	jal	9b4 <char2num>
     d82:	87aa                	mv	a5,a0
     d84:	8fa5                	xor	a5,a5,s1
     d86:	0007849b          	sext.w	s1,a5
     d8a:	00002797          	auipc	a5,0x2
     d8e:	32e78793          	addi	a5,a5,814 # 30b8 <name_buffer>
     d92:	0097c783          	lbu	a5,9(a5)
     d96:	2781                	sext.w	a5,a5
     d98:	853e                	mv	a0,a5
     d9a:	c1bff0ef          	jal	9b4 <char2num>
     d9e:	87aa                	mv	a5,a0
     da0:	8fa5                	xor	a5,a5,s1
     da2:	fcf42c23          	sw	a5,-40(s0)
     da6:	4785                	li	a5,1
     da8:	fcf42e23          	sw	a5,-36(s0)
     dac:	fd842783          	lw	a5,-40(s0)
     db0:	873e                	mv	a4,a5
     db2:	fc843783          	ld	a5,-56(s0)
     db6:	82ba                	mv	t0,a4
     db8:	833e                	mv	t1,a5
     dba:	a021                	j	dc2 <phase_2_L1>

0000000000000dbc <phase_2_L2>:
     dbc:	0072c2b3          	xor	t0,t0,t2
     dc0:	0305                	addi	t1,t1,1

0000000000000dc2 <phase_2_L1>:
     dc2:	00034383          	lbu	t2,0(t1)
     dc6:	fe039be3          	bnez	t2,dbc <phase_2_L2>
     dca:	00029463          	bnez	t0,dd2 <phase_2_L3>
     dce:	00000793          	li	a5,0

0000000000000dd2 <phase_2_L3>:
     dd2:	0001                	nop
     dd4:	fcf42e23          	sw	a5,-36(s0)
     dd8:	fdc42783          	lw	a5,-36(s0)
     ddc:	853e                	mv	a0,a5
     dde:	70e2                	ld	ra,56(sp)
     de0:	7442                	ld	s0,48(sp)
     de2:	74a2                	ld	s1,40(sp)
     de4:	6121                	addi	sp,sp,64
     de6:	8082                	ret

0000000000000de8 <phase_3>:
     de8:	7159                	addi	sp,sp,-112
     dea:	f486                	sd	ra,104(sp)
     dec:	f0a2                	sd	s0,96(sp)
     dee:	1880                	addi	s0,sp,112
     df0:	f8a43c23          	sd	a0,-104(s0)
     df4:	00002797          	auipc	a5,0x2
     df8:	1ec7b783          	ld	a5,492(a5) # 2fe0 <__stack_chk_guard@GLIBC_2.27>
     dfc:	6398                	ld	a4,0(a5)
     dfe:	fee43423          	sd	a4,-24(s0)
     e02:	4701                	li	a4,0
     e04:	f9843503          	ld	a0,-104(s0)
     e08:	a69ff0ef          	jal	870 <strlen@plt>
     e0c:	872a                	mv	a4,a0
     e0e:	47a1                	li	a5,8
     e10:	00f70463          	beq	a4,a5,e18 <phase_3+0x30>
     e14:	4785                	li	a5,1
     e16:	acdd                	j	110c <phase_3+0x324>
     e18:	fa042023          	sw	zero,-96(s0)
     e1c:	a035                	j	e48 <phase_3+0x60>
     e1e:	fa042783          	lw	a5,-96(s0)
     e22:	f9843703          	ld	a4,-104(s0)
     e26:	97ba                	add	a5,a5,a4
     e28:	0007c783          	lbu	a5,0(a5)
     e2c:	2781                	sext.w	a5,a5
     e2e:	853e                	mv	a0,a5
     e30:	b85ff0ef          	jal	9b4 <char2num>
     e34:	87aa                	mv	a5,a0
     e36:	0007d463          	bgez	a5,e3e <phase_3+0x56>
     e3a:	4785                	li	a5,1
     e3c:	acc1                	j	110c <phase_3+0x324>
     e3e:	fa042783          	lw	a5,-96(s0)
     e42:	2785                	addiw	a5,a5,1
     e44:	faf42023          	sw	a5,-96(s0)
     e48:	fa042783          	lw	a5,-96(s0)
     e4c:	0007871b          	sext.w	a4,a5
     e50:	479d                	li	a5,7
     e52:	fce7d6e3          	bge	a5,a4,e1e <phase_3+0x36>
     e56:	00002797          	auipc	a5,0x2
     e5a:	26278793          	addi	a5,a5,610 # 30b8 <name_buffer>
     e5e:	0067c783          	lbu	a5,6(a5)
     e62:	2781                	sext.w	a5,a5
     e64:	853e                	mv	a0,a5
     e66:	b4fff0ef          	jal	9b4 <char2num>
     e6a:	87aa                	mv	a5,a0
     e6c:	faf42823          	sw	a5,-80(s0)
     e70:	00002797          	auipc	a5,0x2
     e74:	24878793          	addi	a5,a5,584 # 30b8 <name_buffer>
     e78:	0077c783          	lbu	a5,7(a5)
     e7c:	2781                	sext.w	a5,a5
     e7e:	853e                	mv	a0,a5
     e80:	b35ff0ef          	jal	9b4 <char2num>
     e84:	87aa                	mv	a5,a0
     e86:	faf42a23          	sw	a5,-76(s0)
     e8a:	00002797          	auipc	a5,0x2
     e8e:	22e78793          	addi	a5,a5,558 # 30b8 <name_buffer>
     e92:	0087c783          	lbu	a5,8(a5)
     e96:	2781                	sext.w	a5,a5
     e98:	853e                	mv	a0,a5
     e9a:	b1bff0ef          	jal	9b4 <char2num>
     e9e:	87aa                	mv	a5,a0
     ea0:	faf42c23          	sw	a5,-72(s0)
     ea4:	00002797          	auipc	a5,0x2
     ea8:	21478793          	addi	a5,a5,532 # 30b8 <name_buffer>
     eac:	0097c783          	lbu	a5,9(a5)
     eb0:	2781                	sext.w	a5,a5
     eb2:	853e                	mv	a0,a5
     eb4:	b01ff0ef          	jal	9b4 <char2num>
     eb8:	87aa                	mv	a5,a0
     eba:	faf42e23          	sw	a5,-68(s0)
     ebe:	fb042783          	lw	a5,-80(s0)
     ec2:	00c7979b          	slliw	a5,a5,0xc
     ec6:	0007871b          	sext.w	a4,a5
     eca:	fb442783          	lw	a5,-76(s0)
     ece:	0087979b          	slliw	a5,a5,0x8
     ed2:	2781                	sext.w	a5,a5
     ed4:	8fd9                	or	a5,a5,a4
     ed6:	0007871b          	sext.w	a4,a5
     eda:	fb842783          	lw	a5,-72(s0)
     ede:	0047979b          	slliw	a5,a5,0x4
     ee2:	2781                	sext.w	a5,a5
     ee4:	8fd9                	or	a5,a5,a4
     ee6:	0007871b          	sext.w	a4,a5
     eea:	fbc42783          	lw	a5,-68(s0)
     eee:	8fd9                	or	a5,a5,a4
     ef0:	faf42223          	sw	a5,-92(s0)
     ef4:	fa442783          	lw	a5,-92(s0)
     ef8:	873e                	mv	a4,a5
     efa:	1357a7b7          	lui	a5,0x1357a
     efe:	bdf78793          	addi	a5,a5,-1057 # 13579bdf <__global_pointer$+0x135763df>
     f02:	8fb9                	xor	a5,a5,a4
     f04:	faf42223          	sw	a5,-92(s0)
     f08:	b1bff0ef          	jal	a22 <binary_hash_key>
     f0c:	87aa                	mv	a5,a0
     f0e:	fcf42023          	sw	a5,-64(s0)
     f12:	fa442783          	lw	a5,-92(s0)
     f16:	873e                	mv	a4,a5
     f18:	fc042783          	lw	a5,-64(s0)
     f1c:	8fb9                	xor	a5,a5,a4
     f1e:	faf42223          	sw	a5,-92(s0)
     f22:	fc042783          	lw	a5,-64(s0)
     f26:	00b7971b          	slliw	a4,a5,0xb
     f2a:	0157d79b          	srliw	a5,a5,0x15
     f2e:	8fd9                	or	a5,a5,a4
     f30:	2781                	sext.w	a5,a5
     f32:	fa442703          	lw	a4,-92(s0)
     f36:	8fb9                	xor	a5,a5,a4
     f38:	faf42223          	sw	a5,-92(s0)
     f3c:	fa042423          	sw	zero,-88(s0)
     f40:	a8b5                	j	fbc <phase_3+0x1d4>
     f42:	fa442783          	lw	a5,-92(s0)
     f46:	0037971b          	slliw	a4,a5,0x3
     f4a:	01d7d79b          	srliw	a5,a5,0x1d
     f4e:	8fd9                	or	a5,a5,a4
     f50:	faf42223          	sw	a5,-92(s0)
     f54:	fa842703          	lw	a4,-88(s0)
     f58:	111117b7          	lui	a5,0x11111
     f5c:	1117879b          	addiw	a5,a5,273 # 11111111 <__global_pointer$+0x1110d911>
     f60:	02f707bb          	mulw	a5,a4,a5
     f64:	0007871b          	sext.w	a4,a5
     f68:	9e3787b7          	lui	a5,0x9e378
     f6c:	9b97879b          	addiw	a5,a5,-1607 # ffffffff9e3779b9 <__global_pointer$+0xffffffff9e3741b9>
     f70:	9fb9                	addw	a5,a5,a4
     f72:	2781                	sext.w	a5,a5
     f74:	fa442703          	lw	a4,-92(s0)
     f78:	8fb9                	xor	a5,a5,a4
     f7a:	faf42223          	sw	a5,-92(s0)
     f7e:	fa842783          	lw	a5,-88(s0)
     f82:	8bbd                	andi	a5,a5,15
     f84:	2781                	sext.w	a5,a5
     f86:	fa442703          	lw	a4,-92(s0)
     f8a:	00f757bb          	srlw	a5,a4,a5
     f8e:	2781                	sext.w	a5,a5
     f90:	8bbd                	andi	a5,a5,15
     f92:	2781                	sext.w	a5,a5
     f94:	00002717          	auipc	a4,0x2
     f98:	07470713          	addi	a4,a4,116 # 3008 <phase_box>
     f9c:	1782                	slli	a5,a5,0x20
     f9e:	9381                	srli	a5,a5,0x20
     fa0:	078a                	slli	a5,a5,0x2
     fa2:	97ba                	add	a5,a5,a4
     fa4:	439c                	lw	a5,0(a5)
     fa6:	2781                	sext.w	a5,a5
     fa8:	fa442703          	lw	a4,-92(s0)
     fac:	8fb9                	xor	a5,a5,a4
     fae:	faf42223          	sw	a5,-92(s0)
     fb2:	fa842783          	lw	a5,-88(s0)
     fb6:	2785                	addiw	a5,a5,1
     fb8:	faf42423          	sw	a5,-88(s0)
     fbc:	fa842783          	lw	a5,-88(s0)
     fc0:	0007871b          	sext.w	a4,a5
     fc4:	47bd                	li	a5,15
     fc6:	f6e7dee3          	bge	a5,a4,f42 <phase_3+0x15a>
     fca:	00000797          	auipc	a5,0x0
     fce:	38e78793          	addi	a5,a5,910 # 1358 <_IO_stdin_used+0x98>
     fd2:	639c                	ld	a5,0(a5)
     fd4:	fcf43823          	sd	a5,-48(s0)
     fd8:	fa042623          	sw	zero,-84(s0)
     fdc:	a8e9                	j	10b6 <phase_3+0x2ce>
     fde:	fac42783          	lw	a5,-84(s0)
     fe2:	2785                	addiw	a5,a5,1
     fe4:	2781                	sext.w	a5,a5
     fe6:	0007871b          	sext.w	a4,a5
     fea:	045da7b7          	lui	a5,0x45da
     fee:	f3b7879b          	addiw	a5,a5,-197 # 45d9f3b <__global_pointer$+0x45d673b>
     ff2:	02f707bb          	mulw	a5,a4,a5
     ff6:	2781                	sext.w	a5,a5
     ff8:	fa442703          	lw	a4,-92(s0)
     ffc:	8fb9                	xor	a5,a5,a4
     ffe:	fcf42423          	sw	a5,-56(s0)
    1002:	fc842783          	lw	a5,-56(s0)
    1006:	4e35                	li	t3,13
    1008:	01c7c7b3          	xor	a5,a5,t3
    100c:	00779293          	slli	t0,a5,0x7
    1010:	0037d313          	srli	t1,a5,0x3
    1014:	0062c7b3          	xor	a5,t0,t1
    1018:	8bbd                	andi	a5,a5,15
    101a:	fcf42423          	sw	a5,-56(s0)
    101e:	fac42783          	lw	a5,-84(s0)
    1022:	17c1                	addi	a5,a5,-16
    1024:	97a2                	add	a5,a5,s0
    1026:	fe07c783          	lbu	a5,-32(a5)
    102a:	0007871b          	sext.w	a4,a5
    102e:	fc842783          	lw	a5,-56(s0)
    1032:	8bbd                	andi	a5,a5,15
    1034:	2781                	sext.w	a5,a5
    1036:	8fb9                	xor	a5,a5,a4
    1038:	0007871b          	sext.w	a4,a5
    103c:	fac42783          	lw	a5,-84(s0)
    1040:	0027979b          	slliw	a5,a5,0x2
    1044:	2781                	sext.w	a5,a5
    1046:	2781                	sext.w	a5,a5
    1048:	8bb1                	andi	a5,a5,12
    104a:	2781                	sext.w	a5,a5
    104c:	fa442683          	lw	a3,-92(s0)
    1050:	00f6d7bb          	srlw	a5,a3,a5
    1054:	2781                	sext.w	a5,a5
    1056:	8bbd                	andi	a5,a5,15
    1058:	2781                	sext.w	a5,a5
    105a:	00002697          	auipc	a3,0x2
    105e:	fae68693          	addi	a3,a3,-82 # 3008 <phase_box>
    1062:	1782                	slli	a5,a5,0x20
    1064:	9381                	srli	a5,a5,0x20
    1066:	078a                	slli	a5,a5,0x2
    1068:	97b6                	add	a5,a5,a3
    106a:	439c                	lw	a5,0(a5)
    106c:	8fb9                	xor	a5,a5,a4
    106e:	2781                	sext.w	a5,a5
    1070:	8bbd                	andi	a5,a5,15
    1072:	fcf42623          	sw	a5,-52(s0)
    1076:	00000717          	auipc	a4,0x0
    107a:	2ea70713          	addi	a4,a4,746 # 1360 <_IO_stdin_used+0xa0>
    107e:	fcc42783          	lw	a5,-52(s0)
    1082:	97ba                	add	a5,a5,a4
    1084:	0007c703          	lbu	a4,0(a5)
    1088:	fac42783          	lw	a5,-84(s0)
    108c:	17c1                	addi	a5,a5,-16
    108e:	97a2                	add	a5,a5,s0
    1090:	fee78423          	sb	a4,-24(a5)
    1094:	fa442783          	lw	a5,-92(s0)
    1098:	00579293          	slli	t0,a5,0x5
    109c:	0027d313          	srli	t1,a5,0x2
    10a0:	0062c7b3          	xor	a5,t0,t1
    10a4:	03d78793          	addi	a5,a5,61
    10a8:	faf42223          	sw	a5,-92(s0)
    10ac:	fac42783          	lw	a5,-84(s0)
    10b0:	2785                	addiw	a5,a5,1
    10b2:	faf42623          	sw	a5,-84(s0)
    10b6:	fac42783          	lw	a5,-84(s0)
    10ba:	0007871b          	sext.w	a4,a5
    10be:	479d                	li	a5,7
    10c0:	f0e7dfe3          	bge	a5,a4,fde <phase_3+0x1f6>
    10c4:	fe040023          	sb	zero,-32(s0)
    10c8:	4785                	li	a5,1
    10ca:	fcf42223          	sw	a5,-60(s0)
    10ce:	f9843783          	ld	a5,-104(s0)
    10d2:	fd840713          	addi	a4,s0,-40
    10d6:	82be                	mv	t0,a5
    10d8:	833a                	mv	t1,a4
    10da:	43a1                	li	t2,8
    10dc:	0002ce03          	lbu	t3,0(t0) # 1000 <phase_3+0x218>
    10e0:	00034e83          	lbu	t4,0(t1)
    10e4:	01de1e63          	bne	t3,t4,1100 <phase_3+0x318>
    10e8:	0285                	addi	t0,t0,1
    10ea:	0305                	addi	t1,t1,1
    10ec:	13fd                	addi	t2,t2,-1
    10ee:	fe0397e3          	bnez	t2,10dc <phase_3+0x2f4>
    10f2:	0002ce03          	lbu	t3,0(t0)
    10f6:	000e1563          	bnez	t3,1100 <phase_3+0x318>
    10fa:	00000793          	li	a5,0
    10fe:	a011                	j	1102 <phase_3+0x31a>
    1100:	4785                	li	a5,1
    1102:	0001                	nop
    1104:	fcf42223          	sw	a5,-60(s0)
    1108:	fc442783          	lw	a5,-60(s0)
    110c:	873e                	mv	a4,a5
    110e:	00002797          	auipc	a5,0x2
    1112:	ed27b783          	ld	a5,-302(a5) # 2fe0 <__stack_chk_guard@GLIBC_2.27>
    1116:	fe843683          	ld	a3,-24(s0)
    111a:	639c                	ld	a5,0(a5)
    111c:	8fb5                	xor	a5,a5,a3
    111e:	4681                	li	a3,0
    1120:	c399                	beqz	a5,1126 <phase_3+0x33e>
    1122:	f1eff0ef          	jal	840 <__stack_chk_fail@plt>
    1126:	853a                	mv	a0,a4
    1128:	70a6                	ld	ra,104(sp)
    112a:	7406                	ld	s0,96(sp)
    112c:	6165                	addi	sp,sp,112
    112e:	8082                	ret

0000000000001130 <main>:
    1130:	1101                	addi	sp,sp,-32
    1132:	ec06                	sd	ra,24(sp)
    1134:	e822                	sd	s0,16(sp)
    1136:	1000                	addi	s0,sp,32
    1138:	00000517          	auipc	a0,0x0
    113c:	24050513          	addi	a0,a0,576 # 1378 <_IO_stdin_used+0xb8>
    1140:	f80ff0ef          	jal	8c0 <printf@plt>
    1144:	00002597          	auipc	a1,0x2
    1148:	f7458593          	addi	a1,a1,-140 # 30b8 <name_buffer>
    114c:	00000517          	auipc	a0,0x0
    1150:	24c50513          	addi	a0,a0,588 # 1398 <_IO_stdin_used+0xd8>
    1154:	edcff0ef          	jal	830 <__isoc99_scanf@plt>
    1158:	00002517          	auipc	a0,0x2
    115c:	f6050513          	addi	a0,a0,-160 # 30b8 <name_buffer>
    1160:	f10ff0ef          	jal	870 <strlen@plt>
    1164:	872a                	mv	a4,a0
    1166:	47a9                	li	a5,10
    1168:	00f70a63          	beq	a4,a5,117c <main+0x4c>
    116c:	00000517          	auipc	a0,0x0
    1170:	23450513          	addi	a0,a0,564 # 13a0 <_IO_stdin_used+0xe0>
    1174:	f2cff0ef          	jal	8a0 <puts@plt>
    1178:	57fd                	li	a5,-1
    117a:	aa2d                	j	12b4 <main+0x184>
    117c:	fe042623          	sw	zero,-20(s0)
    1180:	a891                	j	11d4 <main+0xa4>
    1182:	00002717          	auipc	a4,0x2
    1186:	f3670713          	addi	a4,a4,-202 # 30b8 <name_buffer>
    118a:	fec42783          	lw	a5,-20(s0)
    118e:	97ba                	add	a5,a5,a4
    1190:	0007c783          	lbu	a5,0(a5)
    1194:	873e                	mv	a4,a5
    1196:	02f00793          	li	a5,47
    119a:	02e7f063          	bgeu	a5,a4,11ba <main+0x8a>
    119e:	00002717          	auipc	a4,0x2
    11a2:	f1a70713          	addi	a4,a4,-230 # 30b8 <name_buffer>
    11a6:	fec42783          	lw	a5,-20(s0)
    11aa:	97ba                	add	a5,a5,a4
    11ac:	0007c783          	lbu	a5,0(a5)
    11b0:	873e                	mv	a4,a5
    11b2:	03900793          	li	a5,57
    11b6:	00e7fa63          	bgeu	a5,a4,11ca <main+0x9a>
    11ba:	00000517          	auipc	a0,0x0
    11be:	1e650513          	addi	a0,a0,486 # 13a0 <_IO_stdin_used+0xe0>
    11c2:	edeff0ef          	jal	8a0 <puts@plt>
    11c6:	57fd                	li	a5,-1
    11c8:	a0f5                	j	12b4 <main+0x184>
    11ca:	fec42783          	lw	a5,-20(s0)
    11ce:	2785                	addiw	a5,a5,1
    11d0:	fef42623          	sw	a5,-20(s0)
    11d4:	fec42783          	lw	a5,-20(s0)
    11d8:	0007871b          	sext.w	a4,a5
    11dc:	47a5                	li	a5,9
    11de:	fae7d2e3          	bge	a5,a4,1182 <main+0x52>
    11e2:	00000517          	auipc	a0,0x0
    11e6:	1de50513          	addi	a0,a0,478 # 13c0 <_IO_stdin_used+0x100>
    11ea:	eb6ff0ef          	jal	8a0 <puts@plt>
    11ee:	00002597          	auipc	a1,0x2
    11f2:	e6258593          	addi	a1,a1,-414 # 3050 <input_buffer>
    11f6:	00000517          	auipc	a0,0x0
    11fa:	1a250513          	addi	a0,a0,418 # 1398 <_IO_stdin_used+0xd8>
    11fe:	e32ff0ef          	jal	830 <__isoc99_scanf@plt>
    1202:	00002517          	auipc	a0,0x2
    1206:	e4e50513          	addi	a0,a0,-434 # 3050 <input_buffer>
    120a:	a3dff0ef          	jal	c46 <phase_1>
    120e:	87aa                	mv	a5,a0
    1210:	eb95                	bnez	a5,1244 <main+0x114>
    1212:	00000517          	auipc	a0,0x0
    1216:	1ee50513          	addi	a0,a0,494 # 1400 <_IO_stdin_used+0x140>
    121a:	e86ff0ef          	jal	8a0 <puts@plt>
    121e:	00002597          	auipc	a1,0x2
    1222:	e3258593          	addi	a1,a1,-462 # 3050 <input_buffer>
    1226:	00000517          	auipc	a0,0x0
    122a:	17250513          	addi	a0,a0,370 # 1398 <_IO_stdin_used+0xd8>
    122e:	e02ff0ef          	jal	830 <__isoc99_scanf@plt>
    1232:	00002517          	auipc	a0,0x2
    1236:	e1e50513          	addi	a0,a0,-482 # 3050 <input_buffer>
    123a:	af3ff0ef          	jal	d2c <phase_2>
    123e:	87aa                	mv	a5,a0
    1240:	e3b9                	bnez	a5,1286 <main+0x156>
    1242:	a809                	j	1254 <main+0x124>
    1244:	00000517          	auipc	a0,0x0
    1248:	1ec50513          	addi	a0,a0,492 # 1430 <_IO_stdin_used+0x170>
    124c:	e54ff0ef          	jal	8a0 <puts@plt>
    1250:	57fd                	li	a5,-1
    1252:	a08d                	j	12b4 <main+0x184>
    1254:	00000517          	auipc	a0,0x0
    1258:	20c50513          	addi	a0,a0,524 # 1460 <_IO_stdin_used+0x1a0>
    125c:	e44ff0ef          	jal	8a0 <puts@plt>
    1260:	00002597          	auipc	a1,0x2
    1264:	df058593          	addi	a1,a1,-528 # 3050 <input_buffer>
    1268:	00000517          	auipc	a0,0x0
    126c:	13050513          	addi	a0,a0,304 # 1398 <_IO_stdin_used+0xd8>
    1270:	dc0ff0ef          	jal	830 <__isoc99_scanf@plt>
    1274:	00002517          	auipc	a0,0x2
    1278:	ddc50513          	addi	a0,a0,-548 # 3050 <input_buffer>
    127c:	b6dff0ef          	jal	de8 <phase_3>
    1280:	87aa                	mv	a5,a0
    1282:	e395                	bnez	a5,12a6 <main+0x176>
    1284:	a809                	j	1296 <main+0x166>
    1286:	00000517          	auipc	a0,0x0
    128a:	20a50513          	addi	a0,a0,522 # 1490 <_IO_stdin_used+0x1d0>
    128e:	e12ff0ef          	jal	8a0 <puts@plt>
    1292:	57fd                	li	a5,-1
    1294:	a005                	j	12b4 <main+0x184>
    1296:	00000517          	auipc	a0,0x0
    129a:	22a50513          	addi	a0,a0,554 # 14c0 <_IO_stdin_used+0x200>
    129e:	e02ff0ef          	jal	8a0 <puts@plt>
    12a2:	4781                	li	a5,0
    12a4:	a801                	j	12b4 <main+0x184>
    12a6:	00000517          	auipc	a0,0x0
    12aa:	23250513          	addi	a0,a0,562 # 14d8 <_IO_stdin_used+0x218>
    12ae:	df2ff0ef          	jal	8a0 <puts@plt>
    12b2:	57fd                	li	a5,-1
    12b4:	853e                	mv	a0,a5
    12b6:	60e2                	ld	ra,24(sp)
    12b8:	6442                	ld	s0,16(sp)
    12ba:	6105                	addi	sp,sp,32
    12bc:	8082                	ret
