.data
	n: 			.asciiz	"n : "
	x1:			.asciiz "x1 :"
	y1: 		.asciiz "y1 :"
	x2: 		.asciiz "x2 :"
	y2:			.asciiz "y2 :"  
	zero:		.word	0
	Area:   	.float  0.0
	twoptzero:	.float 2.0
	
.text
.globl  main
.ent main
main:

	lw			$t9,zero
	
	addi		$t0, $t9, 1 #i=0
	
	li			$v0,4
	la			$a0,n
	syscall
	
	li			$v0,5
	syscall
	move		$t8,$v0
	
	li			$v0, 4
	la			$a0, x1
	syscall
	
	li			$v0, 5
	syscall
	move		$t1,$v0 #t1=x1
	
	li			$v0, 4
	la 			$a0, y1
	syscall
	
	li 			$v0, 5
	syscall
	move 		$t2,$v0 #t2=y1		
	
	while:

		bgt 	$t0, $t8, exit
		
		li		$v0, 4
		la		$a0, x2
		syscall
	
		li 		$v0, 5
		syscall
		move 	$t3,$v0 #t1=x2
	
		li 		$v0, 4
		la 		$a0, y2
		syscall
	
		li 		$v0, 5
		syscall
		
		move 	$t4,$v0 #t4=y2
		
		mul 	$t5,$t2,$t4 #t5=y1y2
			
		bgt 	$t5,$t9,area1
		blt		$t5,$t9,area4
		beq		$t5,$t9,area8
		
		after:
		
		addi	$t0, $t0, 1 #i++
		move 	$t1,$t3
		move	$t2,$t4
		
		j while
		
	exit:
		l.s 	$f12,Area
		li	    $v0,2
		syscall
	
	#End of program
	li 			$v0, 10
	syscall
	
area1:

	bgt 		$t2,$t9,area2
	blt 		$t2,$t9,area3
	after1:
		b after
	
area2:

	l.s			$f3,Area
	
	add 		$t6,$t2,$t4
	sub 		$t7,$t3,$t1
	
	l.s			$f2,twoptzero
	
	mtc1		$t6,$f4
	cvt.s.w		$f4,$f4 #f4=t6
	
	mtc1		$t7,$f6
	cvt.s.w		$f6,$f6 #f6=t7
	
	mul.s		$f8,$f4,$f6 #f8=f4*f6
	
	div.s 		$f10,$f8,$f2
	
	add.s		$f12,$f10,$f3
	
	s.s 		$f12,Area
	
	b 			after1
	
area3:

	add			$t6,$t2,$t4
	sub 		$t7,$t1,$t3
	
	l.s			$f2,twoptzero
	l.s			$f3,Area
	
	mtc1		$t6,$f4
	cvt.s.w		$f4,$f4 #f4=t6
	
	mtc1		$t7,$f6
	cvt.s.w		$f6,$f6 #f6=t7
	
	mul.s		$f8,$f4,$f6 #f8=f4*f6
	
	div.s 		$f10,$f8,$f2
	
	add.s		$f12,$f10,$f3
	
	s.s 		$f12,Area
	
	b 			after1
	
area4:

	bgt 		$t2,$t9,area6
	blt 		$t2,$t9,area7
	after2:
		b after
		
area6:
	
	l.s			$f2,twoptzero
	l.s			$f9,Area
	
	sub 		$t6,$t3,$t1
	sub			$t7,$t2,$t4
	
	mtc1		$t6,$f3
	cvt.s.w		$f3,$f3 #f3=t6
	
	mtc1		$t2,$f4
	cvt.s.w		$f4,$f4 #f4=t2
	
	mtc1		$t7,$f5
	cvt.s.w		$f5,$f5 #f5=t7
	
	mtc1		$t4,$f6
	cvt.s.w		$f6,$f6 #f6=t4
	
	mul.s		$f7,$f4,$f4 #f7=f4.f4
	
	mul.s		$f8,$f6,$f6 #f8=f6.f6
	
	add.s		$f8,$f8,$f7
	
	mul.s		$f10,$f3,$f8 #f10=f3.f8
	
	div.s		$f10,$f10,$f5
	
	div.s		$f10,$f10,$f2
	
	add.s		$f12,$f10,$f9	
	
	s.s			$f12,Area
	
	b			after2

area7:
	
	l.s			$f2,twoptzero
	l.s			$f9,Area
	
	sub 		$t6,$t3,$t1
	sub			$t7,$t4,$t2
	
	mtc1		$t6,$f3
	cvt.s.w		$f3,$f3 #f3=t6
	
	mtc1		$t2,$f4
	cvt.s.w		$f4,$f4 #f4=t2
	
	mtc1		$t7,$f5
	cvt.s.w		$f5,$f5 #f5=t7
	
	mtc1		$t4,$f6
	cvt.s.w		$f6,$f6 #f6=t4
	
	mul.s		$f7,$f4,$f4 #f7=f4.f4
	
	mul.s		$f8,$f6,$f6 #f8=f6.f6
	
	add.s		$f8,$f8,$f7
	
	mul.s		$f10,$f3,$f8 #f10=f3.f8
	
	div.s		$f10,$f10,$f5
	
	div.s		$f10,$f10,$f2
	
	add.s		$f12,$f10,$f9	
	
	s.s			$f12,Area
	
	b			after2
	
area8:

	bgt 		$t2,$t9,area9
	blt 		$t2,$t9,area10
	beq			$t2,$t9,area11
	after3:
		b		after
		
area9:

	l.s			$f2,twoptzero
	l.s			$f9,Area
	
	sub 		$t6,$t3,$t1
	
	mtc1		$t6,$f3
	cvt.s.w		$f3,$f3 #f3=t6
	
	mtc1		$t2,$f4
	cvt.s.w		$f4,$f4 #f4=t2
	
	mul.s  		$f5,$f4,$f3
	
	div.s		$f6,$f5,$f2
	
	add.s		$f12,$f6,$f9
	
	s.s			$f12,Area

	b			after3
	
area10:
	
	l.s			$f2,twoptzero
	l.s			$f9,Area
	
	sub 		$t6,$t1,$t3
	
	mtc1		$t6,$f3
	cvt.s.w		$f3,$f3 #f3=t6
	
	mtc1		$t2,$f4
	cvt.s.w		$f4,$f4 #f4=t2
	
	mul.s  		$f5,$f4,$f3
	
	div.s		$f6,$f5,$f2
	
	add.s		$f12,$f6,$f9
	
	s.s			$f12,Area

	b			after3
		
area11:
	
	bgt 		$t4,$t9,area12
	blt 		$t4,$t9,area13
	
	after4:
		b			after3
		
area12:

	l.s			$f2,twoptzero
	l.s			$f9,Area
	
	sub 		$t6,$t3,$t1
	
	mtc1		$t6,$f3
	cvt.s.w		$f3,$f3 #f3=t6
	
	mtc1		$t4,$f4
	cvt.s.w		$f4,$f4 #f4=t4
	
	mul.s  		$f5,$f4,$f3
	
	div.s		$f6,$f5,$f2
	
	add.s		$f12,$f6,$f9
	
	s.s			$f12,Area

	b			after4
	
area13:
	
	l.s			$f2,twoptzero
	l.s			$f9,Area
	
	sub 		$t6,$t1,$t3
	
	mtc1		$t6,$f3
	cvt.s.w		$f3,$f3 #f3=t6
	
	mtc1		$t4,$f4
	cvt.s.w		$f4,$f4 #f4=t4
	
	mul.s  		$f5,$f4,$f3
	
	div.s		$f6,$f5,$f2
	
	add.s		$f12,$f6,$f9
	
	s.s			$f12,Area

	b			after4
	
	
	

	